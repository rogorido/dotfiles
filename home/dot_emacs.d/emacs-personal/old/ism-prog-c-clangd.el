(message "Programmiereinstellungen (clangd) für C und C++ werden geladen...")

;; tiene el problema ahora mismo (nov 2019) con respecto a ccls que por ejemplo
;; no es capaz de usar lo de origami... que realmente tampoco lo uso
;; parece tal vez un poco más rápido.

(setq-default c-basic-offset 4)

(require 'git-gutter)
(add-hook 'c-mode-common-hook 'git-gutter-mode)
(add-hook 'c++-mode-hook 'git-gutter-mode)

(add-hook 'c-mode-common-hook 'display-line-numbers-mode)

(use-package lsp-mode
  :commands lsp
  :init
  ;; con esto sale arriba una ventanita con info sobre el método, etc.
  ;; pero realmente ya sale abajo en el minibuffer...
  (setq lsp-ui-doc-include-signature t)

  ;; deshabilitamos flymake para que use flycheck
  (setq lsp-prefer-flymake nil)

  ;; esto hay que deshabilitarlo??
  ;; (setq-default flycheck-disabled-checkers '(c/c++-clang
  ;;                                            c/c++-cppcheck
  ;;                                            c/c++-gcc)))
  )
  
;; (use-package lsp-ui
;;   :commands lsp-ui-mode
;;   :init
;;   ;; con esto sale una ventana lateral con los métodos, etc.
;;   ;; y hacemos que salgan los métodos a la izquierda de su nombre.
;;   ;; se puede mover con right/left y con M-Ret saltamos al punto 
;;   (setq lsp-ui-imenu-kind-position 'left)

;;   ;; entiendo que esto quita esa info que sale a la derecha.
;;   (setq lsp-ui-sideline-enable t)
;;   )

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
  (lsp-ui-flycheck-enable nil)
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
  (lsp-ui-peek-enable t)
  (lsp-ui-peek-peek-height 20)
  (lsp-ui-peek-list-width 50)
  (lsp-ui-peek-fontify 'on-demand) ;; never, on-demand, or always
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
        ("C-c C-r" . lsp-ui-peek-find-references)
        ;("C-c C-j" . lsp-ui-peek-find-definitions)
        ;("C-c i"   . lsp-ui-peek-find-implementation)
        ("C-c m"   . lsp-ui-imenu)
        ("C-c s"   . lsp-ui-sideline-mode)
        ("C-c D"   . ladicle/toggle-lsp-ui-doc))
  :hook
  (lsp-mode . lsp-ui-mode))

(use-package company-lsp
  :commands company-lsp )

;; en la página web ponen esto que no sé qué consecuencias tiene...
;; https://github.com/MaskRay/ccls/wiki/lsp-mode#ccls-navigate
;; (setq company-transformers nil
;;       company-lsp-async t
;;       company-lsp-cache-candidates nil)

(setq flycheck-highlighting-mode 'lines)

(add-hook 'c-mode-common-hook #'lsp)

(add-hook 'c-mode-common-hook
          (function (lambda ()
                    (add-hook 'before-save-hook
                              'clang-format-buffer))))

;; https://github.com/ch1bo/flycheck-clang-tidy
;; las opciones posibles están en:
;; https://clang.llvm.org/extra/clang-tidy/checks/list.html
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-clang-tidy-setup))

(provide 'ism-prog-c-clangd)

;;; ism-prog-c-clangd.el ends here
