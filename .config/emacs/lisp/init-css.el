;;; init-css.el --- CSS support -*- lexical-binding: t -*-
;;; Author: Errelin
;;; Last Change:


;;; Make indentation offset 2 spaces (1 tab) globally
(use-package css-mode
  :config
  (setq-default css-indent-offset 2))

;;; from https://emacsredux.com/blog/2020/06/14/checking-the-major-mode-in-emacs-lisp/
;;; (if (derived-mode-p 'prog-mode)
;;;	(xxx-indent-offset 2)
;;;	(yyy-indent-offset 2)
;;;	...
;;;	)

(provide 'init-css)
;;; init-css.el ends here
