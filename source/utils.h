#ifndef UTILS_H
#define UTILS_H
#include <stdio.h>
#include <string.h>
#include <X11/Xlib.h>

void click_with_display(Display *display, int button);
void move_with_display(Display *display, int x, int y);
void coords_with_display(Display *display, int *x, int *y);
Display *get_default_display();

void click(int button);
void move(int x, int y);
void coords(int *x, int *y);

#endif//UTILS_H
