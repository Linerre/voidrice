;;;; Use on singel config file
;;;; To stop pre-optimization
;;;; Once the config grows over 500 lines
;;;; Start modularizing it then

;;(add-to-list 'load-path
;;	     (expand-file-name (concat user-emacs-directory "lisp")))

;;; --------------- mirrors set ----------------------
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

(setq use-package-always-ensure t
      use-package-always-defer t
      use-package-always-demand nil
      use-package-expand-minimally t
      use-package-verbose t)

;; restart emacs
(require 'use-package)



;;; ------------------ change default ---------------------
;;; set the default encoding system
(prefer-coding-system 'utf-8)
(setq default-file-name-coding-system 'utf-8
      default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; (auto-save-mode -1)
(setq make-backup-files nil
      inhibit-compacting-font-caches t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)


;; set font
(add-to-list 'default-frame-alist
	     '(font . "FiraCode Nerd Font Mono-12:Bold"))

;; show week number in calendar view
(setq calendar-intermonth-text
      '(propertize
	(format "%2d"
		(car
		 (calendar-iso-from-absolute
		  (calendar-absolute-from-gregorian (list month day year)))))
	'font-lock-face 'calendar-iso-week-face))


;; split window vertically


;; quick access to init file
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "<f2>") 'open-init-file)

;; open recent files
(require 'recentf)
(recentf-mode 1)
(setq recnetf-max-menu-item 10)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)


;; start emacs in fullscreen
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; show paired braces
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; (add-hook 'after-init-hook 'org-roam-mode)


;;; (require 'init-const)
;;; ------------------- init-const  ---------------------
(defconst *is-mac* (eq system-type 'darwin))
(defconst *is-linux* (eq system-type 'gnu/linux))
(defconst *is-windows* (or (eq system-type 'ms-dos) (eq system-type 'windows-nt)))


;;; ------------------ PACKAGE AND MODE -------------------

;;; ------------------- COMPANY  ----------------------
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


;;; -------------------  init-theme ---------------------
;; (require 'init-ui)
;; gruvbox theme
(use-package gruvbox-theme
 :init (load-theme 'gruvbox-dark-medium t))

;(use-package spacemacs-theme
;  :init (load-theme 'spacemacs-dark t))

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
	(sequence "CANCELLED(c)" "|" "EVENT(e)" "NOTE(n)" "IDEA(a)" "WATCH(w)")
;; right arrow: migrate to Futher; left arrow: migrate to Other collections
	(sequence "✝TODO(i)" "|" ">(f)" "<(o)")))

;;(setq org-todo-keyword-faces
;;     '(("TODO" . (:background "#9d0006" :foreground "fbf1c7"))
;;        ("DONE" . (:background "#427b58" :foreground "#fbf1c7"))))


(setq org-tag-faces
      '(("work" . "#d65d0e")
	("personal" . "#fe8019")))


(setq org-src-fontify-natively t)

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
  (org-journal-file-type 'weekly)
  (org-journal-date-format "%m.%d %a")
  ;; must contain %Y
  ;; see https://github.com/bastibe/org-journal/blob/78d575213c7cf7c069e52bfc46430090c0500000/org-journal.el#L158
  (org-journal-file-format "%Y-%m-%d-%V.org")
  :config
  (setq org-journal-find-file #'find-file-other-window
	org-journal-enable-agenda-integration t))


;;; ------------------ org roam ----------------------
(executable-find "sqlite3")
(use-package org-roam
  :hook
  (after-init . org-roam-mode)
  :custom
  org-roam-directory "~/org/roam"
  :bind (:map org-roam-mode-map
	      (("C-c n l" . org-roam)
	       ("C-c n f" . org-roam-find-file)
	       ("C-c n g" . org-roam-graph))
	       :map org-mode-map
	       (("C-c n i" . org-roam-insert))
	       (("C-c n I" . org-roam-insert-immediate))))

(use-package deft
  :bind ("<f8>" . deft)
  :commands (deft)
  :config (setq deft-directory "~/org/roam"
		deft-extensions '("org" "md" "txt" "tex")))


(use-package org-roam-server
  :config
  (setq org-roam-server-host "127.0.0.1"
	org-roam-server-port 9090
	org-roam-server-authenticate nil
	org-roam-server-export-inline-images t
	org-roam-server-network-poll t
	org-roam-server-network-arrows nil
	org-roam-server-network-label-truncate t
	org-roam-server-network-label-truncate-length 60
	org-roam-server-network-label-wrap-length 20))

;;; write cutome stuff to a singel file
(setq custom-file "~/.emacs.d/custom-file.el")
(load-file custom-file)

