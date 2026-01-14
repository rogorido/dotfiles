(message "Loading ERC settings...")

(require 'erc)
(setq erc-modules '(autoaway autojoin button completion fill irccontrols
                             list match menu move-to-prompt netsplit networks
                             noncommands readonly ring spelling track))
(erc-update-modules)

;; 353 es lo de los nombres al inicio de conectarse 
(setq erc-hide-list '("324" "329" "332" "333" "353" "366"
                      "JOIN" "MODE" "NICK" "PART" "QUIT" "TOPIC"))

; no considera estas cosas para el erc-track-mode que aparece en la
; modeline
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
				"324" "329" "332" "333" "353" "477"))

; que no muestre en el modeline mensajes del server-buffer
(setq erc-track-exclude-server-buffer t)

;; cargamos lo de C-c C-c para saltar al buffer de ERC activo
(setq erc-track-enable-keybindings t)

; una variable para establecer cómo determina cuándo un buffer
; se puede considerar visible; entiendo que con nil es
; solo el frame activo, que sería lo que me interesa...
(setq erc-track-visibility nil)

; pone la señal de actividad antes de los modos
; realmente después (con t) sería estéticamente mejor, pero
; cuando tengo una ventana reducida a la mitad no se ve
(setq erc-track-position-in-mode-line 'before-modes)

;; Evitamos que use las faces del buffer en el modeline
;; porque no consigo que me funcione con mi theme.
(setq erc-track-use-faces nil)

;; no mostrar estos channels en el track
(setq erc-track-exclude '("#org-mode" "#archlinux" "#awesome" "##esperanto"
			   "#wikidata" ))

(setq erc-prompt ">>")
(setq erc-header-line-format nil); o ponerlo con "%t"

;; Kill buffers for channels after /part
(setq erc-kill-buffer-on-part t)
;; Kill buffers for private queries after quitting the server
(setq erc-kill-buffer-on-quit t)
;; Kill buffers for server messages after quitting the server
(setq erc-kill-server-buffer-on-quit t)

; no me gusta que se pueda hacer click en los nicks
(setq erc-button-buttonize-nicks nil)

; 10 mins y que me marque away
(setq erc-autoaway-idle-seconds 600)

;; (add-to-list 'erc-modules 'notifications)
(erc-autojoin-mode t)
 ;; (setq erc-autojoin-channels-alist
 ;;      '(("irc.libera.chat" "#emacs" "#archlinux")))

;; (setq erc-autojoin-channels-alist
;;        '(("libera.chat"  '("#emacs" "#archlinux"))
;; 	("irc.oftc.net" . "#awesome")))

;; (setq erc-nick "rogorido")
;(setq erc-nick "irsosama")
;(setq erc-log-p t)

