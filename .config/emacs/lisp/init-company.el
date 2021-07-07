;;; ----------------------------------------------------
;;; ------------------- COMPANY  -----------------------
;;; ----------------------------------------------------
(use-package company
  :init
  (global-company-mode t)
  (define-key company-active-map (kbd "<tab>") 'company-select-next)
;;(define-key company-active-map (kbd "<esc>") 'company-select-previous)
  :config
  (setq company-idle-delay 0.0
      inhibit-startup-screen t))

(provide 'init-company)
;;; init-company ends here
