;;; keybindings.el --- Spacemacs Layer Key Bindings File
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; Evil bindings.
(modify-syntax-entry ?_ "w") ; Treat underscores as part of word.
(define-key evil-insert-state-map "\C-u" #'backward-kill-line)
(define-key evil-insert-state-map "\C-y" nil)
(define-key evil-insert-state-map "\C-e" #'mwim-end-of-code-or-line)
(define-key evil-visual-state-map "\C-e" #'mwim-end-of-code-or-line)
(define-key evil-motion-state-map "\C-e" #'mwim-end-of-code-or-line)
(define-key evil-insert-state-map "\C-a" #'mwim-beginning-of-code-or-line)
(define-key evil-visual-state-map "\C-a" #'mwim-beginning-of-code-or-line)
(define-key evil-motion-state-map "\C-a" #'mwim-beginning-of-code-or-line)
(define-key evil-visual-state-map "0" #'mwim-beginning-of-code-or-line)
(define-key evil-motion-state-map "0" #'mwim-beginning-of-code-or-line)
(define-key evil-visual-state-map "$" #'mwim-end-of-code-or-line)
(define-key evil-motion-state-map "$" #'mwim-end-of-code-or-line)
(define-key evil-normal-state-map "\C-n" #'evil-next-line)
(define-key evil-visual-state-map "\C-n" #'evil-next-line)
(define-key evil-normal-state-map "\C-p" #'evil-previous-line)
(define-key evil-visual-state-map "\C-p" #'evil-previous-line)
(define-key evil-insert-state-map "\M-p" #'evil-previous-line)
(define-key evil-insert-state-map "\M-n" #'evil-next-line)
(define-key evil-normal-state-map "gP" #'yank)
(define-key evil-normal-state-map "gp" #'yank-right)
(define-key evil-motion-state-map ";" #'evil-ex)
(define-key evil-motion-state-map "|" #'evil-execute-in-emacs-state)
(define-key evil-motion-state-map "\\" #'evil-repeat-find-char)
(define-key evil-insert-state-map (kbd "C-'") #'insert-semicolon-end-of-line)
(define-key evil-motion-state-map "gK" #'dash-at-point)
(define-key evil-visual-state-map "gK" #'dash-at-point)
(spacemacs/set-leader-keys "fa" #'ff-find-other-file)
(spacemacs/set-leader-keys "wD" #'delete-frame)

;; Evil numbers bindings.
(define-key evil-normal-state-map "+" #'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map "-" #'evil-numbers/dec-at-pt)

(global-set-key (kbd "RET") #'newline-and-indent)
(global-set-key (kbd "s-{") #'next-multiframe-window)
(global-set-key (kbd "s-}") #'previous-multiframe-window)
(global-set-key (kbd "s-t") #'make-frame)
(global-set-key (kbd "s-w") #'delete-frame)

;; Smartparens
(sp-pair "(" nil :unless '(sp-point-before-word-p sp-point-before-same-p))
(sp-pair "[" nil :unless '(sp-point-before-word-p sp-point-before-same-p))
(sp-pair "{" nil :unless '(sp-point-before-word-p sp-point-before-same-p))

(setq-default evil-escape-delay 0.2)
