(message "bbdb-Einstellungen werden geladen...")

(require 'bbdb)
(bbdb-initialize 'gnus 'message)
;(bbdb-insinuate-gnus)

; esto parece que no es necesrio con lo anterior...
;(bbdb-insinuate-message)

; esto es al parecer para los grupos de contactos
; este rpimero no sé si hace falta...
;(add-hook 'mail-setup-hook 'bbdb-define-all-aliases)
(add-hook 'message-setup-hook 'bbdb-mail-aliases)

; en teoría con esto no me debería pasar eso de que
; algunos nombres no se completen, sino que salga sólo
; la dirección de email
;(setq bbdb-dwim-net-address-allow-redundancy t) ; bbdb2
(setq bbdb-mail-avoid-redundancy t) ;bbdb3

; entiendo que esto es para que no me salgan esos molestos
; mensajitos de que el nombre de la persona es diferente...
; debería funcionar con t, pero no funciona del todo...
; (setq bbdb-quiet-about-name-mismatches t)
; si se pone el tiempo de mostrar el mensaje a 0, funciona bien:
;(setq bbdb-quiet-about-name-mismatches 0)
; ahora hay que usar; bbdb-add-name 

; entiendo que quita la ventanita esa que sale cada vez
; que leo un mensaje...
;(setq bbdb-use-pop-up nil) ; v2
(setq bbdb-pop-up-layout nil); v3
(setq bbdb-mua-pop-up-window-size 0.1)
(setq bbdb-pop-up-window-size 0.2)

;to query whether to add outgoing messages, use this.
;(setq bbdb/send-auto-create-p 'prompt)
;(setq bbdb/send-prompt-for-create-p t)

; cycle through matches; this only works partially
(setq bbdb-complete-mail-allow-cycling t)

; entiendo que sirve para poder meter los numeros de tlf
; directamente sin que los modifique el jodido
(setq bbdb-phone-style nil) ; v3


(provide 'ism-bbdb)
;;; ism-bbdb.el ends here
