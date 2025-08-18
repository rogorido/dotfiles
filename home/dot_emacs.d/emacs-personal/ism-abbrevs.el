(message "Loading abbrevs...")

;; save abbrevs when files are saved
;; you will be asked before the abbreviations are saved
;(setq save-abbrevs t)
(setq save-abbrevs 'silently)

;; reads the abbreviations file on startup
(quietly-read-abbrev-file)

;;para que active el modo de las abreviaciones
; (abbrev-mode 1)

;; cargamos en determinados modes
;; quitamos web-mode porque da problemas con emmet-mode
;; lo ideal sería que estuviera activo solo en html y no en css
(dolist (hook '(erc-mode-hook
                emacs-lisp-mode-hook
                telega-chat-mode-hook
                ;; twittering-edit-mode-hook
                text-mode-hook))
  (add-hook hook #'abbrev-mode))

(provide 'ism-abbrevs)
;;; ism-abbrevs.el ends here
