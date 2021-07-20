;;; init.el --- Load the full configuration -*- lexical-binding: t -*-

;;; Modularized init
;;; Author: Errelin
;;; Last Change:

;;; Modules stored in the "lisp" directory 
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))


(require 'init-options)
(require 'init-elpa)
(require 'init-keymaps)
(require 'init-gui)
(require 'init-company)
(require 'init-which-key)
(require 'init-theme)
(require 'init-yasnippets)
(require 'init-indent)
(require 'init-css)
(require 'init-eglot)

;; Variables configured via the interactive 'customize' interface
;;(when (file-exists-p custom-file)
;;  (load-file custom-file))
