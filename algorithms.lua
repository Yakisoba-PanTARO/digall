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

------------------------------------------------------------
local function default_algorithm_sub
   (pos, node, digger, range, original_pos)
   for _, dir in ipairs(directions) do
      local pos2 = {
         x = pos.x + dir.x,
         y = pos.y + dir.y,
         z = pos.z + dir.z,
      }
      local node2 = minetest.get_node(pos2)
      if (node2.name == node.name and
          (math.abs(original_pos.x - pos2.x) <= range.x) and
          (math.abs(original_pos.y - pos2.y) <= range.y) and
          (math.abs(original_pos.z - pos2.z) <= range.z)) then
         minetest.node_dig(pos2, node2, digger)
         default_algorithm_sub(pos2, node2, digger, range, original_pos)
      end
   end
end

local function default_algorithm(pos, node, digger, range)
   default_algorithm_sub(pos, node, digger, range, pos)
end

------------------------------------------------------------
local function default_algorithm_for_tree(pos, node, digger)
   for _, dir in ipairs(directions) do
      local pos2 = {
         x = pos.x + dir.x,
         y = pos.y + dir.y,
         z = pos.z + dir.z,
      }
      local node2 = minetest.get_node(pos2)
      if node2.name == node.name then
         minetest.node_dig(pos2, node2, digger)
         default_algorithm_for_tree(pos2, node2, digger)
      end
   end
end

------------------------------------------------------------
digall.register_algorithm(
   "digall:default", default_algorithm)

digall.register_algorithm(
   "digall:default_for_tree", default_algorithm_for_tree)
                                
