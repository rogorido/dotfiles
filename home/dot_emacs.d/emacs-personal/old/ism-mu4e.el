(message "mu4e-Einstellungen werden geladen...")

(require 'mu4e)
;;(require 'org-mu4e)

;; Load BBDB
(autoload 'bbdb-insinuate-mu4e "bbdb-mu4e")
(bbdb-initialize 'message 'mu4e)

;; y luego lo general 
(setq bbdb-mail-user-agent 'mu4e-user-agent)
;(setq mu4e-view-mode-hook 'bbdb-mua-auto-update visual-line-mode)
(setq mu4e-compose-complete-addresses nil)
(setq bbdb-mua-pop-up t)
(setq bbdb-mua-pop-up-window-size 5)
(setq mu4e-view-show-addresses t)

;; Only needed if your maildir is _not_ ~/Maildir
(setq mu4e-root-maildir "~/Mail"
      mu4e-sent-folder   "/sent"
      mu4e-drafts-folder "/drafts"
      mu4e-trash-folder  "/trash")

; https://stackoverflow.com/questions/39513469/mbsync-error-uid-is-beyond-highest-assigned-uid
(setq mu4e-change-filenames-when-moving t)

;(setq mu4e-compose-reply-to-address "igor.sosa@gmail.com")

;; (setq mu4e-user-mail-address-list '("igor.sosa@gmail.com" "Igor.Sosa@eui.eu"
;; 				    "igor.sosa_mayor@uni-erfurt.de" "igor.sosa@uva.es"))
;; ;(setq mu4e-user-mail-address-list '("igor.sosa@gmail.com"))

;(setq mu4e-get-mail-command "fetchmail -f ~/.fetchgmail")
(setq mu4e-get-mail-command "true")

; sirve para que guarde el email queue...
(setq smtpmail-queue-dir "~/Mail/queue/")

; con esto se evita que me salgan los emails
; de respuesta en la inbox 
(setq mu4e-headers-include-related nil)

(setq mu4e-compose-complete-only-personal t)
; esto mata el buffer al salir
(setq message-kill-buffer-on-exit t)
;(setq mu4e-update-interval 300)

(setq mu4e-headers-show-threads nil
      mu4e-headers-results-limit 30
;      mu4e-compose-signature-auto-include nil ; quita ese signatura propia que pone...
      mu4e-compose-signature-auto-include t ; quita ese signatura propia que pone...
      mu4e-view-show-addresses t
      mu4e-view-show-images nil
;      mu4e-view-wrap-lines nil
      mu4e-use-fancy-chars nil
      ;mu4e-headers-sort-revert nil
      mu4e-confirm-quit nil)

;(setq mu4e-view-prefer-html t)
;(setq mu4e-html2text-command "w3m")
;(setq mu4e-html2text-command "w3m -dump -cols 80 -T text/html") 
;(setq mu4e-html2text-command "html2text -utf8 -width 72")


; la última t sirve para que lo ponga al final de la lista
;(add-to-list 'mu4e-bookmarks '("size:5M..500M" "Big messages" ?b) t)
;(add-to-list 'mu4e-bookmarks '("mime:application/pdf" "Pdf attachments" ?P) t)

(setq mu4e-maildir-shortcuts
         '( ("/inbox"     . ?i)
            ("/eui/INBOX"      . ?e)
            ("/sent"      . ?s)
            ("/uva/INBOX"      . ?v)
            ("/uva/Enviados"      . ?O)
            ("/uva/INBOX.Infos"      . ?I)
            ("/geo/INBOX"      . ?G)
))

(setq mu4e-headers-fields
         '( (:date          .  25)
            (:flags         .   6)
            (:from-or-to         .  30)
            (:subject       .  nil)))

;(setq mu4e-attachment-dir (file-name-expand "~/latexpruebas"))


;(add-hook 'mu4e-compose-mode-hook 'mu4e-change-user-based-on-maildir)
;(add-hook 'mu4e-compose-mode-hook (lambda ()                    
;                               (setq auto-fill-function org-auto-fill-function
;                                )))

;(add-hook 'mu4e-compose-mode-hook 'auto-complete-mode)

;; new message-view for mu4e, based on the Gnus' article-view
;(setq mu4e-view-use-gnus t)

(add-hook 'mu4e:main
 (lambda ()
 (local-set-key (kbd "m") 'mu4e-compose-new)
 (define-key mu4e-main-mode-map "m" 'mu4e-compose-new)
 )
)

; al parecer mu4e no usa como estandar lo de:
; On %a, %b %d %Y, %N wrote:\n"
; con esto se consigue...
;(setq message-citation-line-function
;          'messages-insert-formatted-citation-line)

(defun my-mu4e-choose-from ()
  "Choose the From field from user mail address list"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (not (looking-at "From: ")) (forward-line))
    (kill-line)
    (insert (concat "From: " user-full-name " <>"))
    (backward-char)
    (insert
     (ido-completing-read "From: " (mu4e-personal-addresses)))))

(define-key message-mode-map (kbd "C-c C-f f") 'my-mu4e-choose-from)

(setq mu4e-headers-seen-mark '("S" . "☑")
      mu4e-headers-new-mark '("N" . "✉")
      mu4e-headers-replied-mark '("R" . "↵")
      mu4e-headers-passed-mark '("P" . "⇉")
      mu4e-headers-encrypted-mark '("x" . "⚷")
      mu4e-headers-signed-mark '("s" . "✍")
      mu4e-headers-empty-parent-prefix '("-" . "○")
      mu4e-headers-first-child-prefix '("\\" . "━▶")
      mu4e-headers-has-child-prefix '("+" . "●")
      mu4e-headers-default-prefix '("|" . "○"))

(require 'org-mu4e)
;(mu4e-maildirs-extension)


(setq mu4e-contexts
      `( ,(make-mu4e-context
	   :name "Private"
	   :enter-func (lambda () (mu4e-message "Cargando el contexto Privado"))
	   ;; leave-func not defined
	   :match-func (lambda (msg)
			 (when msg (mu4e-message-contact-field-matches msg :to "igor.sosa@gmail.com")))
	   :vars '(  ( mu4e-compose-reply-to-address          . "igor.sosa@gmail.com" )
		     ( user-full-name         . "Igor Sosa Mayor" )
		     ( user-mail-address      . "igor.sosa@gmail.com"  )
		     ( mu4e-sent-folder  .  "/sent")
		     ( mu4e-compose-signature . "")))
	 ;; ,(make-mu4e-context
	 ;;   :name "Erfurt"
	 ;;   :enter-func (lambda () (mu4e-message "Cargando el contexto Erfurt"))
	 ;;   ;; leave-fun not defined
	 ;;   :match-func (lambda (msg)
	 ;;        	 (when msg (mu4e-message-contact-field-matches msg :to "igor.sosa_mayor@uni-erfurt.de")))
	 ;;   :vars '(  ( mu4e-compose-reply-to-address          . "igor.sosa_mayor@uni-erfurt.de" )
	 ;;             ( user-full-name         . "Igor Sosa Mayor" )
	 ;;             ( user-mail-address      . "igor.sosa_mayor@uni-erfurt.de" )
	 ;;             ( mu4e-sent-folder  .  "/Erfurt/Sent")
	 ;;             ( mu4e-compose-signature .
	 ;;        			      (concat
	 ;;        			       ":: DDr. Igor Sosa Mayor :: igor.sosa_mayor@uni-erfurt.de ::\n"
	 ;;        			       ":: http://www.uni-erfurt.de/                             ::\n"
	 ;;        			       ":: Nordhäuser Str. 74, 99089 Erfurt                      ::"))))
	 ,(make-mu4e-context
	   :name "Valladolid"
	   :enter-func (lambda () (mu4e-message "Cargando el contexto Valladolid"))
	   ;; leave-fun not defined
	   :match-func (lambda (msg)
			 (when msg (mu4e-message-contact-field-matches msg :to "igor\.sosa@uva\.es")))
	   :vars '(  ( mu4e-compose-reply-to-address          . "igor.sosa@uva.es" )
		     ( user-full-name         . "Igor Sosa Mayor" )
		     ( user-mail-address      . "igor.sosa@uva.es" )
		     ( mu4e-sent-folder  .  "/uva/Enviados")
		     ( mu4e-compose-signature .
					      (concat
					       ":: Dr.Dr. Igor Sosa Mayor              Tlf: 0034 983 42 66 38        ::\n"
                                               ":: https://twitter.com/rogorido        https://www.georeligion.org/  ::\n"
                                               ":: Proyecto de investigación nacional (RTI2018-101224-B-I00)         ::\n"
                                               ":: https://dominicans.georeligion.org/                               ::\n"))))
         ,(make-mu4e-context
	   :name "Geo"
	   :enter-func (lambda () (mu4e-message "Cargando el contexto Georeligion"))
	   ;; leave-fun not defined
	   :match-func (lambda (msg)
			 (when msg (mu4e-message-contact-field-matches msg :to "igor\.sosa@georeligion\.org")))
	   :vars '(  ( mu4e-compose-reply-to-address          . "igor.sosa@georeligion.org" )
		     ( user-full-name         . "Igor Sosa Mayor" )
		     ( user-mail-address      . "igor.sosa@georeligion.org" )
		     ( mu4e-sent-folder  .  "/geo/Sent")
		     ( mu4e-compose-signature .
					      (concat
					       ":: Dr.Dr. Igor Sosa Mayor              Tlf: 0034 983 42 66 38        ::\n"
                                               ":: https://twitter.com/rogorido        https://www.georeligion.org/  ::\n"
                                               ":: Proyecto de investigación nacional (RTI2018-101224-B-I00)         ::\n"
                                               ":: https://dominicans.georeligion.org/                               ::\n\n"
                                               ":: GPG key = 554F 2C8C 0C5E B63B 18A2  A3A3 9BE0 20BF 507F BBFD      ::\n"
                                               ))))
         ))


;; bueno, el manual está un poco confuso, pero claramente
;; para que coja el contexto que está escogido a la hora de componer
;; un nuevo mensaje, la solución es esta... 
(setq mu4e-compose-context-policy 'nil)

; lo tengo de:
; http://www.djcbsoftware.nl/code/mu/mu4e/Displaying-rich_002dtext-messages.html
(require 'mu4e-contrib)

(setq mu4e-html2text-command 'mu4e-shr2text)

(add-hook 'mu4e-view-mode-hook
  (lambda()
     ;; try to emulate some of the eww key-bindings
    (local-set-key (kbd "<tab>") 'shr-next-link)
    (local-set-key (kbd "<backtab>") 'shr-previous-link)))

;(require 'bbdb-loaddefs) 
;; (autoload 'bbdb-insinuate-mu4e "bbdb-mu4e")
;; (bbdb-initialize 'message 'mu4e 'gnus)
;; (setq bbdb-mail-user-agent (quote message-user-agent))
;; (setq mu4e-view-mode-hook (quote (bbdb-mua-auto-update visual-line-mode)))
;; (setq mu4e-compose-complete-addresses nil)

;; con esto si pulsamos aV en un mensaje
;; lo abre en el browser
(add-to-list 'mu4e-view-actions
             '("ViewInBrowser" . mu4e-action-view-in-browser) t) ;; read in browser

;; de aquí
;; https://mu-discuss.narkive.com/sbIuadF0/always-gpg-sign-a-message-in-mu4e
(defun sign-message-in-specified-context()
  "Sign messages in a specified context."
  (let* ((ctx (mu4e-context-current))
         (name (if ctx (mu4e-context-name ctx))))
    (when name
      (cond
       ((string= name "Geo")
        (mml-secure-message-sign-pgpmime))
       ;; ((string= name "account2")
       ;; (mml-secure-message-sign-pgpmime))
       ))))

(add-hook 'message-send-hook 'sign-message-in-specified-context)

(setq mml-secure-openpgp-sign-with-sender t)
(setq mml-secure-smime-sign-with-sender t)

(provide 'ism-mu4e)
;;; ism-mu4e.el ends here
