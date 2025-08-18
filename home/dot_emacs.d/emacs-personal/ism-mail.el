(message "Loading mail settings...")

;;(setq mail-user-agent 'mu4e-user-agent)
;;(setq mail-user-agent 'gnus-user-agent)
(setq mail-user-agent 'notmuch-user-agent)

(setq user-full-name "Igor Sosa Mayor")
(setq user-mail-address "igor.sosa@gmail.com")

(setq message-send-mail-function 'message-send-mail-with-sendmail)
;(setq sendmail-program "/usr/bin/msmtpq")
(setq sendmail-program "/usr/bin/msmtp")
(setq message-sendmail-f-is-evil nil
      message-sendmail-envelope-from 'header)
;; parece ser que hace falta esto para oponer enviar desde gnus
;; la clave es poner esa primera variable como evil
;; porque sin esa lo 2º no funciona...
;; http://www.emacswiki.org/emacs/GnusMSMTP
;; This is needed to allow msmtp to do its magic:
;(setq message-sendmail-f-is-evil 't)
;(setq message-sendmail-extra-arguments '("--read-envelope-from"))

; esto es para que gpg solo pregunte la contraseña una vez
; es decir, no contra-contraseña...
(setq epa-file-cache-passphrase-for-symmetric-encryption t)

; y esto para que los mensajes salga codificados bien...
(setq mm-coding-system-priorities '(iso-8859-1 iso-8859-15 utf-8))

; esto lo pongo porque me sale un mensajito inicial sobre
; que tengo configurado un  mail-mode-hook, a pesar de que el modo
; principal ahora es el message mode. Enitendo que se debe a que uso 
; message mode para los mensajes que envío desde emacs
; y el otro mail mode para lo que envío desde mutt...
(setq compose-mail-user-agent-warnings nil)

(setq password-cache-expiry 86400)      ; Time (in sec) to cache SMTP password

(defun ism-mail-mode-hook ()
  (turn-on-auto-fill) ;;; Auto-Fill is necessary for mails
;  (setq default-justification 'left)
  (setq fill-column 72)
  (turn-on-font-lock) ;;; Font-Lock is always cool *g*
;  (flush-lines "^\\(> \n\\)*> -- \n\\(\n?> .*\\)*")
                      ;;; Kills quoted sigs.
;  (not-modified)      ;;; We haven't changed the buffer, haven't we? *g*
;  (mail-text)         ;;; Jumps to the beginning of the mail text
  (setq make-backup-files nil)
  (setq-local global-hl-line-mode nil)
  ;(orgalist-mode)
)

(or (assoc "mutt" auto-mode-alist)
    (setq auto-mode-alist (cons '("mutt" . mail-mode) auto-mode-alist)))
(add-hook 'mail-mode-hook 'ism-mail-mode-hook)

(add-hook 'mail-mode-hook 'turn-on-flyspell 'append)
(add-hook 'message-mode-hook 'turn-on-flyspell 'append)
(add-hook 'mu4e-compose-mode-hook 'turn-on-flyspell 'append)
(add-hook 'mu4e-compose-mode-hook 'ism-mail-mode-hook)

;; con esto se salta lo que son comentarios, etc. en un mensaje a la hora
;; de las correcciones. 
(add-hook 'message-mode-hook 
          (lambda nil
            (make-local-variable 'ispell-check-comments)
            (setq ispell-check-comments nil)
            (make-local-variable 'ispell-skip-region-alist)
            (add-to-list 'ispell-skip-region-alist '("<#[^>]*>"))))


;; Esto es una versión más complicada de lo anteiror que es lo que
;; estuvo funcionando mucho tiempo. Hace dos cosas: definir C-c C-c
;; para enviar (aunque también se puede usar C-x #). Y segundo lo de
;; los putos colores: La razón es que con el tema actual me sale mal
;; en la consola y si uso lo del server-visit-hook, me da otro tipo de
;; problemas. Espero que esto no tenga consecuencias laterales...
(add-hook
   'mail-mode-hook
   (lambda ()
     (progn
       ;; primero hacemos lo de los colores, porque de hecho parece
       ;; que si no, me lo jode... 
         (when (string-match "^/tmp/mutt-" (buffer-file-name))
           (progn (set-background-color "black")
                  (set-foreground-color "green")))
         ;; y ahora hacemos lo de C-c C-c
         (define-key mail-mode-map [(control c) (control c)]
           (lambda ()
             (interactive)
             (save-buffer)
             (server-edit))))))

;; esto no está repetido?
(autoload 'muttrc-mode "muttrc-mode.el"
  "Major mode to edit muttrc files" t)
(setq auto-mode-alist
      (append '(("muttrc\\'" . muttrc-mode))
	      auto-mode-alist))

(provide 'ism-mail)
;;; ism-mail.el ends here
