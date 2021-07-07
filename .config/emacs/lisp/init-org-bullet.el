;;; --------------------------------------------------
;;; ------------------ ORG BULLET- -------------------
;;; --------------------------------------------------
;;; enabling bullet will *significantly* slow the performance, see
;;; 1. https://github.com/sabof/org-bullets/issues/11
;;; 2. https://www.reddit.com/r/emacs/comments/98flwy/does_anyone_know_a_good_alternative_to_orgbullets/
;;; 3. https://www.reddit.com/r/emacs/comments/8ug077/orgbullets_slow_with_certain_fonts/
(use-package org-bullets)
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
