------------------------------------------------------------
-- Copyright (c) 2015 Yakisoba-PanTARO 
-- https://github.com/Yakisoba-PanTARO/digall
------------------------------------------------------------

-- 設定ファイルの読み込み
local worldpath = minetest.get_worldpath()
local config_file = io.open(worldpath.."/digall_config.txt", "r")
if config_file then
   digall.registered_targets =
      minetest.deserialize(config_file:read("*all"))
   config_file:close()
else
   -- 全てのMOD読み込み後に設定する。
   minetest.after(
      0, function()
         digall.set_default_target_setting()
   end)
end


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
         local wielded_item = digger:get_wielded_item()
         local algorithm_name =
            digall.registered_targets[oldnode.name].algorithm_name
         local algorithm = digall.registered_algorithms[algorithm_name]
         local args = digall.registered_targets[oldnode.name].args
         if not args then
            algorithm(pos, oldnode, digger)
         else
            algorithm(pos, oldnode, digger, unpack(args))
         end
         -- ツールアイテムなら耐久値復活
         if minetest.registered_tools[wielded_item:get_name()] then
            print("KOKO")
            -- もし途中で耐久値が切れて他のアイテムがwielded_itemに
            -- なっていた場合はそれを除去して復活させる。
            -- 除去したアイテムはinventoryに追加する。
            local wielded_item2 = digger:get_wielded_item()
            if wielded_item2:get_name() ~= wielded_item:get_name() then
               digger:set_wielded_item(wielded_item)
               local inv = digger:get_inventory()
               inv:add_item("main", wielded_item2)
               --minetest.item_drop(wielded_item2, digger, pos)
            end
            digger:set_wielded_item(wielded_item)
         end
         switch = true
         -- !!! 取り扱いには要注意 !!! --
      end
end)

-- シャットダウン時設定保存
minetest.register_on_shutdown(function()
         local config_file
            = io.open(worldpath.."/digall_config.txt", "w")
         config_file:write(
            minetest.serialize(digall.registered_targets))
         config_file:close()
end)
