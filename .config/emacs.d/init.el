;; Use on singel config file
;; To stop pre-optimization
;; Once the config grows over 500 lines
;; Start modularizing it then

;;(add-to-list 'load-path
;;	     (expand-file-name (concat user-emacs-directory "lisp")))



;; (require 'init-const)
;; ------------------- init-const  ---------------------
(defconst *is-mac* (eq system-type 'darwin))
(defconst *is-linux* (eq system-type 'gnu/linux))
(defconst *is-windows* (or (eq system-type 'ms-dos) (eq system-type 'windows-nt)))

;; ------------------- init-startup  ---------------------
;; set the default encoding system
(prefer-coding-system 'utf-8)
(setq default-file-name-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)


;; ------------------ change default ---------------------
;; (auto-save-mode -1)
(setq make-backup-files nil)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)



;;------------------- about company ----------------------
(global-company-mode t)
(define-key company-active-map (kbd "<tab>") 'company-select-next)
(define-key company-active-map (kbd "p") 'company-select-previous)
(setq company-idle-delay 0.0)

(setq inhibit-startup-screen t)

;; -------------------  init-pkgs  ---------------------
(use-package benchmark-init
  :init (benchmark-init/activate)
  :hook (after-init . benchmark-init/deactivate))

(use-package which-key
  :defer nil
  :config (which-key-mode))

(use-package restart-emacs)


;;(require 'init-elpa)
;; -------------------  init-elpa ---------------------
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
			 ("org"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))

;; sync signature checking
(setq package-check-signature nil)

(require 'package)

;; initialize package manager
(unless (bound-and-true-p package--initialized)
  (package-initialize))


;; sync with source
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;;
(setq use-package-always-ensure t
      use-package-always-defer t
      use-package-always-demand nil
      use-package-expand-minimally t
      use-package-verbose t)


;; restart emacs
(require 'use-package)

;; -------------------  init-theme ---------------------
;; (require 'init-ui)
;; gruvbox theme
;;(use-package gruvbox-theme
;; :init (load-theme 'gruvbox-dark-soft t))

(use-package spacemacs-theme
  :init (load-theme 'spacemacs-dark t))

;; status line
(use-package smart-mode-line
  :init
  (setq sml/no-confirm-load-theme t
	sml/theme 'respectful)
  (sml/setup))

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
(global-hl-line-mode t)


;; (require 'init-pkgs)
;; -------------------  init-ui ---------------------
(use-package benchmark-init
  :init (benchmark-init/activate)
  :hook (after-init . benchmark-init/deactivate))

(use-package which-key
  :defer nil
  :config (which-key-mode))

(use-package restart-emacs)

;;(require 'org-mode)			     
;; ------------------- org-mode ---------------------
;; org-mode keys
(setq org-agenda-include-diary t)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

;; org-mode to do
(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d)")
	(sequence "CANCELLED(c)" "|" "EVENT(e)")
	(sequence "⋇TODO(i)" "|" "»(f)" "«(o)"))) 
;; right arrow: migrate to Futher; left arrow: migrate to Other collections

;; ------------------ org bullets -------------------
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-bullets-bullet-list '("◎" "◉" "○" "●"))

;; ------------------ org journal -------------------
(setq org-journal-dir "~/proj/org-bujo/")
(setq org-journal-date-format "%m/%d %a")

(require 'org-journal)

;; write cutome stuff to a singel file
(setq custom-file "~/.emacs.d/custom-file.el")
(load-file custom-file)
