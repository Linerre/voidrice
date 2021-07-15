;;; Various emacs built-in options set for both GUI and TUI
;;; Author: Errelin
;;; Last Change: 
;;; set the default encoding system

;;; UTF-8
(prefer-coding-system 'utf-8)
(setq default-file-name-coding-system 'utf-8
      default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8) 

;;; no auto-saving
(setq make-backup-files nil
      auto-save-default nil
      inhibit-compacting-font-caches t)

;;; line numbers
(global-display-line-numbers-mode t)
(global-hl-line-mode t)
(global-visual-line-mode 1)
;;;(setq display-line-numbers-type 'relative)

;;; tab width
;; set default tab char's display width to 2 spaces
(setq-default tab-width 2)
;; TODO: remember to set tab size for python to 4 spaces

;; Set indent commands to always use spaces only
(progn
  ;; make indent commands use space only (never tab character)
  (setq-default indent-tabs-mode nil)
  ;; emacs 23.1 to 26, default to t
  ;; if indent-tabs-mode is t, it means it may use tab, resulting mixed space and tab
)

;; show paired braces
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; show week number in calendar view
(setq calendar-intermonth-text
      '(propertize
	(format "%2d"
		(car
		 (calendar-iso-from-absolute
		  (calendar-absolute-from-gregorian (list month day year)))))
	'font-lock-face 'calendar-iso-week-face))

(provide 'init-options)
;;; init-options ends here
