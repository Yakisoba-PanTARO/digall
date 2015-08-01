# DIGALL

## 概要
DIGALLはMinetest用の一括破壊系MODです。

## API
### GLOBAL VARIABLES
|名前|機能|
|:--|:--|
|digall.switch|digallのon/offを表す|
|digall.registered_targets|登録されているターゲット情報|
|digall.registered_algorithms|登録されているアルゴリズム|
### GLOBAL FUNCTIONS
|名前|機能|
|:--|:--|
|digall.on|digallを有効にする|
|digall.off|digallを無効にする|
|digall.register_target|ターゲットを登録する|
|digall.register_algorithm|アルゴリズムを登録する|
|digall.set_default_target_setting|デフォルト値に設定する|
|digall.clear_target_setting|ターゲットの設定をクリアする|
|digall.set_default_range|digall:defaultの範囲を一斉に変更|

## 関連MOD
- Minetest JPの管理人RuiさんがFormspecで設定出来るようにしてくださいました。  
[digall_gui](https://github.com/Rui914/digall_gui)
- digallの掘るアルゴリズムを追加する拡張MODです。  
[digall_plus](https://github.com/Yakisoba-PanTARO/digall_plus)  