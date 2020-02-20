;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to
;; run 'doom sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG
;; configuration, email clients, file templates and snippets.
(setq user-full-name "Michael Sanders"
      user-mail-address "michael.sanders@fastmail.com")

;; Doom exposes five (optional) variables for controlling fonts in
;; Doom. Here are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"),
;; or xlfd font string. You generally only need these two:
(setq doom-font (font-spec :family "Fira Mono" :size 16))

;; There are two ways to load a theme. Both assume the theme is
;; installed and available. You can either set `doom-theme' or
;; manually load a theme with the `load-theme' function. This is the
;; default:
(setq doom-theme 'doom-Iosvkem)

;; If you use `org' and don't want your org files in the default
;; location below, change `org-directory'. It must be set before org
;; loads!
(setq org-directory "~/Dropbox/Org/")

;; This determines the style of line numbers in effect. If set to
;; `nil', line numbers are disabled. For relative line numbers, set
;; this to `relative'.
(setq display-line-numbers-type nil)

;; Use replacement dashboard banner file.
(setq +doom-dashboard-banner-file
      (expand-file-name "emacs.png"
                        (expand-file-name "banners" doom-private-dir)))

;; Disable bold fonts.
(setq doom-themes-enable-bold nil)

;; Switch back to default title.
(setq frame-title-format '("%b – Emacs")
      icon-title-format frame-title-format)

;; Start out in non-native full screen.
(setq initial-frame-alist '((fullscreen . fullboth)))

;; Allow using right option key to input special characters.
(setq mac-right-option-modifier 'none)

;; Enable jump to source for elisp functions.
(setq find-function-C-source-directory "~/src/etc/emacs/src")

;; Use fd to escape from insert mode.
(setq evil-escape-key-sequence "fd")

;; Ruby settings.
(setq
 ;; Disable insertion of encoding comment at top of files.
 ruby-insert-encoding-magic-comment nil

 ;; Disable "deep" indentation, i.e. don't try to align arguments and
 ;; closures.
 enh-ruby-deep-indent-construct nil
 enh-ruby-deep-indent-paren nil)

;; Set appropriate values for `fill-column'.
(setq-default fill-column 79)
(setq-hook! (fish-mode js2-mode rustic-mode swift-mode)
  comment-fill-column 79
  fill-column 100)
(setq-hook! emacs-lisp-mode
  fill-column 70)

;; Add support for automatically highlighting long lines.
(setq whitespace-style '(face trailing lines-tail)
      whitespace-line-column 80)

;; The `whitespace-line-column' variable must be set before activating
;; `whitespace-mode'. See https://stackoverflow.com/a/11444423
(add-hook! prog-mode
  (when (memq major-mode '(fish-mode js2-mode rustic-mode swift-mode))
    (setq-local whitespace-line-column 100))
  (whitespace-mode t))

;; Treat underscores as part of word.
(modify-syntax-entry ?_ "w")

(after! ivy
  (define-key! ivy-minibuffer-map
    ;; Enable fish-style forward completion.
    "C-f" #'ivy-alt-done

    ;; Use RET for continuing completion for a directory, as in ido.
    [return] #'ivy-alt-done)

  (setq
   ;; Allow using / to auto-complete.
   ivy-magic-slash-non-match-action 'ivy-magic-slash-non-match-cd-selected

   ;; Require full ~/ to navigate home.
   ivy-magic-tilde nil

   ;; Enable recent files in switch-buffer.
   ivy-use-virtual-buffers t

   ;; Abbreviate buffer list by default.
   ivy-rich-path-style 'abbrev
   ivy-virtual-abbreviate 'abbreviate))

(map!
 ;; Use command-return to toggle non-native fullscreen.
 :gn [s-return] #'toggle-frame-fullscreen

 ;; Use command-{ & command-} to switch between tabs.
 :gn "s-}" #'+workspace/switch-right
 :gn "s-{" #'+workspace/switch-left

 ;; Use f2 to toggle option-as-meta behavior on macOS to allow
 ;; entering special characters.
 :gn [f2] #'mks/mac-toggle-option-as-meta

 ;; Use C-k to kill line.
 :i "C-k" #'kill-line

 ;; Allow using ; to enter command mode.
 :nv ";" #'evil-ex

 ;; Use \ for previous ; command.
 :nv "\\" #'evil-snipe-repeat

 ;; Use | for previous \ command.
 :nv "|" #'evil-execute-in-emacs-state

 ;; Paste yanked text (as opposed to cut text).
 :nv "gp" "\"0p"
 :nv "gP" "\"0P"

 ;; Use +/- for incrementing/decrementing numbers.
 :nv "+" #'evil-numbers/inc-at-pt
 :nv "-" #'evil-numbers/dec-at-pt

 :leader

 ;; Prefer double-space to invoke `M-x' as in Spacemacs.
 :desc "Call a command" "SPC" #'counsel-M-x

 ;; Use `fa' to toggle between header/source files.
 (:prefix "f" :desc "Find header or source file" "a" #'ff-find-other-file)

 ;; Prefer Spacemac's variants for window bindings.
 (:prefix "w"
   "/" #'evil-window-vsplit
   "m" #'doom/window-maximize-buffer))

;; Prefer `C-k' to be `kill-line' when using `eval-expression' and
;; `ex' rather than Doom's default of `previous-line'.
(define-key! evil-ex-completion-map "C-k" #'kill-line)
(define-key! read-expression-map
  "C-k" #'kill-line
  "C-n" #'next-line-or-history-element
  "C-p" #'previous-line-or-history-element)

;;;###autoload
(defun mks/mac-toggle-option-as-meta ()
  "Toggle option-as-meta setting on macOS."
  (interactive)
  (if (eq mac-option-modifier 'none)
      (progn
        (setq mac-option-modifier 'meta)
        (message "macOS option-as-meta behavior enabled."))
    (setq mac-option-modifier 'none)
    (message "macOS option-as-meta behavior disabled.")))

;;;###autoload
(defun mks/objc-file-p ()
  "Return non-nil if current buffer is an Objective-C file."
  (and buffer-file-name
       (file-name-extension buffer-file-name)
       (member (file-name-extension buffer-file-name) '("mm" "m" "h"))
       (re-search-forward "@interface\\|@implementation\\|@import\\|#import"
                          magic-mode-regexp-match-limit t)))

;; Workaround from
;; https://github.com/syl20bnr/spacemacs/issues/5634#issuecomment-204340185
;; to auto-detect objc files.
(add-to-list 'magic-mode-alist '(mks/objc-file-p . objc-mode))

(use-package! fish-mode
  :defer t
  :config
  (set-company-backend! 'fish-mode #'company-fish-shell))

(use-package! swift-playground-mode :defer t :init
  (autoload 'swift-playground-global-mode "swift-playground-mode" nil t)
  (add-hook 'swift-mode-hook #'swift-playground-global-mode))

;; Here are some additional functions/macros that could help you
;; configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path',
;;   relative to this file. Emacs searches the `load-path' when you
;;   load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the
;; cursor over the highlighted symbol at press 'K' (non-evil users
;; must press 'C-c g k'). This will open documentation for it,
;; including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition
;; and see how they are implemented.
