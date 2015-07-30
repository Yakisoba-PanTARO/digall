------------------------------------------------------------
-- Copyright (c) 2015 Yakisoba-PanTARO 
-- https://github.com/Yakisoba-PanTARO/digall
------------------------------------------------------------

-- 再帰的なnode_digの呼び出しで特定のコールバックを除く
-- 方法が思いつかないのでフラグを立てるという原始的な
-- やり方で解決することとする。
-- プレーヤー毎のフラグを立てていないので完全にシングル用
-- である。
-- マルチに対応させるにはplayerの名前とフラグのリストを作って
-- やれば簡単に出来ると思う。
local switch = true

minetest.register_on_dignode(function(pos, oldnode, digger)
      if not digall.switch then
         return
      end
      if switch then
         -- Node has not registered yet.
         if not digall.registered_targets[oldnode.name] then
            return
         end
         -- !!! 取り扱いには要注意 !!! --
         switch = false
         local algorithm_name =
            digall.registered_targets[oldnode.name].algorithm_name
         local algorithm = digall.registered_algorithms[algorithm_name]
         local args = digall.registered_targets[oldnode.name].args
         if not args then
            algorithm(pos, oldnode, digger)
         else
            algorithm(pos, oldnode, digger, unpack(args))
         end
         switch = true
         -- !!! 取り扱いには要注意 !!! --
      end
end)
