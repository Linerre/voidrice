;;; GUI settings

;;; set font
(when (eq system-type 'darwin)
  (add-to-list 'default-frame-alist '(font . "Monaco-16")))

(when (eq system-type 'ms-dos)
  (add-to-list 'default-frame-alist '(font . "Consolas-14")))

;;; scroll/menu bars
(if (display-graphic-p)
  (progn
    (tool-bar-mode -1)
    (scroll-bar-mode -1)
    (menu-bar-mode -1)
    ;; start emacs in fullscreen
    (setq initial-frame-alist (quote ((fullscreen . maximized))))
   )
 )

(provide 'init-gui)
;;; init-gui ends here
