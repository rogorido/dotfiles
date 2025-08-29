(message "Loading my SQL settings...")

; para que funcione con mariadb y salga bien el prompt
;(sql-set-product-feature 'mysql :prompt-regexp "^\\(?:mysql\\|mariadb\\).*> ")
(eval-after-load 'sql-mysql
  '(sql-set-product-feature 'mysql :prompt-regexp "^\\(?:mysql\\|mariadb\\).*> ")
)

; con esto se consigue que las líneas no terminen
; en la consola de SQL (iSQL-mode)
(add-hook 'sql-interactive-mode-hook
	  (lambda ()
	  (toggle-truncate-lines 1)))

;(sql-set-product 'postgres)

(defun my-sql-mode-hook ()
  "Hooks for SQL mode."
  ;; (setq-local lsp-ui-sideline-enable nil)
  ;; (set (make-local-variable 'company-backends)
  ;;      '(company-lsp company-files company-yasnippet))
  (setq-local company-minimum-prefix-length 1)
  (sql-set-product 'postgres)
  )

;(add-hook 'sql-mode-hook #'lsp-deferred)
(add-hook 'sql-mode-hook 'my-sql-mode-hook)

;; (setq lsp-sqls-connections
;;       '(((driver . "postgresql")
;;          (dataSourceName . "host=127.0.0.1 port=5432 user=igor dbname=dominicos sslmode=disable"))))

;; esto son las opciones para arrancar postgresql (bueno psql)
;; yo añado lo de -X porque sirve para que no lea el fichero
;; psqlrc porque me da problemas dentro de emacs
;; pero claro tiene el problema que no puedo definir mis propios
;; comandos. Encima no parece que se pueda escoger otro psqlrc...
(setq sql-postgres-options '("-P" "pager=off" "-X"))


;; en principio quito esto porque se puede poner un dir-locals.el
;; con valores
;; https://arjanvandergaag.nl/blog/using-emacs-as-a-database-client.html
;; (setq sql-database "dominicos"
;;       sql-server "localhost")

;; en principio esto graba los comandos de SQL
;; lo tengo de aquí: https://www.emacswiki.org/emacs/SqlMode
(defun my-sql-save-history-hook ()
  (let ((lval 'sql-input-ring-file-name)
        (rval 'sql-product))
    (if (symbol-value rval)
        (let ((filename 
               (concat "~/.emacs.d/sql/"
                       (symbol-name (symbol-value rval))
                       "-history.sql")))
          (set (make-local-variable lval) filename))
      (error
       (format "SQL history will not be saved because %s is nil"
               (symbol-name rval))))))

(add-hook 'sql-interactive-mode-hook 'my-sql-save-history-hook)

;;
;; Using now sqlformat for formatting
;; No solution is really convincing...
;;
(add-to-list 'load-path "~/giteando/sqlformat")
(require 'sqlformat)
(setq sqlformat-command 'sql-formatter)
;; Optional additional args
;; (setq sqlformat-args '("-s2" "-g")) ;;
(setq sqlformat-args nil) ;;
(add-hook 'sql-mode-hook 'sqlformat-on-save-mode)


;;
;; Old code for formatting SQL
;;

;; Capitalize keywords in SQL mode
;; (require 'sqlup-mode)
;; (add-hook 'sql-mode-hook 'sqlup-mode)
;; (add-hook 'sql-interactive-mode-hook 'sqlup-mode)
;; ;; Set a global keyword to use sqlup on a region
;; (global-set-key (kbd "C-c u") 'sqlup-capitalize-keywords-in-region)

;; ;; aquí se pueden añadir palabras para que no las convierta en
;; ;; mayúsculas. Cuidado porque no me queda clara la sintaxis de esto...
;; (add-to-list 'sqlup-blacklist "name")
;; (add-to-list 'sqlup-blacklist "id")

;;
;; I want to try

(provide 'ism-sql)
;;; ism-sql.el ends here
