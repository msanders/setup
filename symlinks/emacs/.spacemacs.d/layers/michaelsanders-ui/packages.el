;;; packages.el --- Spacemacs Layer Packages File
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

(defconst michaelsanders-ui-packages
  '(
    ivy
    which-func
   ))

(defun michaelsanders-ui/init-which-func ()
  (use-package which-func :ensure t :config (which-func-mode t)))

(defun michaelsanders-ui/post-init-ivy ()
  (with-eval-after-load 'ivy
    ;; Use C-w to delete previous word.
    (define-key ivy-minibuffer-map (kbd "C-w") #'ivy-backward-kill-word)

    ;; Enable fish-style forward completion.
    (define-key ivy-minibuffer-map (kbd "C-f") #'ivy-alt-done)

    ;; Use RET for continuing completion for a directory, as in ido.
    (define-key ivy-minibuffer-map (kbd "RET") #'ivy-alt-done)

    ;; Require full ~/ to navigate home.
    (setq ivy-magic-tilde nil)

    ;; Abbreviate buffer list by default.
    (setq ivy-rich-path-style 'abbrev)
    (setq ivy-virtual-abbreviate 'abbreviate)))
