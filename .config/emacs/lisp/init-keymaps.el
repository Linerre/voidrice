;;; keymaps
;;; Author: Errelin
;;; Last Change: 

;;; kill buffer
(global-set-key (kbd "C-x k") 'kill-this-buffer);;; set the default encoding system
 
;; open init.el
(defun open-init-file()
  (interactive)
  (find-file "~/.config/emacs/init.el"))

(global-set-key (kbd "<f2>") 'open-init-file)

;;; open org bank
(defun open-org-dir()
  (interactive)
  (find-file "~/Dropbox/org"))
(global-set-key (kbd "<f4>") 'open-org-dir)

;;; open posts
(defun open-longreads-dir()
  (interactive)
  (find-file "~/projects/posts/wechat"))
(global-set-key (kbd "<f5>") 'open-longreads-dir)
  
;;; open recent files
(require 'recentf)
(recentf-mode 1)
(setq recnetf-max-menu-item 10)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

(provide 'init-keymaps)
;;; keymaps ends here
