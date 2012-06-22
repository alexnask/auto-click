import threading/Thread
import text/json
import structs/HashBag
import os/Time
import Mouse

Task: class {
    thread: Thread

    init: func(text: String) {
        bag := JSON parse(text)
        //{button: "right", x: "100", y: "0", interval: "2000"}
        interval := bag get("interval", String) toInt()
        button := match (bag get("button", String)) {
            case "left"   => Button left
            case "right"  => Button right
            case "middle" => Button middle
            case          => Button left // default to left click
        }
        (x, y) := (bag get("x", String) toInt(), bag get("y", String) toInt())

        thread = Thread new(||
            // Used as a timer to get the interval from the last click
            while(true) {
                // Get the current mouse coordinates
                (currX, currY) := Mouse coords()
                // Move the mouse to the click coordinates and... click!
                Mouse move(x, y) . click(button)
                // Finally, restore the mouse to its original coordinates
                Mouse move(currX, currY)
                // Wait the time of the interval for the next click
                Time sleepMilli(interval)
            }
        )
    }

    launch: func {
        thread start()
    }

    wait: func {
        thread wait()
    }
}