;(setq erc-track-switch-direction 'importance)
;(global-set-key (kbd "C-c SPC") 'erc-track-switch-buffer)

;; (define-key erc-mode-map "\C-c\C-c" nil)
;; (define-key erc-mode-map "\C-c\C-e" nil)
;; (define-key erc-mode-map "\C-c\C-f" nil)
;; (define-key erc-mode-map "\C-c\C-p" 'erc-part-from-channel) ; realmente este es el original
;; ;(define-key erc-mode-map "\C-c\C-q" nil)
;; (define-key erc-mode-map "\C-c\C-r" nil)
;; (define-key erc-mode-map (kbd "RET") 'erc-send-current-line)

(setq erc-join-buffer 'bury) ; determina cómo se abre un nuevo erc-buffer
(setq erc-autojoin-timing 'ident)

(setq erc-insert-timestamp-function nil)
(setq erc-insert-away-timestamp-function nil)

; quita una pesadez de warning
(setq erc-warn-about-blank-lines nil)

(defface erc-keyword-face '((t (:foreground "dark red")))
      "ERC face to highlight occurances of the word erc"
      :group 'erc-faces)

(setq erc-keywords '("\\borg-?mode\\b" "\\berc\\b" "\\barch(linux)?\\b" "\\bhelm\\b"
		     "\\bgnus\\b" "[^.]\\borg\\b" "\\bevil\\b" "\\bhook\\b" "\\bdired\\b"
		     "\\bsmartparens\\b" "auto-?completion" "\\bcompany\\b" "maildir"
		     "hydra" "\\bIDE\\b" "e?shell" "\\bmodeline\\b" "\\bpowerline\\b"
		     "magit" "\\bivy\\b" "\\bsauron\\b" "\\b(key)?binding\\b"
		     "\\bcalc\\b" "bookmark" "\\b(ya)?snippets?\\b" "\\bsql\\b"
		     "\speedbar" "\\bimap\\b" "mu4e" "bbdb" "\\bpdf-?tools\\b"
		     "\\blatex\\b" "set-key" "projectile"
		     "fetchmail" "offlineimap" "\\bgnus\\b" "dovecot" "emms" "mingus"
		     "\\bmpd\\b" "notmuch" "spell" "gpg"
		     ;; cosas de archlinux
		     "journalctl"
                     ;; cosas de postgresql 
		     "journalctl"
                     "coalesce" "lateral" "schema" "window"
		     ;; cosas de awesome
		     "\\blain\\b" "tyrannical" "\\bexpose\\b" "\\brules\\b"
		     ))

(setq erc-max-buffer-size 400000)

(setq erc-pals '("sachac" "jwiegley" "forcer" "fenris_kcf" "djcb" "johnw"))

; para ignorar al bot ese
(setq erc-ignore-list '("rudybot" "fsbot"))

; con esto hace que ponga también en el buffer ese
; mensajes dirigidos a mí. Ver: http://www.emacswiki.org/emacs/ErcMatch
(setq erc-log-matches-types-alist
          '((keyword . "ERC Keywords")
            (current-nick . "Mensajes dirigidos a mí")))

;; activamos el track
(erc-track-mode 1)

; en ism-functions hay una serie de funciones para conectarse automática
; una idea se puede ver aquí
; http://emacs-fu.blogspot.de/2012/03/social-networking-with-bitlbee-and-erc.html

(setq erc-server-auto-reconnect nil)
;; con t lo itnenta entiendo hasta que lo consigue...
(setq erc-server-reconnect-attempts t)
;; cuánto tiempo espera...		       
(setq erc-server-reconnect-timeout 4)

;; esto hace que me salga así un poco a lo americano...
;(setq erc-fill-static-center 22)
;(setq erc-fill-function 'erc-fill-static)

;; https://github.com/drewbarbs/erc-status-sidebar
;(require 'erc-status-sidebar)

;; esto viene en la misma página del paquete y la finalidad es que
;; al hacer click en un channel no lo abra en una ventana nueva 
(defun my/erc-window-reuse-condition (buf-name action)
  (with-current-buffer buf-name
    (if (eq major-mode 'erc-mode)
        ;; Don't override an explicit action
        (not action))))

(add-to-list 'display-buffer-alist
             '(my/erc-window-reuse-condition .
               ;; NOTE: display-buffer-reuse-mode-window only
               ;; available in Emacs 26+
               (display-buffer-reuse-mode-window
                (inhibit-same-window . t)
                (inhibit-switch-frame . t)
                (mode . erc-mode))))

;; esto es para conectarse a gitter, pero ahora lo hago desde bitlbee 
;(add-to-list 'load-path "~/giteando/erc-gitter/")
;(require 'erc-gitter)
;(add-to-list 'erc-modules 'gitter)
;(erc-update-modules)

(setq erc-spelling-dictionaries '(("RodrigoRodriguez"   "castellano")
                                  ("#emacs"             "english")))

(erc-spelling-mode 1)

;; lo tengo de aquí:
;; http://home.thep.lu.se/~karlf/emacs.html
;; change header face if disconnected----------
(defface erc-header-line-disconnected
  '((t (:foreground "black" :background "indianred")))
  "Face to use when ERC has been disconnected.")

(defun erc-update-header-line-show-disconnected ()
  "Use a different face in the header-line when disconnected."
  (erc-with-server-buffer
   (cond ((erc-server-process-alive) 'erc-header-line)
         (t 'erc-header-line-disconnected))))

(setq erc-header-line-face-method 'erc-update-header-line-show-disconnected)

;; why do I have this?
(setq erc-prompt-for-password nil)
(setq erc-prompt-for-nickserv-password nil)

(erc-track-mode)

(provide 'ism-erc)
;;; ism-erc.el ends here
