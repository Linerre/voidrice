;;; early-init.el -*- lexical-binding: t -*-

;;; Modularized initialization
;;; Author: Errelin
;;; Last Change:

;;; Modules stored in the "lisp" directory 
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "themes" user-emacs-directory))
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(require 'init-elpa)
(require 'init-options)
;;(require 'init-theme)
