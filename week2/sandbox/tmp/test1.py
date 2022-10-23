#!/usr/bin/env python3

def nameprint():
    print(__name__)

if __name__ == "__main__":
    print("HI")
    nameprint()
else:
    # do something only when we are loaded as a module
    print("HELLOOOOOOOO")
