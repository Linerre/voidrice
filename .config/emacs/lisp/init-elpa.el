;;; ----------------------------------------------------
;;; ------------------ MIRRORS & REPO ------------------
;;; ----------------------------------------------------

;;; Use sjtu mirrors
(setq package-archives '(("gnu"   . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/gnu/")
                         ("melpa" . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/melpa/")
                         ("org"   . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/org/")))

;; sync signature checking
(setq package-check-signature nil)
(require 'package)
;; initialize package manager
(unless (bound-and-true-p package--initialized)
  (package-initialize))

;; sync with source
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t
      use-package-always-defer t
      use-package-always-demand nil
      use-package-expand-minimally t
      use-package-verbose t)
(require 'use-package)

(provide 'init-elpa)
;;; init-elpa ends
