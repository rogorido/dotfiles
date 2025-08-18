(message "Loading diminish...")

(require 'diminish)

(eval-after-load "undo-tree"
  '(diminish 'undo-tree-mode))

(eval-after-load "yas-minor-mode"
  '(diminish 'yas-minor-mode))

(eval-after-load "paredit"
  '(diminish 'paredit-mode))

(eval-after-load "auto-complete"
  '(diminish 'auto-complete-mode "ac"))

(eval-after-load "yasnippet"
  '(diminish 'yas-minor-mode))

(eval-after-load "flyspell"
  '(diminish 'flyspell-mode " ⓢ"))

;; (eval-after-load "counsel"
;;   '(diminish 'counsel-mode))

;(eval-after-load "workgroups"
;  '(diminish 'workgroups-mode))

(eval-after-load "eldoc"
  '(diminish 'eldoc-mode))

;; (eval-after-load "helm"
;;   '(diminish 'helm-mode))

(eval-after-load "guide-key"
  '(diminish 'guide-key-mode))

;; (eval-after-load "projectile"
;;   '(diminish 'projectile-mode " ☯"))

(eval-after-load "ledger"
  '(diminish 'ledger-mode))

(eval-after-load "erc"
  '(diminish 'erc-mode "erc"))

;(diminish 'abbrev-mode "Ab")
(diminish 'abbrev-mode)
(diminish 'lisp-mode "EL")
(diminish 'emacs-lisp-mode "EL")
(diminish 'auto-fill-function " Ⓕ")

(eval-after-load "editorconfig"
  '(diminish 'editorconfig-mode))

(eval-after-load "company-mode"
  '(diminish 'company-mode))

(eval-after-load "all-the-icons-dired-mode"
  '(diminish 'all-the-icons-dired-mode))

(provide 'ism-diminish)
;;; ism-diminish.el ends here
