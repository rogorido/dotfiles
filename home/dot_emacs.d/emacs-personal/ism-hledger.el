(message "Loading hledger settings...")

;;; Basic configuration
(require 'hledger-mode)

;; To open files with .journal extension in hledger-mode
(add-to-list 'auto-mode-alist '("\\.journal\\'" . hledger-mode))
(add-to-list 'auto-mode-alist '("\\.ledger\\'" . hledger-mode))

;; Provide the path to you journal file.
;; The default location is too opinionated.
(setq hledger-jfile "~/.hledger.journal")

;;; Auto-completion for account names
;; For company-mode users,
;; (add-to-list 'company-backends 'hledger-company)

(provide 'ism-hledger)
;;; ism-hledger.el ends here
