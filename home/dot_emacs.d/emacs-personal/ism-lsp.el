(message "Loading LSP...")

;; importante es lo de lsp-completion-provider
;; lo ponemos como none porque lsp añade company-capf a los backends que yo tengo definidos
;; pero el problema es que lo hace destruyendo lo que ya tengo. Es decir,
;; si me lo pone al inicio de todo y me agrupa el resto. Por eso le decimos que
;; no use ninguno y luego le pongo yo a mano lo de company-capf.

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "s-l")
    ;; con esto hacemos que ponga muchos más colores en varaibles, etc.
  (setq ccls-sem-highlight-method 'font-lock) ;; options font-lock or overlay

  ;; deshabilitamos flymake para que use flycheck
  (setq lsp-prefer-flymake nil)

  (setq lsp-enable-file-watchers nil)
  (setq lsp-completion-provider :none)

  ;; pero sinceramente no sé por qué se deshabilita todo esto...
  ;; entiendo que lo que usa es el propio ccls a través de lsp pero no
  ;; me queda del todo claro...
  (setq-default flycheck-disabled-checkers '(c/c++-clang
                                             c/c++-cppcheck
                                             c/c++-gcc))

  :hook (
         (web-mode . lsp-deferred)
         (c-mode-common-mode . lsp-deferred)
         (c++-mode . lsp-deferred)
         (yaml-mode . lsp-deferred)
         (python-mode . lsp-deferred)
;;         (js2-mode . lsp-deferred)
         (js-mode . lsp-deferred)
         (typescript-mode . lsp-deferred)
         (lisp-mode . lsp-deferred)
         (php-mode . lsp-deferred)
         (vue-mode . lsp-deferred)
         (vue-ts-mode . lsp-deferred)
;;         (emacs-lisp-mode . lsp-deferred)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp lsp-deferred)

;; The path to lsp-mode needs to be added to load-path as well as the
;; path to the `clients' subdirectory.
;; (add-to-list 'load-path (expand-file-name "lib/lsp-mode" user-emacs-directory))
;; (add-to-list 'load-path (expand-file-name "lib/lsp-mode/clients" user-emacs-directory))

(use-package lsp-ui
  :custom
  ;; lsp-ui-doc
  (lsp-ui-doc-enable nil)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-position 'top) ;; top, bottom, or at-point
  (lsp-ui-doc-max-width 120)
  (lsp-ui-doc-max-height 40)
  (lsp-ui-doc-use-childframe t)
  (lsp-ui-doc-use-webkit t)
  ;; lsp-ui-flycheck
  ;(lsp-ui-flycheck-enable nil)
  ;; lsp-ui-sideline
  (lsp-ui-sideline-enable nil)
  (lsp-ui-sideline-ignore-duplicate t)
  (lsp-ui-sideline-show-symbol t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-show-diagnostics nil)
  (lsp-ui-sideline-show-code-actions t)
  (lsp-ui-sideline-code-actions-prefix "")
  ;; lsp-ui-imenu
  (lsp-ui-imenu-enable t)
  (lsp-ui-imenu-kind-position 'top)
  ;; lsp-ui-peek
  ;; (lsp-ui-peek-enable t)
  ;; (lsp-ui-peek-peek-height 20)
  ;; (lsp-ui-peek-list-width 50)
  ;; (lsp-ui-peek-fontify 'on-demand) ;; never, on-demand, or always
  :preface
  (defun ladicle/toggle-lsp-ui-doc ()
    (interactive)
    (if lsp-ui-doc-mode
        (progn
          (lsp-ui-doc-mode -1)
          (lsp-ui-doc--hide-frame))
      (lsp-ui-doc-mode 1)))
  :bind
  (:map lsp-mode-map
        ("C-c R" . lsp-find-references)
        ("C-c S"   . lsp-ui-sideline-mode)
        ("C-c D"   . ladicle/toggle-lsp-ui-doc))
  :hook
  (lsp-mode . lsp-ui-mode))

;; should be in another place!
;; https://docs.astral.sh/ruff/editors/setup/#via-third-party-plugin
(require 'ruff-format)
(add-hook 'python-mode-hook 'ruff-format-on-save-mode)

(provide 'ism-lsp)
;;; ism-lsp.el ends here
