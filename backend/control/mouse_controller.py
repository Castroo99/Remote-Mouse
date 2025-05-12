from pynput.mouse import Controller

mouse = Controller()

def move(dx, dy):
    mouse.move(dx, dy)

def click():
    mouse.click()

def scroll(dy):
    mouse.scroll(0, dy)