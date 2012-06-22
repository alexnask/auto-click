import structs/ArrayList
import text/Opts
import Task, Mouse

printUsage: func {
    "Ok so here is a little help on how to use the program :)" println()
    "You need to pass a tasks option (like so: -tasks=n) which will tell the program how many tasks you want to execute" println()
    "Then, for each one of these tasks (from 1 to n), you need to pass a t[taskNumber] option" println()
    "This contains a JSON object that must contain the fields button, x, y and interval" println()
    "E.g. -t1=\"{ \\\"button\\\" : \\\"left\\\", \\\"x\\\" : \\\"312\\\", \\\"y\\\" : \\\"310\\\", \\\"interval\\\" : \\\"500\\\" }\"" println()
    "The interval is counted in milliseconds ;)" println()
    "Have fun!" println()
}

main: func(args: ArrayList<String>) -> Int {
    // Example usage:
    // auto-click -tasks=2 -t1={button: "right", x: "100", y: "0", interval: "2000"} -t2={button: "left", x: "400", y: "300", interval: "1000"}
    options := Opts new(args)
    if(!options set?("tasks")) {
        "Entering coordinate mode" println()
        while(true) {
            (x, y) := Mouse coords()
            "x = %d, y = %d" format(x, y) println()
        }
    } else {
        taskN := options get("tasks") toInt()
        taskList := ArrayList<Task> new(taskN)

        for(i in 1 .. taskN+1) {
            if(!options set?("t%d" format(i))) {
                printUsage()
                return 1
            }
        }

        for(i in 1 .. taskN+1) {
            // Construct tasks
            taskList add(Task new(options get("t%d" format(i))))
        }

        for(i in 0 .. taskN) {
            // Launch tasks
            taskList get(i) launch()
        }
        // Block us to avoid closing the program and let the tasks do their thing
        taskList last() wait()
    }
    0
}
