;;; funcs.el --- Spacemacs Layer Functions File
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

;; From https://www.emacswiki.org/emacs/BackwardKillLine
(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))

(defun yank-right ()
  "Move forward one character and yank."
  (interactive)
  (forward-char)
  (yank))

(defun insert-semicolon-end-of-line ()
  "Insert a semicolon at the end of the current line."
  (interactive)
  (end-of-line)
  (insert ";"))

(defun michaelsanders-better-defaults/ycmd-init-server (server-command)
  "Toggle ycmd mode and set `ycmd-server-command' to the given
command, restarting the server if necessary."
  (require 'ycmd)
  (when (or
         (not ycmd-server-command)
         (not (every #'string= ycmd-server-command server-command)))
    (setq ycmd-server-command server-command)
    (when (ycmd-running-p) (ycmd-close)))
  (ycmd-mode))

(defun michaelsanders-better-defaults/ycmd-init ()
  "Toggle ycmd mode and configure server."
  (michaelsanders-better-defaults/ycmd-init-server
   `(,(file-truename "~/.pyenv/shims/python") ,(file-truename "~/.ycmd/ycmd"))))

(defun michaelsanders-better-defaults/icmd-init ()
  "Toggle ycmd mode and configure server for icmd."
  (michaelsanders-better-defaults/ycmd-init-server
   `(,(file-truename "~/.pyenv/shims/python") ,(file-truename "~/.icmd/ycmd"))))

;; Hack from https://github.com/syl20bnr/spacemacs/issues/2751#issuecomment-290739613
;; to hide .DS_Store even when showing hidden files.
(with-eval-after-load 'neotree
  (add-to-list 'neo-hidden-regexp-list "TAGS$")
  (add-to-list 'neo-hidden-regexp-list "__pycache__")

  ;; Patched to allow everything but .DS_Store.
  ;; This must be run after neotree loads in order to monkeypatch.
  (defun neo-util--walk-dir (path)
    "Return the subdirectories and subfiles of the PATH."
    (let* ((full-path (neo-path--file-truename path)))
      (condition-case nil
          (directory-files
           path 'full "^\\([^.]\\|\\.[^D.][^S]\\).*")
        ('file-error
         (message "Walk directory %S failed." path)
         nil)))))

(defun michaelsanders-better-defaults/objective-c-file-p ()
  (and buffer-file-name
	     (file-name-extension buffer-file-name)
       (member (file-name-extension buffer-file-name) '("m" "h"))
       (re-search-forward "@interface\\|@implementation\\|@import\\|#import"
                          magic-mode-regexp-match-limit t)))
