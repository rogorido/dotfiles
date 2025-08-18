(message "Auto-Completion wird geladen...")

(add-to-list 'load-path "/usr/share/emacs/site-lisp/auto-complete")
(require 'auto-complete-config)

;; creo que esto no hace falta para nada: aquí están definidos cosas
;; de verilog, cpp, java, haskell,... etc. que no me interesan mucho
;; de hecho, ni siquiera está lisp 
;(add-to-list 'ac-dictionary-directories "/usr/share/emacs/site-lisp/auto-complete/ac-dict")

;; originalmente ponemos solo la lista española
(setq ac-dictionary-files '("~/.dict"))

;; esto carga 3 sources y otras extras para algunos modos 
(ac-config-default)

(define-key ac-complete-mode-map [tab] 'ac-expand)
(define-key ac-complete-mode-map [return] 'ac-complete)

;; (setq-default
;;   ac-sources '(
;; 	       ;; ac-source-words-in-all-buffer
;; 	       ac-source-dictionary
;; 	       ac-source-abbrev
;; 	       ac-source-words-in-buffer
;; 	       ac-source-words-in-same-mode-buffers
;;  	      ))

;; esto es una cosa útil: permite usar C-s para buscar entre
;; los candidatos que salen en el popup de auto-complete
(setq ac-use-menu-map t)

; modos
(dolist (mode '(magit-log-edit-mode
                log-edit-mode org-mode text-mode mu4e-compose-mode
                git-commit-mode message-mode mail-mode latex-mode
                html-mode nxml-mode sh-mode jabber-chat-mode
                lisp-mode markdown-mode css-mode sql-mode
                sql-interactive-mode inferior-ess-mode
                inferior-emacs-lisp-mode erc-mode))
  (add-to-list 'ac-modes mode))


;; (defun ac-emacs-lisp-mode-setup ()
;;   (setq ac-sources '(ac-source-symbols ac-source-functions ac-source-words-in-same-mode-buffers)))

;; (defun my-ac-emacs-lisp-mode ()
;;   (setq ac-sources '(ac-source-symbols ac-source-functions ac-source-words-in-same-mode-buffers)))

;; (add-hook 'lisp-mode-hook 'my-ac-emacs-lisp-mode)

(setq-default ac-auto-start 4)
(ac-flyspell-workaround)

(provide 'ism-autocompletion)
