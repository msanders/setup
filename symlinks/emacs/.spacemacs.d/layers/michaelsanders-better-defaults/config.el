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

;; Allow using right alt key to write symbols.
(setq-default mac-right-option-modifier nil)

;; Don't end sentences with a double space.
(setq sentence-end-double-space nil)

;; Automatically follow symlinks.
(setq vc-follow-symlinks t)

;; Indent with 4 spaces by default.
(setq-default c-basic-offset 4)

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
               "\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\|Fast\\|Brew\\)file\\)\\'"
               .
               enh-ruby-mode
               ))

(defun michaelsanders/gtags-env-patch (orig &rest args)
  (if-let* ((project-root (file-truename (locate-dominating-file "." ".git")))
            (git-dir (expand-file-name ".git" project-root))
            (process-environment (append
                                  (list (format "GTAGSROOT=%s" project-root)
                                        (format "GTAGSDBPATH=%s" git-dir))
                                  process-environment)))
      (apply orig args)
    (apply orig args)))

(advice-add #'counsel-gtags-find-reference
            :around
            #'michaelsanders/gtags-env-patch)
(advice-add #'counsel-gtags-find-symbol
            :around
            #'michaelsanders/gtags-env-patch)
(advice-add #'counsel-gtags-find-definition
            :around
            #'michaelsanders/gtags-env-patch)
(advice-add #'counsel-gtags-dwim
            :around
            #'michaelsanders/gtags-env-patch)

;; Workaround from
;; https://github.com/syl20bnr/spacemacs/issues/5634#issuecomment-204340185
;; to auto-detect objc files.
(add-to-list 'magic-mode-alist
             (cons #'michaelsanders-better-defaults/objective-c-file-p
                   #'objc-mode))
