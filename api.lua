------------------------------------------------------------
-- Copyright (c) 2015 Yakisoba-PanTARO 
-- https://github.com/Yakisoba-PanTARO/digall
------------------------------------------------------------

function digall.on()
   digall.switch = true
end

function digall.off()
   digall.switch = false
end

function digall.register_target(nodename, algorithm_name, args)
   if args then
      digall.registered_targets[nodename] = {
         algorithm_name = algorithm_name,
         args = args,
      }
   else
      digall.registered_targets[nodename] = {
         algorithm_name = algorithm_name,
         args = digall.registered_algorithms[algorithm_name].default_args,
      }
      if not digall.registered_algorithms[algorithm_name].default_args then
         print("KOKOKOKOKOOOOO")
      end
   end
end

function digall.remove_target(nodename)
   digall.registered_targets[nodename] = nil
end

function digall.register_algorithm(algorithm_name, def)
   digall.registered_algorithms[algorithm_name] = def
end

function digall.set_default_target_setting()
   for nodename, nodedef in pairs(minetest.registered_nodes) do
      if nodedef.drawtype == "normal" then
         if minetest.get_item_group(nodename, "tree") > 0 then
            digall.register_target(nodename, "digall:default_for_tree")
         else
            digall.register_target(nodename, "digall:default")
         end
      end
   end
end

function digall.clear_target_setting()
   for key, _ in pairs(digall.registered_targets) do
      digall.registered_targets[key] = nil
   end
end

function digall.set_default_range(range)
   for nodename, def in pairs(digall.registered_targets) do
      if def.algorithm_name == "digall:default" then
         def.args = range
      end
   end
end
