import socket
import json
import threading
from control import mouse_controller as mouse
from control import keyboard_controller as keyboard
from control import volume_controller as volume

HOST = '0.0.0.0'  # ascolta su tutte le interfacce di rete
PORT = 5050       # porta scelta arbitraria

def handle_client(conn, addr):
    print(f"[+] Connessione da {addr}")
    with conn:
        while True:
            try:
                data = conn.recv(1024)
                if not data:
                    break
                command = json.loads(data.decode('utf-8'))
                handle_command(command)
            except Exception as e:
                print(f"[!] Errore: {e}")
                break
    print(f"[-] Disconnessione da {addr}")

def handle_command(cmd):
    action = cmd.get('action')

    if action == 'mouse_move':
        dx, dy = cmd['dx'], cmd['dy']
        mouse.move(dx, dy)

    elif action == 'mouse_click':
        mouse.click()

    elif action == 'scroll':
        mouse.scroll(cmd['dy'])

    elif action == 'type':
        keyboard.type_text(cmd['text'])

    elif action == 'press':
        keyboard.press_key(cmd['key'])

    elif action == 'volume':
        volume.change_volume(cmd['delta'])

    else:
        print(f"[?] Comando sconosciuto: {cmd}")

def start_server():
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind((HOST, PORT))
        s.listen()
        print(f"[✓] Server in ascolto su {HOST}:{PORT}")
        while True:
            conn, addr = s.accept()
            threading.Thread(target=handle_client, args=(conn, addr), daemon=True).start()

if __name__ == "__main__":
    start_server()