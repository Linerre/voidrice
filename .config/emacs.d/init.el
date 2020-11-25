;;;; Use on singel config file
;;;; To stop pre-optimization
;;;; Once the config grows over 500 lines
;;;; Start modularizing it then

;;(add-to-list 'load-path
;;	     (expand-file-name (concat user-emacs-directory "lisp")))

;;; ----------------------------------------------------
;;; ------------------ MIRRORS & REPO ------------------
;;; ----------------------------------------------------
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

(require 'use-package)


;;; ----------------------------------------------------
;;; -------------------- DEFAULT -----------------------
;;; ----------------------------------------------------

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
      auto-save-default nil
      inhibit-compacting-font-caches t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
(global-hl-line-mode t)
(global-visual-line-mode 1)

;; set font
(add-to-list 'default-frame-alist
	     ;;'(font . "FiraCode Nerd Font Mono-13:Medium")
	     '(font . "Monaco-13"))

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

(defun open-org-dir()
  (interactive)
  (find-file "~/Dropbox/org"))
(global-set-key (kbd "<f4>") 'open-org-dir)

;; open recent files
(require 'recentf)
(recentf-mode 1)
(setq recnetf-max-menu-item 10)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)


;; start emacs in fullscreen
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; show paired braces
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)


;;; ----------------------------------------------------
;;; ----------------------- CONSTS ---------------------
;;; ----------------------------------------------------
;;; (require 'init-const)

(defconst *is-mac* (eq system-type 'darwin))
(defconst *is-linux* (eq system-type 'gnu/linux))
(defconst *is-windows* (or (eq system-type 'ms-dos) (eq system-type 'windows-nt)))


;;; ------------------ PACKAGE AND MODE ----------------

;;; ----------------------------------------------------
;;; ------------------- COMPANY  -----------------------
;;; ----------------------------------------------------
(global-company-mode t)
(define-key company-active-map (kbd "<tab>") 'company-select-next)
;;(define-key company-active-map (kbd "<esc>") 'company-select-previous)
(setq company-idle-delay 0.0
      inhibit-startup-screen t)

;;; ----------------------------------------------------
;;; ------------------- MISCHELLEOUS -------------------
;;; ----------------------------------------------------
;;(use-package benchmark-init
;;  :init (benchmark-init/activate)
;;  :hook (after-init . benchmark-init/deactivate))

(use-package which-key
  :defer nil
  :config (which-key-mode))

(use-package restart-emacs)


;;; -----------------------------------------------------
;;; ----------------------- THEME -----------------------
;;; -----------------------------------------------------

;; (use-package gruvbox-theme
;; :init (load-theme 'gruvbox-dark-medium t))

(use-package kaolin-themes
  :init
  (load-theme 'kaolin-dark t)
  :config
  (setq kaolin-themes-italic-comments t))

;; status line
;;(use-package smart-mode-line
;;  :init
;;  (setq sml/no-confirm-load-theme t
;;	sml/theme 'respectful)
;;  (sml/setup))


;;; --------------------------------------------------
;;; ------------------- ORG MODE ---------------------
;;; --------------------------------------------------
;; org-mode keys
(setq org-agenda-files '("~/Dropbox/org/inbox.org"
			 "~/Dropbox/org/projects.org"
			 "~/Dropbox/org/reminder.org"))
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
      '((sequence "TODO(t)" "|" "DOING(n)" "DONE(d)")
	(sequence "CANCELLED(c@)" "|" "EVENT(e)" "IDEA(a)" "WATCH(w)")
;; right arrow: migrate to Futher; left arrow: migrate to Other collections
	(sequence "✝TODO(i)" "|" ">(f)" "<(o)")))

(setq org-todo-keyword-faces
      '(("CANCELLED" . (:foreground "#a89984"))
        ("DOING" . (:foreground "#f3c91f"))))

(setq org-tag-faces
      '(("work" . "#d65d0e")
	("personal" . "#fe8019")))

(setq org-src-fontify-natively t)


;;; --------------------------------------------------------------
;;; -------------------- ORG CAPTURE -----------------------------
;;; --------------------------------------------------------------
(setq org-capture-templates nil)


;; inbox-tasks
(add-to-list 'org-capture-templates
	     '("t" "Inbox [TODO]" entry
	       (file+headline "~/Dropbox/org/inbox.org" "Tasks")
	       "* TODO %? %^G" :kill-buffer t))

;; inbox-idea/note/thoughts
(add-to-list 'org-capture-templates
	     '("a" "Inbox [IDEA]" entry
	       (file+headline "~/Dropbox/org/inbox.org" "Thoughts")
               "* IDEA %? \n%u" :kill-buffer t))

;; inbox-event
(add-to-list 'org-capture-templates
	     '("e" "Inbox [EVENTS]" entry
	       (file+headline "~/Dropbox/org/inbox.org" "Events")
               "* EVENT %? %U" :kill-buffer t))

;; inbox-note
(add-to-list 'org-capture-templates
	     '("n" "Inbox [NOTE]" entry
	       (file+headline "~/Dropbox/org/inbox.org" "Thoughts")
	       "* NOTE %? %^G" :kill-buffer t))

;; inbox-reading
(add-to-list 'org-capture-templates '("r" "Reading"))
(add-to-list 'org-capture-templates
	     '("rb" "Readings [Book]" entry
	       (file+headline "~/Dropbox/org/readings.org" "Book")
               "* TODO Title: %^{Title} \nSource: %^{Link} \n%u\n" :kill-buffer t))
(add-to-list 'org-capture-templates
	     '("ra" "Readings [Article]" entry
	       (file+headline "~/Dropbox/org/readings.org" "Article")
               "* TODO [[%^{Link}][%^{Title}]] \n%u\n" :kill-buffer t))

;; reminder
(add-to-list 'org-capture-templates
             '("T" "Tickler" entry
	      (file+headline "~/Dropbox/org/reminder.org" "Tickler")
              "* TODO %? %^G" :kill-buffer t))

(add-to-list 'org-capture-templates
             '("b" "Billing" plain
               (file+function "~/Dropbox/org/bills.org" find-month-tree)
               " | %U | %^{Type} | %^{Detail} | %^{Amount} |" :kill-buffer t))

