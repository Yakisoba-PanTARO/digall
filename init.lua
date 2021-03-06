------------------------------------------------------------
-- Copyright (c) 2015 Yakisoba-PanTARO
-- https://github.com/Yakisoba-PanTARO/digall
------------------------------------------------------------

digall = {}

-- digallの対象となるノードとアルゴリズムの情報を保持する。
-- 各情報はテーブルで管理され以下の構造を持つ。
-- digall.registered_targets[ターゲットのノード名] = {
--    algorithm_name, ... 掘るアルゴリズムの名前
--    args, ... 掘るアルゴリズムに渡す引数値のリスト(適用時アンパック)
-- }
-- また上記アルゴリズムはdigall.registered_algorithmに登録さ
-- れているものでなければならない。
digall.registered_targets = {}

-- 掘るアルゴリズムの情報を保持するテーブル。
-- 各情報はテーブルで管理され以下の構造を持つ。
-- digall.registered_algorithms[アルゴリズム名] = {
--    description, ... 説明
--    default_args, ... デフォルトの引数値
--    func, ... function(pos, oldnode, digger, 可変長引数)
-- }
digall.registered_algorithms = {}

-- digall全体のon/offを切り替えるフラグ
digall.switch = true

------------------------------------------------------------
local modpath = minetest.get_modpath("digall")

dofile(modpath.."/api.lua")
dofile(modpath.."/common.lua")
dofile(modpath.."/algorithms.lua")
dofile(modpath.."/chatcommands.lua")
