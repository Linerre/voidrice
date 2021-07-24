;;; ------------------ MIRRORS & REPO ------------------

;;; sjtu mirrors often cause scanning error; switched to tuna.tsinghua [2020-07-24]
(setq package-archives '(("gnu"   . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/gnu/")
                         ("melpa" . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/melpa/")
                         ("org"   . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/org/")))
(package-initialize)
(require 'package)

;; sync signature checking
;;(setq package-check-signature nil)

;; initialize package manager
;;(unless (bound-and-true-p package--initialized)

;;; use $PATH from shell
(when (memq window-system '(pc ns x))
  (exec-path-from-shell-initialize))

;; sync with source
(unless package-archive-contents
  (package-refresh-contents))

;;(unless (package-installed-p 'use-package)
;;  (package-refresh-contents)
;;  (package-install 'use-package))

;;(setq use-package-always-ensure t
;;      use-package-always-defer t
;;      use-package-always-demand nil
;;      use-package-expand-minimally t
;;      use-package-verbose t)
;;(require 'use-package)

(provide 'init-elpa)
;;; init-elpa ends here
