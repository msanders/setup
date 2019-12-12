;;; packages.el --- Spacemacs Layer Packages File
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst michaelsanders-swift-packages
  '(
    company
    flycheck-swiftlint
    ggtags
    helm-gtags
    swift-playground-mode
   ))

(defun michaelsanders-swift/init-flycheck-swiftlint ()
  (use-package flycheck-swiftlint :ensure t :defer t))

(defun michaelsanders-swift/init-swift-playground-mode ()
  (use-package swift-playground-mode :defer t :init
    (autoload 'swift-playground-global-mode "swift-playground-mode" nil t)
    (add-hook 'swift-mode-hook #'swift-playground-global-mode)))

(defun michaelsanders-swift/post-flycheck-swiftlint ()
  (with-eval-after-load 'flycheck (flycheck-swiftlint-setup)))

(defun michaelsanders-swift/post-init-company ()
  (spacemacs|add-company-hook swift-mode))

(defun michaelsanders-swift/post-init-ggtags ()
  (add-hook 'swift-mode-local-vars-hook #'spacemacs/ggtags-mode-enable))

(defun michaelsanders-swift/post-init-helm-gtags ()
  (spacemacs/helm-gtags-define-keys-for-mode #'swift-mode))
