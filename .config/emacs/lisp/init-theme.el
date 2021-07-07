;;; -----------------------------------------------------
;;; ----------------------- THEME -----------------------
;;; -----------------------------------------------------

;; (use-package gruvbox-theme
;; :init (load-theme 'gruvbox-dark-medium t))

(use-package kaolin-themes
  :init
  (load-theme 'kaolin-light t)
  :config
  (setq kaolin-themes-italic-comments t))


(provide 'init-theme)
;;; theme ends here
