;;; packages.el --- Spacemacs Layer Packages File
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst michaelsanders-ui-packages
  '(
    all-the-icons
    editorconfig
    helm
    helpful
    nov
    nyan-mode
    which-func
    writeroom-mode
    yasnippet-snippets
   ))

(defun michaelsanders-ui/init-all-the-icons ()
  (use-package all-the-icons :ensure t :defer t))

(defun michaelsanders-ui/init-editorconfig ()
  (use-package editorconfig :ensure t :defer t))

(defun michaelsanders-ui/init-helpful ()
  (use-package helpful :ensure t :defer t))

(defun michaelsanders-ui/init-nov ()
  (use-package nov :ensure t :defer t :config
    (setq nov-text-width 80)))

(defun michaelsanders-ui/init-which-func ()
  (use-package which-func :ensure t :config
    (which-func-mode t)))

(defun michaelsanders-ui/init-nyan-mode ()
  (use-package nyan-mode :ensure t :defer t))

(defun michaelsanders-ui/init-writeroom-mode ()
  (use-package writeroom-mode
    :ensure t
    :defer t
    :init (spacemacs/set-leader-keys "aW" #'writeroom-mode)
  ))

(defun michaelsanders-ui/init-yasnippet-snippets ()
  (use-package yasnippet-snippets :ensure t :defer t :init
    (autoload 'yasnippet-snippets-initialize "yasnippet-snippets" nil t)
    (eval-after-load 'yasnippet #'yasnippet-snippets-initialize)))

(defun michaelsanders-ui/post-init-helm ()
  (add-hook 'ido-setup-hook
            (lambda ()
              (dolist (mapping (list ido-file-dir-completion-map
                                     ido-file-completion-map))
                (define-key mapping
                  (kbd "C-w")
                  #'ido-delete-backward-word-updir))))

  (with-eval-after-load 'helm
    (ido-mode 1)
    (helm-mode 1)
    (add-to-list 'helm-completing-read-handlers-alist
                 '(find-file-read-only . ido))
    (setq helm-mini-default-sources '(helm-source-buffers-list
                                      helm-source-recentf))))
