;;;; Use on singel config file
;;;; To stop pre-optimization
;;;; Once the config grows over 500 lines
;;;; Start modularizing it then

;;(add-to-list 'load-path
;;	     (expand-file-name (concat user-emacs-directory "lisp")))


;;; (require 'init-const)
;;; ------------------- init-const  ---------------------
(defconst *is-mac* (eq system-type 'darwin))
(defconst *is-linux* (eq system-type 'gnu/linux))
(defconst *is-windows* (or (eq system-type 'ms-dos) (eq system-type 'windows-nt)))

;;; ------------------ change default ---------------------
;;; set the default encoding system
(prefer-coding-system 'utf-8)
(setq default-file-name-coding-system 'utf-8
      default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)



;; (auto-save-mode -1)
(setq make-backup-files nil
      inhibit-compacting-font-caches t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)


;; set font
(add-to-list 'default-frame-alist
	     '(font . "JetBrainsMono Nerd Font-11:Medium"))


;;; ------------------- about company ----------------------
(global-company-mode t)
(define-key company-active-map (kbd "<tab>") 'company-select-next)
(define-key company-active-map (kbd "p") 'company-select-previous)
(setq company-idle-delay 0.0
      inhibit-startup-screen t)

;;; -------------------  init-pkgs  ---------------------
(use-package benchmark-init
  :init (benchmark-init/activate)
  :hook (after-init . benchmark-init/deactivate))

(use-package which-key
  :defer nil
  :config (which-key-mode))

(use-package restart-emacs)


;;(require 'init-elpa)
;;; -------------------  init-elpa ---------------------
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

;;; -------------------  init-theme ---------------------
;; (require 'init-ui)
;; gruvbox theme
(use-package gruvbox-theme
 :init (load-theme 'gruvbox-dark-hard t))

;;(use-package spacemacs-theme
;;  :init (load-theme 'spacemacs-dark t))

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
;;; -------------------  init-ui ---------------------
;; (use-package benchmark-init
;;  :init (benchmark-init/activate)
;;  :hook (after-init . benchmark-init/deactivate))

(use-package which-key
  :defer nil
  :config (which-key-mode))

(use-package restart-emacs)

;;(require 'org-mode)			     
;;; ------------------- org-mode ---------------------
;; org-mode keys
(setq org-agenda-files '("~/org/bujo" "~/org/roam/daily"))
(setq org-agenda-include-diary t)

;; I don't want this becasue every time I change a state
;; from TODO-state, it will insert the CLOSED timestamp
;; (setq org-log-done 'time)


;; regarding *org-startup-folded*
;; ="content"= won't work! but ='content= works!
;; try it out on Emacs 27.1
;; see https://brantou.github.io/2017/03/21/just-try/
(setq
 org-deadline-warning-days 0
 org-startup-folded 'content
 org-hide-leading-stars t)

;; org-mode to do
(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d)")
	(sequence "CANCELLED(c@)" "|" "EVENT(e)" "NOTE(n)" "IDEA(a)" "WATCH(w)")
;; right arrow: migrate to Futher; left arrow: migrate to Other collections
	(sequence "✝TODO(i)" "|" ">(f)" "<(o)")))

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
;;; ------------------ org bullets -------------------
;;; enabling bullet will *significantly* slow the performance, see
;;; 1. https://github.com/sabof/org-bullets/issues/11
;;; 2. https://www.reddit.com/r/emacs/comments/98flwy/does_anyone_know_a_good_alternative_to_orgbullets/
;;; 3. https://www.reddit.com/r/emacs/comments/8ug077/orgbullets_slow_with_certain_fonts/
;;; (require 'org-bullets)
(add-hook 'org-mode-hook
	  (lambda ()
	    (org-bullets-mode t)))
(setq org-ellipsis "⤵")
(setq org-bullets-bullet-list '("◉"
				"☰"
				"☱"
				"☲"
				"☳"
				"☴"
				"☵"
				"☶"
				"☷"))

;;; ------------------ org journal -------------------
;;; customized so to adjust to Bullet Journal style

(use-package org-journal
  :custom
  (org-journal-dir "~/org/bujo")
  (org-journal-file-type 'daily)
  (org-journal-date-format "%m.%d %a")
  ;; must contain %Y
  ;; see https://github.com/bastibe/org-journal/blob/78d575213c7cf7c069e52bfc46430090c0500000/org-journal.el#L158
  (org-journal-file-format "%Y-%m-%d.org")
  :config
  (setq org-journal-find-file #'find-file-other-window
	org-journal-enable-agenda-integration t))




;;; write cutome stuff to a singel file
(setq custom-file "~/.emacs.d/custom-file.el")
;; (load-file custom-file)

