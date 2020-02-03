import AppKit
import HotKey

func main() {
    let hotKey = HotKey(key: .space, modifiers: [.option])
    hotKey.keyDownHandler = {
        let workspace = NSWorkspace.shared
        if workspace.frontmostApplication?.bundleIdentifier == "io.alacritty" {
            workspace.launchApplication("Emacs")
        } else {
            workspace.launchApplication("Alacritty")
        }
    }

    NSApplication.shared.run()
}

main()
