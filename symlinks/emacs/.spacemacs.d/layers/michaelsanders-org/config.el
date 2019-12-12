;;; config.el --- Spacemacs Layer Config File
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; From http://www.howardism.org/Technical/Emacs/orgmode-wordprocessor.html
(when (display-graphic-p)
  (let* ((variable-tuple
          (cond ((x-list-fonts "Roboto") '(:font "Roboto"))
                ((x-family-fonts "Sans Serif") '(:family "Sans Serif"))
                (nil (warn "Cannot find a sans-serif font."))))
         (base-font-color (face-foreground 'default nil 'default))
         (headline `(:inherit default :weight normal :foreground ,base-font-color)))

    (custom-theme-set-faces 'user
                            `(org-level-8 ((t (,@headline ,@variable-tuple))))
                            `(org-level-7 ((t (,@headline ,@variable-tuple))))
                            `(org-level-6 ((t (,@headline ,@variable-tuple))))
                            `(org-level-5 ((t (,@headline ,@variable-tuple))))
                            `(org-level-4 ((t (,@headline
                                               ,@variable-tuple :height 200))))
                            `(org-level-3 ((t (,@headline
                                               ,@variable-tuple :height 200))))
                            `(org-level-2 ((t (,@headline
                                               ,@variable-tuple :height 200))))
                            `(org-level-1 ((t (,@headline
                                               ,@variable-tuple :height 200))))
                            `(org-document-title ((t (,@headline
                                                      ,@variable-tuple
                                                      :height 400
                                                     :underline nil))))
                            `(org-code ((t (,@headline
                                            ,@variable-tuple :height 160)))))))

(with-eval-after-load 'org
  (font-lock-add-keywords 'org-mode
                          '(("\\(?:\\(?:- \\)?\\[ ]\\)"
                             (0 (prog1 () (compose-region
                                           (match-beginning 0)
                                           (match-end 0) "☐"))))))

  (font-lock-add-keywords 'org-mode
                          '(("\\(?:\\(?:- \\)?\\[X]\\)"
                             (0 (prog1 () (compose-region
                                           (match-beginning 0)
                                           (match-end 0) "☑"))))))

  ;; From http://www.howardism.org/Technical/Emacs/orgmode-wordprocessor.html
  (font-lock-add-keywords 'org-mode
                          '(("^ +\\([-*]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1)
                                                          (match-end 1)
                                                          "•"))))))

  (setq org-agenda-files '("~/Dropbox/Org/")
        org-directory "~/Dropbox/Org/"
        org-agenda-start-on-weekday 0
        org-bullets-face-name 'org-code
        org-ellipsis "…"
        org-fontify-done-headline t
        org-fontify-quote-and-verse-blocks t
        org-fontify-whole-heading-line t
        org-hide-emphasis-markers t
        org-log-done 'time
        org-pretty-entities t
        org-startup-indented t)

  (add-hook 'org-mode-hook #'turn-off-fci-mode)
  (add-hook 'org-add-hook
            (setq-local line-spacing 0.1)
            (lambda ()
              (variable-pitch-mode)
              (mapc
               (lambda (face)
                 (set-face-attribute face nil :inherit 'fixed-pitch))
               (list 'org-code
                     'org-link
                     'org-block
                     'org-table
                     'org-block-begin-line
                     'org-block-end-line
                     'org-meta-line
                     'org-todo
                     'org-special-keyword
                     'org-done
                     'org-date
                     'org-warning
                     'org-scheduled
                     'org-document-info-keyword))

              (custom-set-faces
               (set-face-attribute 'org-done nil :strike-through t)
               (set-face-attribute 'org-ellipsis nil :underline nil)
               (set-face-attribute 'org-headline-done nil :strike-through t)))))
