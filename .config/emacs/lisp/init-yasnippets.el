;;; -------------------------------------------------------
;;; ---------------------- YASnippets ---------------------
;;; -------------------------------------------------------
(use-package yasnippet
  :config
  (setq yas-snippet-dirs
      ;; personal snippets
      '("~/.config/emacs/snippets")))

(yas-global-mode 1)
(setq yas-prompt-functions '(yas-ido-prompt yas-x-prompt yas-completing-prompt))

(use-package emmet-mode
  :hook
  (sgml-mode . emmet-mode)
  (css-mode  . emmet-mode))

(use-package jinja2-mode
  :hook
  (html-mode . jinja2-mode))

(provide 'init-yasnippets)
;;; yasnippets ends here
