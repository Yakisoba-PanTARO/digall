------------------------------------------------------------
-- Copyright (c) 2015 Yakisoba-PanTARO 
-- https://github.com/Yakisoba-PanTARO/digall
------------------------------------------------------------

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
      func = function(_, target_name)
         digall.remove_target(target_name)
         return true, "Done."
      end,
})

minetest.register_chatcommand(
   "digall:register_target", {
      params = "<nodename> <algorithm_name> <args>",
      description = "Register target information",
      func = function(name, param)
         local params = string.split(param, " ")
         if #params > 3 then
            for i = 4, #params do
               params[3] = params[3].." "..params[i]
            end
         end
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

minetest.register_chatcommand(
   "digall:set_default_range", {
      params = "<range>",
      description = "Set default algorithm range",
      func = function(name, range)
         digall.set_default_range(minetest.deserialize("return "..range))
         return true, "Done"
      end,
})
   
