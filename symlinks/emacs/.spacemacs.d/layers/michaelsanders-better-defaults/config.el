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

(setq vc-follow-symlinks t)
(setq emerge-diff-options "--ignore-all-space")
(setq magit-repository-directories '("~/src/"))
(setq sentence-end-double-space nil)
(setq-default c-basic-offset 4)
(setq-default require-final-newline t)
(setq ycmd-force-semantic-completion t)

;; Centralize backup location.
(setq backup-directory-alist '(("~/.spacemacs.d/backups")))
(setq vc-make-backup-files t ; Enable backups for versioned files.
      version-control t      ; Use version numbers for backups.
      kept-new-versions 10   ; Number of newest versions to keep.
      kept-old-versions 0    ; Number of oldest versions to keep.
      delete-old-versions t  ; Don't ask to delete excess backup versions.
      backup-by-copying t)   ; Copy all files, don't rename them.

(setq enh-ruby-add-encoding-comment-on-save nil)
(add-hook 'enh-ruby-mode-hook
          (lambda ()
            (setq-local enh-ruby-indent-level 2)
            (setq-local enh-ruby-deep-indent-paren nil)
            (setq-local enh-ruby-deep-arglist nil)))

(add-to-list 'auto-mode-alist
             '(
               "\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\|Fast\\)file\\)\\'"
               .
               enh-ruby-mode
               ))

;; YouCompleteMe hooks.
(add-hook 'c++-mode-hook #'michaelsanders-better-defaults/ycmd-init)
(add-hook 'c-mode-hook #'michaelsanders-better-defaults/ycmd-init)
(add-hook 'js2-mode-hook #'michaelsanders-better-defaults/ycmd-init)
(add-hook 'python-mode-hook #'michaelsanders-better-defaults/ycmd-init)
(add-hook 'swift-mode-hook #'michaelsanders-better-defaults/icmd-init)
(add-hook 'company-mode-hook #'company-ycmd-setup)

;; Workaround from
;; https://github.com/syl20bnr/spacemacs/issues/5634#issuecomment-204340185
;; to auto-detect objc files.
(add-to-list 'magic-mode-alist
             (cons #'michaelsanders-better-defaults/objective-c-file-p
                   #'objc-mode))
