#include "utils.h"

// Functions with display

// Simulate mouse click
void click_with_display(Display *display, int button) {
    // Create and setting up the event
    XEvent event;
    memset(&event, 0, sizeof(event));
    event.xbutton.button = button;
    event.xbutton.same_screen = True;
    event.xbutton.subwindow = DefaultRootWindow(display);
    while(event.xbutton.subwindow) {
        event.xbutton.window = event.xbutton.subwindow;
        XQueryPointer(display, event.xbutton.window,
	        &event.xbutton.root, &event.xbutton.subwindow,
	        &event.xbutton.x_root, &event.xbutton.y_root,
	        &event.xbutton.x, &event.xbutton.y,
	        &event.xbutton.state);
    }
    // Press
    event.type = ButtonPress;
    if(XSendEvent(display, PointerWindow, True, ButtonPressMask, &event) == 0)
        fprintf(stderr, "Error sending the click event!\n");
    XFlush(display);
    // Release
    event.type = ButtonRelease;
    if(XSendEvent(display, PointerWindow, True, ButtonReleaseMask, &event) == 0)
        fprintf(stderr, "Error sending the click event!\n");
    XFlush(display);
}

// Move mouse pointer
void move_with_display(Display *display, int x, int y) {
    Window root_window = XRootWindow(display, 0);
    XSelectInput(display, root_window, KeyReleaseMask);
    XWarpPointer(display, None, root_window, 0,0,0,0, x, y);
    XSync(display, False);
    XFlush(display);
}

// Get mouse coordinates
void coords_with_display(Display *display, int *x, int *y) {
    XEvent event;
    XQueryPointer(display, DefaultRootWindow(display),
                   &event.xbutton.root, &event.xbutton.window,
                   &event.xbutton.x_root, &event.xbutton.y_root,
                   &event.xbutton.x, &event.xbutton.y,
                   &event.xbutton.state);
    *x = event.xbutton.x;
    *y = event.xbutton.y;
}

Display *get_default_display() {
    return XOpenDisplay(NULL);
}

// Functions with no display

void click(int button) {
    Display *display = get_default_display();
    click_with_display(display, button);
    XCloseDisplay(display);
}

void move(int x, int y) {
    Display *display = get_default_display();
    move_with_display(display, x, y);
    XCloseDisplay(display);
}

void coords(int *x, int *y) {
    Display *display = get_default_display();
    coords_with_display(display, x, y);
    XCloseDisplay(display);
}

