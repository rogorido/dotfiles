(message "Jabber wird geladen...")

; con lo de git tenía puestas estas dos líneas
(add-to-list 'load-path "~/giteando/emacs-jabber/")
;(add-to-list 'load-path "~/abs/jabber-e/")

; esto es necesario?
(load "jabber-autoloads")

(require 'jabber)
(setq jabber-account-list
      '(("igor.sosa@gmail.com"
         (:network-server . "talk.google.com")
         (:connection-type . ssl))
	("joseleopoldo1792@gmail.com"
         (:network-server . "talk.google.com")
         (:connection-type . ssl))
	(("rogorido@jabber.org"))
 ))

;al parecer esto es para que no aparezcan los caretos
; con esto se evita que se descargue fotos de la gente
; que en principio se guardan en .jabber-avatars
(setq jabber-vcard-avatars-retrieve nil
      jabber-chat-buffer-show-avatar nil
      jabber-show-resources nil ; 'sometimes
      jabber-chat-buffer-format "*chat-%n*"
      jabber-roster-show-title nil ; mostrar/no mostrar el título del roster
      jabber-roster-show-bindings nil ; entiendo que quita esa cosa horrible de las teclas
      jabber-show-offline-contacts nil ; mostrar/no mostrar los contactos offline
      jabber-default-show "dnd" ; por defecto me muestra como ocupado
;      jabber-alert-message-wave "~/.emacs.d/pop.wav"
      jabber-alert-message-wave "/usr/share/sounds/pop.wav"
      ; autoaway
      jabber-autoaway-verbose nil ;  muestra un mensaje al pasar a autoaway
;      jabber-autoaway-timeout 1 ; funciona?
;      jabber-autoaway-methods 'jabber-current-idle-time ; ausencia de  interacciones con emacs
;      jabber-autoaway-method 'jabber-current-idle-time ; ausencia de  interacciones con emacs
;      jabber-autoaway-status "away"
      ;  la historia de jabber
      jabber-history-enabled t
      jabber-use-global-history nil
; ponemos estos dos a cero para que no me saque
; rollo de conversaciones anteriores con una persona...
       jabber-backlog-number 0
      jabber-backlog-days 0
)

; esto hay que ponerlo así y no con setq porque no funciona no se sabe pro qué
(custom-set-variables
 '(jabber-xprintidle-program "/usr/bin/xprintidle")
; '(jabber-autoaway-methods (quote jabber-current-idle-time))
; '(jabber-autoaway-methods (quote jabber-xprintidle-get-idle-time))
 '(jabber-autoaway-timeout 1)
 '(jabber-autoaway-priority 2)
 '(jabber-autoaway-status "Ich bin kurz weg")
 '(jabber-autoaway-xa-priority 1)                                                                                              
 '(jabber-autoaway-xa-status "Ich bin lange weg")
 '(jabber-autoaway-xa-timeout 30)
; '(jabber-auto-reconnect t)
)

; entiendo que marca las urls
(add-hook 'jabber-chat-mode-hook 'goto-address)

; activar autoaway
; ¿cómo es posible que esto no esté ya activado por defecto?

;(add-hook 'jabber-post-connect-hooks 'jabber-autoaway-start)
(add-hook 'jabber-post-connect-hooks 'jabber-send-current-presence)

; con esto se evita que esté dando la paliza
; de quién se conecta/desconecta, etc.
(remove-hook 'jabber-alert-presence-hooks 'jabber-presence-echo)

; información sobre emails en la cuenta
; no me parece que funcione muy bien...
;(require 'jabber-gmail)


(defvar libnotify-program "/usr/bin/notify-send")

(defun notify-send (title message)
  (start-process "notify" " notify"
		 libnotify-program "--expire-time=3000" title message))

(defun libnotify-jabber-notify (from buf text proposed-alert)
  "(jabber.el hook) Notify of new Jabber chat messages via libnotify"
  (when (or jabber-message-alert-same-buffer
            (not (memq (selected-window) (get-buffer-window-list buf))))
    (if (jabber-muc-sender-p from)
        (notify-send (format "(PM) %s"
                       (jabber-jid-displayname (jabber-jid-user from)))
               (format "%s: %s" (jabber-jid-resource from) text)))
      (notify-send (format "%s" (jabber-jid-displayname from))
             text)))

(add-hook 'jabber-alert-message-hooks 'libnotify-jabber-notify)
;(add-hook 'jabber-alert-message-hooks 'jabber-message-wave)
;(add-hook 'jabber-alert-message-hooks 'jabber-message-beep)

; para que ponga los smileys
;(require 'autosmiley)
;(add-hook 'jabber-chat-mode-hook 'autosmiley-mode)

(defvar ism/jabber-mensajes '("non più andrai" "Non so più cosa son, cosa faccio" "molt'onor, poco contante"
			      "Emacsnarr" "Mond, verstecke dich dazu" "Ciliegi" "Aprite, presto, aprite"
			      "Alimentando lluvias" "Glücklich ist, wer vergißt, was nicht zu ändern ist" "Antidora" 
			      "Ich, Narr, vergaß der Zauberdinge" "Uh, das ist der Teufel sicherlich!" 
			      "Bauern, Bonzen, Bomben" "Im Westen nichts Neues?" 
			      "Donaudampfschifffahrtsgesellschaftskapitänwitwenball und noch mehr"
			      "Erfordia turrita" "Erfurter der Welt, vereinigt euch!" "Nostagwien"
			      "If I were a carpenter..." "Contando cento passi" "Contare e camminare insieme, lo sai fare?"
			      "Niemand hat die Absicht, eine Mauer zu errichten" "In God we trust, all others must bring data"
			      "Extra collegium nulla salus" "Tutte le macchine rovescierò" "Godiam, fugace e rapid" 
			      "Non disperar..., chi sa?" "Sveglatevi nel cuore" "chissà quanto tempo ci vorrà per pulire"
			      "Eigentlich bin ich ganz anders, nur komme ich so selten dazu" "Lascia ch'io pianga"
			      )
  "Diferentes valores para poner como mensaje en jabber")

; el truco está en 
; (nth (random (length ism/jabber-mensajes)) ism/jabber-mensajes))
; nth NUMERO LISTA
; generamos 
(defun ism/mensaje-aleatorio ()
  (interactive)
  (random t)
  (setq jabber-default-status (nth (random (length ism/jabber-mensajes)) ism/jabber-mensajes))
)

(defun ism/escoger-mensaje ()
  "Escoger un mensaje para gtalk de la lista."
  (interactive)
  (setq mensaje (ido-completing-read "Mensaje: " ism/jabber-mensajes))
  (jabber-send-presence "dnd" mensaje "10")
)

(ism/mensaje-aleatorio)

(provide 'ism-jabber)
