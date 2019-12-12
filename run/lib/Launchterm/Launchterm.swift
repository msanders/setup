import AppKit
import Carbon

final class HotKeyListener {
    init(keyCode: Int, modifiers: Int) {
        self.keyCode = keyCode
        self.modifiers = modifiers
    }

    func bind(_ block: @escaping () -> Void) {
        let eventHandlerBlock: EventHandlerUPP = { _, _, ptr -> OSStatus in
            if let ptr = ptr {
                UnsafePointer<() -> Void>(OpaquePointer(ptr)).pointee()
                return noErr
            }
            return 1
        }

        var eventType = EventTypeSpec(eventClass: OSType(kEventClassKeyboard),
                                      eventKind: UInt32(kEventHotKeyPressed))
        let hotKeyID = EventHotKeyID(signature: 0, id: 1)
        let ptr = UnsafeMutablePointer<() -> Void>.allocate(capacity: 1)
        ptr.initialize(to: block)

        unbind()
        InstallEventHandler(GetApplicationEventTarget(), eventHandlerBlock, 1,
                            &eventType, ptr, &eventHandler)
        RegisterEventHotKey(UInt32(keyCode), UInt32(modifiers), hotKeyID,
                            GetApplicationEventTarget(), OptionBits(0), &hotKey)
    }

    func unbind() {
        if let hotKey = hotKey {
            UnregisterEventHotKey(hotKey)
        }
        if let eventHandler = eventHandler {
            RemoveEventHandler(eventHandler)
        }
    }

    deinit {
        unbind()
    }

    private let keyCode: Int
    private let modifiers: Int
    private var hotKey: EventHotKeyRef?
    private var eventHandler: EventHandlerRef?
}

func main() {
    let listener = HotKeyListener(keyCode: kVK_Space, modifiers: optionKey)
    listener.bind {
        NSWorkspace.shared.launchApplication("Terminal")
    }

    NSApplication.shared.run()
}

main()
