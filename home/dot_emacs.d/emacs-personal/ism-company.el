(message "Loading company and its settings...")

(use-package company
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        ;; (:map lsp-mode-map
        ;;  ("<tab>" . company-indent-or-complete-common))

  :custom
  ;;(company-idle-delay 0.05)
  (company-minimum-prefix-length 2)
  (company-echo-delay 0)
  (company-show-quick-access t)
  ;; con esto sigue la lista al bajar...
  (company-selection-wrap-around t)
  (company-tooltip-offset-display 'lines)
  (company-tooltip-flip-when-above t)
  (global-company-mode t))

(setq company-idle-delay
      (lambda () (if (company-in-string-or-comment) 0.1 0.3)))

;; Don't enable company-mode in below major modes, OPTIONAL
;;(setq company-global-modes '(not eshell-mode))

;;;; lo mío
;;;; aquí lo importante es que estos dos están agurpados
(setq company-backends '((company-ispell company-dabbrev) company-files))

;; ATENCIÓN: con esto sí que parecen funcionar los files:
;; (setq company-backends '((company-capf :separate company-dabbrev  company-files)))
;; el únioc problema por ejemplo en elisp es que me da un montón de opciones... sacadas de capf, Entiendo

;;(setq company-backends '((company-ispell company-dabbrev company-capf company-files)))

(setq ispell-alternate-dictionary "/home/igor/.dict")

(provide 'ism-company)
;;; ism-company.el ends here
