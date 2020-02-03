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

(defun 80-column-rule ()
  "Toggle fci mode and set fci-rule-column to 80."
  (setq-local fci-rule-column 80)
  (setq-local fill-column 79)
  (fci-mode t))

(defun 100-column-rule ()
  "Toggle fci mode and set fci-rule-column to 100."
  (setq-local fci-rule-column 100)
  (setq-local fill-column 100)
  (fci-mode t))

(defun 120-column-rule ()
  "Toggle fci mode and set fci-rule-column to 120."
  (setq-local fci-rule-column 120)
  (setq-local fill-column 120)
  (fci-mode t))
