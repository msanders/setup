;;; keybindings.el --- Spacemacs Layer Key Bindings File
;;
;; Copyright 2018 Michael Sanders.
;;
;; This file is not part of GNU Emacs.
;;
;; License:
;;
;; This program is free software: you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of the
;; License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see
;; <https://www.gnu.org/licenses/>.
;;

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
