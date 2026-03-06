#!/usr/bin/env python3
"""
Mouse → Keyboard - Versión con Q y W para testing
"""

import evdev
from evdev import UInput, ecodes
import sys

MOUSE_DEVICE = "/dev/input/event6"

def create_virtual_keyboard():
    """Crea un teclado virtual"""
    capabilities = {
        ecodes.EV_KEY: list(range(1, 256)),
        ecodes.EV_LED: [ecodes.LED_NUML, ecodes.LED_CAPSL, ecodes.LED_SCROLLL],
        ecodes.EV_MSC: [ecodes.MSC_SCAN],
    }

    ui = UInput(
        capabilities,
        name='mouse-buttons-keyboard',
        vendor=0x1234,
        product=0x5678,
        version=1,
        bustype=ecodes.BUS_USB
    )
    print("✓ Teclado virtual creado: mouse-buttons-keyboard")
    return ui

def monitor_and_inject():
    """Lee mouse e inyecta Q y W"""
    try:
        mouse = evdev.InputDevice(MOUSE_DEVICE)
        print(f"📡 Monitoreando mouse: {mouse.name}")
        print(f"   Path: {MOUSE_DEVICE}")

        keyboard = create_virtual_keyboard()

        # USAR ç y + (teclas que detectaste con xev)
        button_to_keycode = {
            275: 51,  # SIDE → ç
            276: 21,  # EXTRA → + (puede ser 21 o 35 según tu teclado)
        }

        print("\n✓ Configuración:")
        print("  Botón SIDE → ç (código 51)")
        print("  Botón EXTRA → + (código 21)")
        print("\n🎯 JSON debe tener:")
        print("  smb1: \"code\": 51, \"type\": 1")
        print("  smb2: \"code\": 21, \"type\": 1")
        print("\n🔍 Abre Kate y presiona los botones - deberían escribir 'q' y 'w'")
        print()

        for event in mouse.read_loop():
            if event.type == ecodes.EV_KEY:
                if event.value == 1:
                    print(f"🔍 DEBUG: Evento mouse code={event.code} value={event.value}")

                if event.code in button_to_keycode:
                    keycode = button_to_keycode[event.code]
                    button_name = "SIDE" if event.code == 275 else "EXTRA"
                    action = "PRESS" if event.value == 1 else "RELEASE"
                    key_name = "ç" if event.code == 275 else "+"

                    keyboard.write(ecodes.EV_KEY, keycode, event.value)
                    keyboard.syn()

                    print(f"🖱️ → ⌨️  {button_name} {action} → {key_name}")

                    if event.value == 1:
                        print(f"      ✓ Inyectado (código {keycode})")

    except PermissionError:
        print(f"❌ Sin permisos para {MOUSE_DEVICE}")
        print("Ejecuta: sudo chmod 666 /dev/input/event6")
        sys.exit(1)
    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    print("=== Mouse → Keyboard (Numpad 7/8) ===\n")
    monitor_and_inject()
