from pynput.keyboard import Controller, Key

keyboard = Controller()

def type_text(text):
    keyboard.type(text)

def press_key(key_str):
    try:
        key = getattr(Key, key_str)
    except AttributeError:
        key = key_str
    keyboard.press(key)
    keyboard.release(key)