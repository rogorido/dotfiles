(message "Loading ledger settings...")

(autoload 'ledger-mode "ledger-mode" "A major mode for Ledger" t)
(add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))

;; Required to use hledger instead of ledger itself.
;; http://unconj.ca/blog/using-hledger-with-ledger-mode.html
(setq ledger-mode-should-check-version nil
      ledger-report-links-in-register nil
      ledger-default-date-format "%Y/%m/%d"
      ledger-binary-path "/usr/bin/hledger")

;; no sé por qué carajo el puto company me da algunas pesadeces
;; lo deshabilito y pongo TAB para completion-at-point
;; también se puede usar C-c TAB para un comando muy bueno
(add-hook 'ledger-mode-hook
          (lambda ()
            (company-mode -1)))
(eval-after-load 'ledger-mode
  '(define-key ledger-mode-map [(tab)] 'completion-at-point))

;; esto lo tengo de aquí
;; https://github.com/ledger/ledger/blob/next/contrib/raw/dotemacs.el
;; lo he simplificado, pues tiene realmente más cosas
(add-hook 'ledger-report-mode-hook
          (lambda ()
            (hl-line-mode 1)
            (local-set-key (kbd "<RET>") 'ledger-report-visit-source) ; Make return jump to the right txn
            (local-set-key (kbd "<tab>") 'ledger-report-visit-source) ; Make tab jump to the right txn
            (local-set-key (kbd "n") '(lambda ()
                                        (interactive)
                                        (save-selected-window
                                          (next-line)
                                          (ledger-report-visit-source)))) ; Update a txn window but keep focus
            (local-set-key (kbd "p") '(lambda ()
                                        (interactive)
                                        (save-selected-window
                                          (previous-line)
                                          (ledger-report-visit-source)))) ; Update a txn window but keep focus


            ))

(provide 'ism-ledger)
;;; ism-ledger.el ends here
