;;; --------------------------------------------------
;;; ------------------- ORG MODE ---------------------
;;; --------------------------------------------------
;; org-mode keys
;;(setq org-agenda-files '("~/Dropbox/org/inbox.org"
;;			 "~/Dropbox/org/projects.org"
;;			 "~/Dropbox/org/reminder.org"))
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

;;(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c l") 'org-link-store-props)
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
