(message "Programmiereinstellungen (LSP) für javascript, css, usw. werden geladen...")

;; necesitamos esto porque si no no encuentra el typescript-language-server
;; ya está en .emacs
;;(setq exec-path (append exec-path '("~/.npm-global/bin")))

;; NOTA: web-mode funciona bien con vue con esta configuración
;; pero lo que nofunciona bien es un html normal, se me queda como colgado
;; entiendo que por el lsp. En teoría debería haber unaforma de habilitar
;; el lsp solo con vue y no con html normales haciendo un minor-mode
;; pero eso debería estar ya pensado.
;; Tampoco entiendo por qué carajos en web-mode no aparece ninguna info sobre lsp.

(require 'company-web-html)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ejs?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hbs?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.pug?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.astro?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . css-mode))
;(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
;;(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
;;(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-ts-mode))

;; atención: lo de los backends: en ism-lsp tenemos puesta la variable
;; lsp-completion-provider como :none
;; el motivo es que lsp pone antes de mis backends capf y es el únioc que luego usa
;; Pero lo que me interesa es que también use ese backend mío.
;; Pero de todas formas no funionca lo de :with para unir esos que están agrupados con el otro
;; y lo de :separate no sé qué hace sincerametne. Parece que sin eso funcinoa también
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  ;(setq web-mode-enable-current-column-highlight t)
  (setq web-mode-enable-current-element-highlight t)
  ;; esto no parece funcionar
  (set (make-local-variable 'company-backends)
       ;; '((company-capf company-ism-web-backend) company-dabbrev))
       '((company-capf company-ism-web-backend :separate) company-dabbrev))
)
(add-hook 'web-mode-hook 'my-web-mode-hook)
(add-hook 'web-mode-hook 'emmet-mode)
;; (add-hook 'web-mode-hook  #'lsp)
;; esto está ya en ism-prog-general:
;;(add-hook 'web-mode-hook  #'subword-mode)

;; Prettier
;; ver en ism-prettier.el

;; JS2
;; atención: parce ser que company-lsp ya no está soportado y
;; hay que usar company-capf
(defun my-js2-mode-hook ()
  "Hooks for JS mode."
  (define-key js2-mode-map (kbd "M-.") #'eglot-find-declaration)
  (set (make-local-variable 'company-backends)
       '(company-capf company-files company-yasnippet))
  (setq-local company-minimum-prefix-length 1)
  ;;(setq lsp-headerline-breadcrumb-enable nil)
  )

;; typescript
;; atención: parce ser que company-lsp ya no está soportado y
;; hay que usar company-capf
(defun my-typescript-mode-hook ()
  "Hooks for JS mode."
  (define-key typescript-mode-map (kbd "M-.") #'eglot-find-declaration)
  ;(setq-local lsp-ui-sideline-enable t)
  ;(setq-local lsp-ui-sideline-enable nil)
  (set (make-local-variable 'company-backends)
       '(company-capf company-files company-yasnippet))
  (setq-local company-minimum-prefix-length 1)
  ;;(setq lsp-headerline-breadcrumb-enable nil)
  )

;; importante s que para usar javascript-eslint con flycheck
;; ponemos una directory local variable tal y como tengo guardada con
;; las configs de javascript. Y tal y como se recomienda aquí:
;; https://www.flycheck.org/en/latest/user/syntax-checkers.html
;;(add-hook 'js2-mode-hook #'lsp)
(add-hook 'js2-mode-hook 'my-js2-mode-hook)
(add-hook 'typescript-mode-hook 'my-typescript-mode-hook)
;;(add-hook 'rjsx-mode-hook 'display-line-numbers-mode)
;;(add-hook 'js2-mode-hook 'git-gutter-mode)

;; esto está en ism-prog-general
;;(add-hook 'js2-mode-hook #'subword-mode)


;; CSS

;; con lsp debería arrancar el servidor que aparece aquí
;; https://github.com/vscode-langservers/vscode-css-languageserver-bin
;; pero ahora mismo no sé si está archivado...
;; supongo que ahora será este
;; https://github.com/microsoft/vscode-css-languageservice
;; https://emacs-lsp.github.io/lsp-mode/page/lsp-css/

;; (defun my-css-mode-hook ()
;;   "Hooks for Web mode."
;;   (set (make-local-variable 'company-backends)
;;        '(company-css))
;;   )

;; NOTA: no consigo que funcione con lsp bien
;; y por eso dejo el otro sistema, aunque sigo sin entenderlo...

;; por lo que veo en la propia fuente de company-css ahora hay que usar
;; esto de company-capf
(defun my-css-mode-hook ()
  "Hooks for Web mode."
  (set (make-local-variable 'company-backends)
       '(company-capf))
  )

;;(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-hook 'css-mode-hook 'my-css-mode-hook)
;;(add-hook 'css-mode-hook #'lsp)
;;(add-hook 'css-mode-hook 'flycheck-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'hs-minor-mode)
;;(add-hook 'css-mode-hook 'display-line-numbers-mode)

;; PHP
;; al parecer para que funcione con laravel hay que instalar en el directorio
;; del proyecto esto:
;;
;; composer require --dev --with-all-dependencies barryvdh/laravel-ide-helper
;;
;; sin lo de --with-all-dependencies no se instala

(defun my-php-mode-hook ()
  "Hooks for PHP mode."
  (set (make-local-variable 'company-backends)
       '(company-capf))
  )

(add-hook 'php-mode-hook 'my-php-mode-hook)

;; VUE

;; esto ya está en lsp-general...
;; (add-hook 'vue-mode-hook #'lsp)
(add-hook 'vue-mode-hook #'emmet-mode)
;; ;; con esto se puede cambiar <h1> a <h2> y lo cambia en los dos sitios
(add-hook 'vue-mode-hook 'sgml-electric-tag-pair-mode)

(provide 'ism-webgeneral-lsp)
;;; ism-webgeneral-lsp.el ends here
