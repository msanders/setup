;;; config.el --- Spacemacs Layer Config File
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

;; Make tooltips appear in echo area.
(tooltip-mode -1)

;; Disable bold fonts.
(set-face-bold-p 'bold nil)

;; Open new files in same frame on Mac.
(setq pop-up-windows nil)

(setq neo-show-hidden-files nil)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq-default git-magit-status-fullscreen t)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq delete-by-moving-to-trash t)
(setq display-time-24hr-format t)
(setq font-lock-maximum-decoration t)
(setq trash-directory "~/.Trash")
(setq find-function-C-source-directory "~/src/etc/emacs/src")
(display-time-mode)

;; Workaround for https://github.com/syl20bnr/spacemacs/issues/5435.
;; https://github.com/syl20bnr/spacemacs/issues/5435#issuecomment-195862080
(add-hook 'spacemacs-buffer-mode-hook
          (lambda ()
            (set (make-local-variable 'mouse-1-click-follows-link) nil)))

(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

;; Fill column indicator settings.
(add-hook 'c-mode-hook #'80-column-rule)
(add-hook 'cc-mode-hook #'80-column-rule)
(add-hook 'c++-mode-hook #'80-column-rule)
(add-hook 'elm-mode-hook #'80-column-rule)
(add-hook 'emacs-lisp-mode-hook #'80-column-rule)
(add-hook 'haskell-mode-hook #'100-column-rule)
(add-hook 'js2-mode-hook #'100-column-rule)
(add-hook 'lisp-mode-hook #'80-column-rule)
(add-hook 'markdown-mode-hook #'80-column-rule)
(add-hook 'python-mode-hook #'80-column-rule)
(add-hook 'rust-mode-hook #'100-column-rule)
(add-hook 'ruby-mode-hook #'120-column-rule)
(add-hook 'scheme-mode-hook #'80-column-rule)
(add-hook 'sh-mode-hook #'80-column-rule)
(add-hook 'swift-mode-hook #'120-column-rule)
(add-hook 'text-mode-hook #'80-column-rule)

;; Helm dash hooks.
(add-hook 'c-mode-hook
          (lambda () (setq-local helm-dash-docsets '("C"))))
(add-hook 'cc-mode-hook
          (lambda () (setq-local helm-dash-docsets '("C++"))))
(add-hook 'emacs-lisp-mode-hook
          (lambda () (setq-local helm-dash-docsets '("Emacs Lisp"))))
(add-hook 'haskell-mode-hook
          (lambda () (setq-local helm-dash-docsets '("Haskell"))))
(add-hook 'js2-mode-hook
          (lambda () (setq-local helm-dash-docsets '("JavaScript"))))
(add-hook 'lisp-mode-hook
          (lambda () (setq-local helm-dash-docsets '("Common Lisp"))))
(add-hook 'python-mode-hook
          (lambda () (setq-local helm-dash-docsets '("Python 2" "Python 3"))))
(add-hook 'rust-mode-hook
          (lambda () (setq-local helm-dash-docsets '("Rust"))))
(add-hook 'ruby-mode-hook
          (lambda () (setq-local helm-dash-docsets '("Ruby"))))
(add-hook 'swift-mode-hook
          (lambda () (setq-local helm-dash-docsets '("Swift"))))

;; emacs-mac config
(when (spacemacs/system-is-mac)
  (setq default-frame-alist '(
                              (ns-transparent-titlebar . t)
                              (ns-appearance . dark)
                              )))

;; Add support for font ligatures.
;; See https://github.com/tonsky/FiraCode/wiki/Emacs-instructions
(when (window-system)
  (if (spacemacs/system-is-mac)
      (mac-auto-operator-composition-mode)
    (let ((alist '((33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
                   (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
                   (36 . ".\\(?:>\\)")
                   (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
                   (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
                   (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
                   (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
                   ;; (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
                   ;; (46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)")
                   ;; (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
                   (48 . ".\\(?:x[a-zA-Z]\\)")
                   (58 . ".\\(?:::\\|[:=]\\)")
                   (59 . ".\\(?:;;\\|;\\)")
                   (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
                   (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
                   (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
                   ;; Disabling due to https://github.com/tonsky/FiraCode/issues/158#issuecomment-218962919
                   ;; (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
                   (91 . ".\\(?:]\\)")
                   (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
                   (94 . ".\\(?:=\\)")
                   (119 . ".\\(?:ww\\)")
                   (123 . ".\\(?:-\\)")
                   (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
                   (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)")
                   )
                 ))
      (dolist (char-regexp alist)
        (set-char-table-range composition-function-table (car char-regexp)
                              `([,(cdr char-regexp) 0 font-shape-gstring]))))))
