(message "XML/HTML-Einstellungen werden geladen...")

; ilumina los dos tags en XML
(add-to-list 'load-path "~/giteando/hl-tags-mode")
(require 'hl-tags-mode)
(add-hook 'sgml-mode-hook (lambda () (hl-tags-mode 1)))
(add-hook 'nxml-mode-hook (lambda () (hl-tags-mode 1)))


; con esto se cierra un tag en XML cuando
; se escribe </ 
(setq nxml-slash-auto-complete-flag t)

(provide 'ism-xml)
