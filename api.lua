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
   digall.registered_targets[nodename] = {
      algorithm_name = algorithm_name,
      args = args,
   }
end

function digall.remove_target(nodename)
   digall.registered_targets[nodename] = nil
end

function digall.register_algorithm(algorithm_name, func)
   digall.registered_algorithms[algorithm_name] = func
end

function digall.set_default_target_setting()
   for nodename, nodedef in pairs(minetest.registered_nodes) do
      if nodedef.drawtype == "normal" then
         if minetest.get_item_group(nodename, "tree") > 0 then
            digall.register_target(
               nodename, "default_algorithm_for_tree")
         else
            digall.register_target(
               nodename, "default_algorithm", {{x=3, y=3, z=3}})
         end
      end
   end
end

function digall.clear_target_setting()
   for key, _ in pairs(digall.registered_targets) do
      digall.registered_targets[key] = nil
   end
end
