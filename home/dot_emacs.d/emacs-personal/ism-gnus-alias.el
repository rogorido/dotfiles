(message "Loading gnus-alias...")

(require 'gnus-alias)

;; atención los guarda de forma predeterminada en sent por lo que tengo todo en sent!
(setq gnus-alias-identity-alist
      '(("main" nil
         "Igor Sosa Mayor <igor.sosa@gmail.com>" nil (("Fcc" . "sent")) nil nil)
	("listas" nil "Igor Sosa Mayor <joseleopoldo1792@gmail.com>" nil nil nil
	 "~/.mutt/signature-joseleopoldo1792")
	("eui" nil "Igor Sosa Mayor <Igor.Sosa@eui.eu>" nil nil nil
	  "~/.mutt/signature-eui")
        ("geo" nil "Igor Sosa Mayor <igor.sosa@georeligion.org>" nil
         (("Fcc" . "geo/Sent"))
         nil
	 "~/.mutt/signature")
        ))

;; tiene tres puntos:
;; 1. es el nombre general de la regla
;; 2. luego viene la regla:
;; 3. la identidad que hay que aplicar

;; en teoría debería usar algo así
;;      ("geo" ("from" "igor\\.sosa" previous) "geo")
;; para responder, pero no funciona
;; no será un problema de notmuch que no reconoce lo de previous?
;; https://nmbug.notmuchmail.org/nmweb/show/8738hogoul.fsf%40ta.scs.stanford.edu
;; tal vez algo de esto?
;; https://nmbug.notmuchmail.org/nmweb/show/vu7c70lgeqshb8.fsf%40chaotikum.eu
(setq gnus-alias-identity-rules '(
                                  ;;("eui" ("any" ".*eui.*" both) "eui")
                                  ("geo" ("to" "georeligion" previous) "geo")
                                  ;; este de abajo funciona
                                  ("pia" ("to" "bfriars\\.ox\\.ac\\.uk" current) "geo")
                                  ;; ver abajo
                                  ("eui" ("to" "\\(uva\\|uam\\|unican\\|ucm\\|usc\\|usal\\|uab\\|uoc\\|ufv\\)\\.\\(es\\|cat\\|edu\\)" current) "eui")
                                  ("newsgroup" ("Newsgroups" "^gmane.*" current) "listas")
                                  ;; ("gwene" ("Newsgroups" "^gwene.*" both) "general")
                                  ("personal" ("To" ".*igor\\.sosa@gmail\\.com.*" current) "main")
))
;; en lo de uva tengo cosas como: uva.es, uam.es pero también uoc.edu


;; (define-key message-mode-map "\C-c\C-p" 'gnus-alias-select-identity)
(setq gnus-alias-default-identity "eui")

(gnus-alias-init)

(provide 'ism-gnus-alias)
;;; ism-gnus-alias.el ends here
