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
