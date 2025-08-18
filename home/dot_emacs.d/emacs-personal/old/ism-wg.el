(message "Workgroup-Einstellungen werden geladen...")

(add-to-list 'load-path "~/giteando/workgroups.el/")
(require 'workgroups)
(setq wg-prefix-key (kbd "\C-z"))

;(setq wg-mode-line-on nil)
;(setq wg-mode-line-on t)
(workgroups-mode 1)

(provide 'ism-wg)
