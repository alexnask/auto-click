include ./utils

Button: enum {
    left = 1,
    middle = 2,
    right = 3
}

Mouse: class {
    move: extern(move) static func(x, y: Int)
    click: extern(click) static func(button: Button)

    // Interesting fact: Tuple return types are implemented as hidden pointer arguments in ooc so you can do that ;D
    coords: extern(coords) static func -> (Int, Int)
}

