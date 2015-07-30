------------------------------------------------------------
-- Copyright (c) 2015 Yakisoba-PanTARO 
-- https://github.com/Yakisoba-PanTARO/digall
------------------------------------------------------------

-- 本当はformspecで設定できるのが一番いいんだけど
-- すごく面倒臭いのでやりたくありません。

minetest.register_chatcommand(
   "digall:on", {
      description = "Enable digall",
      func = function()
         digall.on()
         return true, "Done."
      end,
})

minetest.register_chatcommand(
   "digall:off", {
      description = "Disable digall",
      func = function()
         digall.off()
         return true, "Done."
      end,
})

minetest.register_chatcommand(
   "digall:remove_target", {
      description = "Remove target",
      func = function(target_name)
         digall.remove_target(target_name)
         return true, "Done."
      end,
})

minetest.register_chatcommand(
   "digall:register_target", {
      params = "<nodename>,<algorithm_name>,<args>",
      description = "Register target information",
      func = function(name, param)
         local params = string.split(param, " ")
         params[3] = minetest.deserialize("return "..params[3])
         digall.register_target(params[1], params[2], params[3])
         return true, "Done."
      end,
})

minetest.register_chatcommand(
   "digall:set_default_target_setting", {
      description = "Set default target setting",
      func = function()
         digall.set_default_target_setting()
         return true, "Done."
      end,
})

minetest.register_chatcommand(
   "digall:clear_target_setting", {
      description = "Clear target setting",
      func = function()
         digall.clear_target_setting()
         return true, "Done."
      end,
})
