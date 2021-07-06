
;;; ---------------------------------------------------
;;; -------------------- ORG ROAM ---------------------
;;; ---------------------------------------------------
;;(executable-find "sqlite3")
;;(executable-find "dot")
;;(use-package org-roam
;;  :hook
;;  (after-init . org-roam-mode)
;;  :custom
;;  org-roam-directory "~/Dropbox/org/roam"
;;  :bind (:map org-roam-mode-map
;;	      (("C-c n l" . org-roam)
;;	       ("C-c n f" . org-roam-find-file)
;;	       ("C-c n c" . org-roam-capture)
;;	       ("C-c n g" . org-roam-graph))
;;	       :map org-mode-map
;;	       (("C-c n i" . org-roam-insert))
;;	       (("C-c n I" . org-roam-insert-immediate))))
;;
;;
;;(setq org-roam-capture-templates
;;      '(
;;        ("d" "default" plain (function org-roam-capture--get-point)
;;         "%?"
;;         :file-name "%<%Y%m%d%H%M%S>-${slug}"
;;         :head "#+title: ${title}\n#+roam_alias: \n#+roam_key: \n")
;;        ("g" "group")
;;        ("gr" "Reference" plain (function org-roam-capture--get-point)
;;         "* %^{Topic} \n 1. %?"
;;         :file-name "%<%Y%m%d%H%M%S>-${slug}"
;;         :head "#+title: ${title}\n#+roam_alias: \n#+roam_tags: \n")
;;        ("gb" "Group B" plain (function org-roam-capture--get-point)
;;         "%?"
;;         :file-name "%<%Y%m%d%H%M%S>-${slug}"
;;         :head "#+title: ${title}\n#+roam_alias: \n\n")))
;;
;;(setq org-roam-capture-immediate-template
;;      '("d" "default" plain (function org-roam-capture--get-point)
;;	"%?"
;;	:file-name "%<%Y%m%d%H%S>-${slug}"
;;	:head "#+title: ${title}\n"
;;	:unnarrowed t
;;	:empty-lines-after 1))
;;
;;;;; ---------------------- ORG-ROAM ------------------------
;;
;;(use-package org-roam-server
;;  :config
;;  (setq org-roam-server-host "127.0.0.1"
;;	org-roam-server-port 9090
;;	org-roam-server-authenticate nil
;;	org-roam-server-export-inline-images t
;;	org-roam-server-network-poll t
;;	org-roam-server-network-arrows nil
;;	org-roam-server-network-label-truncate t
;;	org-roam-server-network-label-truncate-length 60
;;	org-roam-server-network-label-wrap-length 20))
;;(require 'org-roam-protocol)
