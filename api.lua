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
   table.remove(digall.registered_targets, nodename)
end

function digall.register_algorithm(algorithm_name, func)
   digall.registered_algorithms[algorithm_name] = func
end

