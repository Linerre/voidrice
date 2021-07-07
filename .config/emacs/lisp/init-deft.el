;;; -------------------------------------------------------
;;; -------------------------- DEFT -----------------------
;;; -------------------------------------------------------
(use-package deft
  :bind ("<f8>" . deft)
  :commands (deft)
  :config (setq deft-directory "~/Dropbox/org/roam"
		deft-extensions '("org" "md" "txt" "tex")))
