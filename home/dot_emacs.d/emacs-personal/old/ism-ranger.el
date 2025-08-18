(message "Ranger-Einstellungen werden geladen...")

(use-package ranger
  :disabled
  :ensure
  :config
  (ranger-override-dired-mode t)
  (setq ranger-cleanup-on-disable t
        ranger-show-dotfiles t
        ranger-parent-depth 1
        ranger-preview-file nil
        ranger-show-literal nil
        ranger-width-parents 0.25
        ranger-listing-switches "-alGh"
        ranger-max-preview-size 10))

(provide 'ism-ranger)
;;; ism-ranger.el ends here