(setq org-refile-targets '(("~/Dropbox/org/inbox.org" :maxlevel . 3)
                           ("~/Dropbox/org/reminder.org" :level . 1)
                           ("~/Dropbox/org/projects.org" :maxlevel . 2)
			   ("~/Dropbox/org/readings.org" :maxlevel . 1)
			   ("~/Dropbox/org/barn.org" :maxlevel . 5)))


(setq org-refile-use-outline-path 'file
      org-log-refile t)


;;; ---------------------- CAPTURE BILLS ---------------------
;; copied from https://www.zmonster.me/2018/02/28/org-mode-capture.html#org12c36ad
(defun get-year-and-month ()
  (list (format-time-string "%Y") (format-time-string "%m")))

(defun find-month-tree ()
  (let* ((path (get-year-and-month))
         (level 1)
         end)
    (unless (derived-mode-p 'org-mode)
      (error "Target buffer \"%s\" should be in Org mode" (current-buffer)))
    (goto-char (point-min))             ;移动到 buffer 的开始位置
    ;; 先定位表示年份的 headline，再定位表示月份的 headline
    (dolist (heading path)
      (let ((re (format org-complex-heading-regexp-format
                        (regexp-quote heading)))
            (cnt 0))
        (if (re-search-forward re end t)
            (goto-char (point-at-bol))  ;如果找到了 headline 就移动到对应的位置
          (progn                        ;否则就新建一个 headline
            (or (bolp) (insert "\n"))
            (if (/= (point) (point-min)) (org-end-of-subtree t t))
            (insert (make-string level ?*) " " heading "\n"))))
      (setq level (1+ level))
      (setq end (save-excursion (org-end-of-subtree t t))))
    (org-end-of-subtree)))

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)


