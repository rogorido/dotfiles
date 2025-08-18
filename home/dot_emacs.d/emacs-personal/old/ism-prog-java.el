(require 'cc-mode)

(use-package lsp-mode
  :ensure t
  :init (setq lsp-eldoc-render-all nil
              lsp-highlight-symbol-at-point nil))

(use-package company-lsp
  :after  company
  :ensure t
  :config
  (setq company-lsp-cache-candidates t
        company-lsp-async t))

(use-package lsp-ui
  :ensure t
  :config
  (setq lsp-ui-sideline-update-mode 'point)
  (setq lsp-ui-sideline-ignore-duplicate t)
  )

(use-package lsp-java
  :ensure t
  :config
  (add-hook 'java-mode-hook
	    (lambda ()
	      (setq-local company-backends (list 'company-lsp))))

  (add-hook 'java-mode-hook 'lsp-java-enable)
  (add-hook 'java-mode-hook 'flycheck-mode)
  (add-hook 'java-mode-hook 'company-mode)
  (add-hook 'java-mode-hook 'lsp-ui-mode))

(use-package dap-mode
  :ensure t
  :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-mode t))

(use-package dap-java
  :after (lsp-java))

;; esto no funciona no sé por qué...
;; (use-package lsp-java-treemacs
;;   :after (treemacs))

(provide 'ism-prog-java)
;;; ism-prog-javascript.el ends here
