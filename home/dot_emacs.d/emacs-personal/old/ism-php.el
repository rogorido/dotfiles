(message "PHP-Einstellungen werden geladen...")

;; ver notas sobre paquetes, etc. en cosaslinux.org 

(require 'php-mode)
(add-to-list 'auto-mode-alist '("\\.php?\\'" . php-mode))

;; realmente no hace falta instalar ningún paquete de lsp-php extra
;; pues lsp-mode ya lo tiene 
(add-hook 'php-mode-hook #'lsp)
;; al final uso lo que viene por defecto intelephense que se instala con
;; npm i intelephense -g 
(setq lsp-intelephense-server-command '("~/.npm-global/bin/intelephense" "--stdio"))

(require 'phpcbf)
(custom-set-variables
 '(phpcbf-executable "/.config/composer/vendor/bin/phpcbf")
 '(phpcbf-standard "PSR12"))

;; realmente para seleccionar este code styling checker lo mejor es
;; hacerlo con variables locales: ver en
;; https://www.flycheck.org/en/latest/user/syntax-checkers.html pero
;; básicamente: M-x add-dir-local-variable RET js-mode RET
;; flycheck-checker RET javascript-jshint

(setq flycheck-php-phpcs-executable "~/.config/composer/vendor/bin/phpcs")

(provide 'ism-php)
;;; ism-php.el ends here
