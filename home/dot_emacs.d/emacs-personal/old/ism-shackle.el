(message "Shackle-Einstellungen werden geladen...")

(use-package shackle
  :init
  (setq shackle-default-alignment 'below
        shackle-default-size 0.3
        shackle-rules '((help-mode           :align below :select t)
                        (helpful-mode        :align below)
                   
                        (compilation-mode    :select t   :size 0.25)
                        ("*compilation*"     :select nil :size 0.25)
                        ("*ag search*"       :select nil :size 0.25)
                        ("*rg*"              :select t   :size 0.15)
                        ("*Flycheck errors*" :select t   :size 0.25)
                        ("*Warnings*"        :select nil :size 0.25)
                        ("*Error*"           :select nil :size 0.25)

                        ("*Org Links*"       :select nil   :size 0.2)

                        ; (neotree-mode                     :align left)
                        (magit-status-mode                :align bottom :size 0.5  :inhibit-window-quit t)
                        (magit-log-mode                   :same t                  :inhibit-window-quit t)
                        ; (magit-commit-mode                :ignore t)
                        (magit-diff-mode     :select nil  :align left   :size 0.5)
                        (git-commit-mode                  :same t)
                        (vc-annotate-mode                 :same t)
                        ("^\\*git-gutter.+\\*$" :regexp t :size 15 :noselect t)
                        ))
  :config
  (shackle-mode 1))

(provide 'ism-shackle)