;;; --------------------------------------------------
;;; ------------------- ORG BABEL --------------------
;;; --------------------------------------------------
(require 'org-tempo)
(setq org-src-fontify-natively t)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((lua . t)
   (python . t)
   (C . t)
   (sqlite . t)
   (latex . t)
   (emacs-lisp . t)))

;;; --------------------------------------------------
;;; ------------------ ORG BULLET- -------------------
;;; --------------------------------------------------
;;; enabling bullet will *significantly* slow the performance, see
;;; 1. https://github.com/sabof/org-bullets/issues/11
;;; 2. https://www.reddit.com/r/emacs/comments/98flwy/does_anyone_know_a_good_alternative_to_orgbullets/
;;; 3. https://www.reddit.com/r/emacs/comments/8ug077/orgbullets_slow_with_certain_fonts/
;;(require 'org-bullets)
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

;;; --------------------------------------------------
;;; ------------------ ORG JOURNAL -------------------
;;; --------------------------------------------------

(use-package org-journal
  :custom
  (org-journal-dir "~/Dropbox/org")
  (org-journal-file-type 'weekly)
  (org-journal-date-format "%m.%d %a")
  ;; must contain %Y
  ;; see https://github.com/bastibe/org-journal/blob/78d575213c7cf7c069e52bfc46430090c0500000/org-journal.el#L158
  (org-journal-file-format "%Y-%m-%d-%V.org")
  :config
  (setq org-journal-find-file #'find-file-other-window
	org-journal-enable-agenda-integration t))


;;; ---------------------------------------------------
;;; -------------------- ORG ROAM ---------------------
;;; ---------------------------------------------------
(executable-find "sqlite3")
(executable-find "dot")
(use-package org-roam
  :hook
  (after-init . org-roam-mode)
  :custom
  org-roam-directory "~/Dropbox/org/roam"
  :bind (:map org-roam-mode-map
	      (("C-c n l" . org-roam)
	       ("C-c n f" . org-roam-find-file)
	       ("C-c n c" . org-roam-capture)
	       ("C-c n g" . org-roam-graph))
	       :map org-mode-map
	       (("C-c n i" . org-roam-insert))
	       (("C-c n I" . org-roam-insert-immediate))))


(setq org-roam-capture-templates
      '(
        ("d" "default" plain (function org-roam-capture--get-point)
         "%?"
         :file-name "%<%Y%m%d%H%M%S>-${slug}"
         :head "#+title: ${title}\n#+roam_alias: \n#+roam_key: \n")
        ("g" "group")
        ("gr" "Reference" plain (function org-roam-capture--get-point)
         "* %^{Topic} \n 1. %?"
         :file-name "%<%Y%m%d%H%M%S>-${slug}"
         :head "#+title: ${title}\n#+roam_alias: \n#+roam_tags: \n")
        ("gb" "Group B" plain (function org-roam-capture--get-point)
         "%?"
         :file-name "%<%Y%m%d%H%M%S>-${slug}"
         :head "#+title: ${title}\n#+roam_alias: \n\n")))


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
(require 'org-roam-protocol)


;;; -------------------------------------------------------
;;; -------------------------- DEFT -----------------------
;;; -------------------------------------------------------
(use-package deft
  :bind ("<f8>" . deft)
  :commands (deft)
  :config (setq deft-directory "~/Dropbox/org/roam"
		deft-extensions '("org" "md" "txt" "tex")))


;;; -------------------------------------------------------
;;; ---------------------- CUSTOME ------------------------
;;; -------------------------------------------------------
;;; write cutome stuff to a singel file
(setq custom-file "~/.emacs.d/custom-file.el")
(load-file custom-file)
