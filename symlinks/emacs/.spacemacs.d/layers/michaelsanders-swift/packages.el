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
