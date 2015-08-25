------------------------------------------------------------
-- Copyright (c) 2015 Yakisoba-PanTARO 
-- https://github.com/Yakisoba-PanTARO/digall
------------------------------------------------------------

-- digall自体では以下の２つのアルゴリズムを提供する。
-- 一つは範囲付き連結ノードの一斉破壊、もうひとつは範囲なし
-- 連結ノードの一斉破壊である。

local directions = {
   { x =  0, y =  0, z = -1 },
   { x =  0, y =  0, z =  1 },
   { x =  0, y = -1, z =  0 },
   { x =  0, y =  1, z =  0 },
   { x = -1, y =  0, z =  0 },
   { x =  1, y =  0, z =  0 },
}

-- 再利用性を考えて公開する。
-- limiting_prebには第一、第二、第五引数にdigall.default_algorithm_implに渡された
-- 第一、第二、第三引数が渡される。
-- 第三、第四引数には隣接するノードの位置とそのノードが渡される。
function digall.default_algorithm_impl(pos, node, digger, limiting_prev)
   for _, dir in ipairs(directions) do
      local pos2 = vector.add(pos, dir)
      local node2 = minetest.get_node(pos2)
      if limiting_prev(pos, node, pos2, node2, digger) then
         minetest.node_dig(pos2, node2, digger)
         digall.default_algorithm_impl(pos2, node2, digger, limiting_prev)
      end
   end
end

------------------------------------------------------------
local function default_algorithm(pos, node, digger, range)
   digall.default_algorithm_impl(
      pos, node, digger, function(pos1, node1, pos2, node2, digger)
         if (node1.name == node2.name             and
             math.abs(pos.x - pos2.x) <= range.x  and
             math.abs(pos.y - pos2.y) <= range.y  and
             math.abs(pos.z - pos2.z) <= range.z) then
            return true
         end
         return false
   end)
end

------------------------------------------------------------
local function default_algorithm_without_range(pos, node, digger)
   digall.default_algorithm_impl(
      pos, node, digger, function(pos1, node1, pos2, node2, digger)
         return node1.name == node2.name
   end)
end

------------------------------------------------------------
digall.register_algorithm(
   "digall:default", {
      description = "Default Algorithm",
      default_args = {{x = 3, y = 3, z = 3}},
      func = default_algorithm,
})

digall.register_algorithm(
   "digall:default_without_range", {
      description = "Default Algorithm Without Range",
      func = default_algorithm_without_range,
})
                                
