import AppKit
import HotKey

func main() {
    let hotKey = HotKey(key: .space, modifiers: [.option])
    hotKey.keyDownHandler = {
        NSWorkspace.shared.launchApplication("Alacritty")
    }

    NSApplication.shared.run()
}

main()
