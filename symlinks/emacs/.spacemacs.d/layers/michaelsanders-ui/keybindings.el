;;; keybindings.el --- Spacemacs Layer Key Bindings File
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; Use ido for find-file, helm for everything else.
(spacemacs/set-leader-keys "ff" #'ido-find-file)
(global-set-key (kbd "C-x C-f") #'ido-find-file)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x b") #'helm-mini)

(global-set-key (kbd "C-h f") #'helpful-callable)
(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)
(global-set-key (kbd "C-c C-d") #'helpful-at-point)
(global-set-key (kbd "C-h F") #'helpful-function)
(global-set-key (kbd "C-h C") #'helpful-command)
