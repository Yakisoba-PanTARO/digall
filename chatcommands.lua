------------------------------------------------------------
-- Copyright (c) 2015 Yakisoba-PanTARO 
-- https://github.com/Yakisoba-PanTARO/digall
------------------------------------------------------------

-- 本当はformspecで設定できるのが一番いいんだけど
-- すごく面倒臭いのでやりません。

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

-- ここできてない
minetest.register_chatcommand(
   "digall:register_target", {
      params = "<nodename>,<algorithm_name>,<args>",
      description = "Register target information",
      func = function(nodename, algorithm_name, args)
         digall.register_target(nodename, algorithm_name, args)
         return true, "Done."
      end,
})
