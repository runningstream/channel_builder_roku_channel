#!/usr/bin/env python3

import time
import socket

SLEEP_TIME=.3

def press_ro(sock, key):
    sock.send(f"press {key}\n".encode())
    time.sleep(SLEEP_TIME)
    s.recv(1024)

def type_ro(sock, text):
    sock.send(f"type {text}\n".encode())
    time.sleep(SLEEP_TIME * len(text))
    s.recv(1024)

if __name__ == "__main__":
    ip = "192.168.86.31"
    port = 8080
    username = "runningstreamllc+test10@gmail.com"
    password = "12345"

    logout = False

    with socket.create_connection((ip, port)) as s:
        s.recv(1024)

        if logout:
            press_ro(s, "i")
            press_ro(s, "s")
            time.sleep(4)
            press_ro(s, "s")
            time.sleep(4)

        press_ro(s, "s")
        type_ro(s, username)
        press_ro(s, "d")
        press_ro(s, "d")
        press_ro(s, "d")
        press_ro(s, "d")
        press_ro(s, "s")
        type_ro(s, password)
        press_ro(s, "d")
        press_ro(s, "d")
        press_ro(s, "d")
        press_ro(s, "d")
        press_ro(s, "s")
        print("Done")


