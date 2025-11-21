(message "Loading notmuch settings...")

(require 'notmuch)

(setq notmuch-show-logo nil)
(setq notmuch-column-control t)
(setq notmuch-hello-auto-refresh t)
;; (setq notmuch-hello-recent-searches-max 10)
(setq notmuch-hello-thousands-separator ".")

(setq notmuch-hello-sections
      '(notmuch-hello-insert-header notmuch-hello-insert-saved-searches
                                    notmuch-hello-insert-alltags notmuch-hello-insert-footer))

;; tengo en lo de mu4e
;; (setq bbdb-mail-user-agent 'mu4e-user-agent)
(setq bbdb-mail-user-agent 'notmuch-user-agent)

;;; Search
(setq notmuch-search-oldest-first nil)

(setq notmuch-search-result-format
      '(("date" . "%12s  ")
        ("count" . "%-7s  ")
        ("authors" . "%-30s  ")
        ("subject" . "%-80s  ")
        ("tags" . "(%s)")))

(setq notmuch-tree-result-format
      '(("date" . "%12s  ")
        ("authors" . "%-30s  ")
        ((("tree" . "%s")
          ("subject" . "%s"))
         . " %-80s  ")
        ("tags" . "(%s)")))

(setq notmuch-search-line-faces
      '(("unread" . notmuch-search-unread-face)
        ("flag" . notmuch-search-flagged-face)))

(setq notmuch-show-empty-saved-searches t)

(setq notmuch-saved-searches
      `(( :name "inbox (last month)"
                :query "tag:inbox and not tag:info and not tag:server and date:1M.."
                :sort-order newest-first
                :key ,(kbd "i"))
        ( :name "gmail (2 last months)"
                :query "tag:privat and date:2M.."
                :sort-order newest-first
                :key ,(kbd "p m"))
        ( :name "unread (inbox)"
                :query "tag:unread date:2M.."
                :sort-order newest-first
                :key ,(kbd "u"))
         ( :name "eui (unread)"
                :query "tag:eui and tag:unread"
                :sort-order newest-first
                :key ,(kbd "e u"))
        ( :name "eui (last 4 months)"
                :query "tag:eui and date:4M.."
                :sort-order newest-first
                :key ,(kbd "e x"))
        ( :name "berlin (unread)"
                :query "tag:berlin and tag:unread"
                :sort-order newest-first
                :key ,(kbd "f u"))
        ( :name "berlin (last 4 months)"
                :query "tag:berlin and date:4M.."
                :sort-order newest-first
                :key ,(kbd "f x"))
        ( :name "unread all"
                :query "tag:unread not tag:archived"
                :sort-order newest-first
                :key ,(kbd "U"))
        ( :name "geo (all)"
                :query "tag:geo"
                :sort-order newest-first
                :key ,(kbd "g a"))
        ( :name "geo (unread)"
                :query "tag:geo and tag:unread"
                :sort-order newest-first
                :key ,(kbd "g u"))
        ( :name "geo (server)"
                :query "tag:server and tag:unread"
                :sort-order newest-first
                :key ,(kbd "g s"))
        ( :name "info"
                :query "tag:unread and tag:info and tag:geo"
                :sort-order newest-first
                :key ,(kbd "g I"))))

;;; Tags
(setq notmuch-archive-tags '("-inbox" "+archived"))
(setq notmuch-message-replied-tags '("+replied"))
(setq notmuch-message-forwarded-tags '("+forwarded"))
(setq notmuch-show-mark-read-tags '("-unread"))
(setq notmuch-draft-tags '("+draft"))
(setq notmuch-draft-folder "drafts")
(setq notmuch-draft-save-plaintext 'ask)

;; (setq notmuch-tagging-keys
;;       `((,(kbd "a") notmuch-archive-tags "Archive (remove from inbox)")
;;         (,(kbd "c") ("+archived" "-inbox" "-list" "-todo" "-ref" "-unread") "Complete and archive")
;;         (,(kbd "d") ("+del" "-inbox" "-archived" "-unread") "Mark for deletion")
;;         (,(kbd "f") ("+flag" "-unread") "Flag as important")
;;         ;; (,(kbd "r") notmuch-show-mark-read-tags "Mark as read")
;;         (,(kbd "r") ("+ref" "-unread") "Reference for the future")
;;         (,(kbd "s") ("+spam" "+del" "-inbox" "-unread") "Mark as spam")
;;         (,(kbd "t") ("+todo" "-unread") "To-do")
;;         (,(kbd "u") ("+unread") "Mark as unread")))


;; lo quito por ahora
;; (setq notmuch-tag-formats
;;       '(("unread" (propertize tag 'face 'notmuch-tag-unread))
;;         ("flag" (propertize tag 'face 'notmuch-tag-flagged))))
;; (setq notmuch-tag-deleted-formats
;;       '(("unread" (notmuch-apply-face bare-tag `notmuch-tag-deleted))
;;         (".*" (notmuch-apply-face tag `notmuch-tag-deleted))))

;;; Email composition
(setq notmuch-mua-compose-in 'current-window)
(setq notmuch-mua-hidden-headers nil) ; TODO 2021-05-12: Review hidden headers
;; (setq notmuch-address-command nil)    ; FIXME 2021-05-13: Make it work with EBDB
(setq notmuch-always-prompt-for-sender t)
(setq notmuch-mua-cite-function 'message-cite-original-without-signature)
(setq notmuch-mua-reply-insert-header-p-function 'notmuch-show-reply-insert-header-p-never)
(setq notmuch-mua-user-agent-function #'notmuch-mua-user-agent-full)
;;(setq notmuch-maildir-use-notmuch-insert t) ;; TODO mirar qué es esto!

(setq notmuch-crypto-process-mime t)
(setq notmuch-crypto-get-keys-asynchronously t)

;; ver si quiero enviar un adjunto
(setq-default notmuch-mua-attachment-regexp
              "\\b\\(attach\\|attachment\\|attached\\|adjunto\\|adjunta\\)\\b")

(add-hook 'message-send-hook 'notmuch-mua-attachment-check)

;;; Reading messages
(setq notmuch-show-relative-dates t)
(setq notmuch-show-all-multipart/alternative-parts nil)
(setq notmuch-show-indent-messages-width 3) ;; para los threads
(setq notmuch-show-indent-multipart nil)
(setq notmuch-show-part-button-default-action 'notmuch-show-save-part)
(setq notmuch-show-text/html-blocked-images ".") ; block everything
(setq notmuch-wash-citation-lines-prefix 6)
(setq notmuch-wash-citation-lines-suffix 6)
(setq notmuch-wash-wrap-lines-length 100)
;; (setq notmuch-unthreaded-show-out nil)
;;(setq notmuch-message-headers '("From" "To" "Cc" "Subject" "Date"))
(setq notmuch-message-headers '("To" "Cc" "Subject" "Date"))
(setq notmuch-message-headers-visible t)

;; tengo el fcc en lo de ism-gnus-alias.el pero veo que también se puede hacer así
;; (setq notmuch-fcc-dirs '(("sean@hw\-ops.com" . "sean-hw-ops.com/sent")
;;                          ("sean.escriva@gmail.com" . "seanescriva-gmail.com/sent")
;;                          (".*" . "sent")))


;; de aquí
;; https://mu-discuss.narkive.com/sbIuadF0/always-gpg-sign-a-message-in-mu4e
;; realmente creo que hay otra mnaera de extraer ese campo que crea una mapcar de esos
(defun ism/sign-message-if-georeligion ()
  "Sign messages in a specified context."
  (interactive)
  (let ((header-value (message-fetch-field "From")))
    (when
        (string= header-value "Igor Sosa Mayor <igor.sosa@georeligion.org>")
      ;; (message "cierto")                
      (mml-secure-message-sign-pgpmime))
    ))

(add-hook 'message-send-hook 'ism/sign-message-if-georeligion)

;; https://wwwtech.de/articles/2016/jul/my-personal-mail-setup
(define-key notmuch-search-mode-map "d"
  (lambda ()
    "toggle deleted tag for thread"
    (interactive)
    (if (member "deleted" (notmuch-search-get-tags))
        (notmuch-search-tag '("-deleted"))
      (notmuch-search-tag '("+deleted" "-inbox" "-unread")))))

;; https://emacs.stackexchange.com/questions/63436/is-there-some-way-to-view-the-html-part-of-an-email-in-an-external-browser-or-as
(defun ism/notmuch-show-view-html+ ()
  "Open the text/html part of the current message using
`notmuch-show-view-part'."
  (interactive)
  (save-excursion
    (goto-char
     (prop-match-beginning
      (text-property-search-forward
       :notmuch-part
       "text/html"
       (lambda (value notmuch-part)
         (equal (plist-get notmuch-part :content-type)
                value)))))
    (notmuch-show-view-part)))

;; lista de direcciones que hay que abrir con navegador
;; unimos con string-join que realmente es de subst-x
;; creando una string que usamos luego como regexp
(defconst listadirecciones
  (string-join
   '("mensajes@uva" "googlealerts" "el-cultural"
     "frobenius-institut" "dialnet\\.noreply" "alianzaeditorial")
    "\\|"))

;;
;; (defun ism/--open-with-browser ()
;;   "For some senders we need always to open the email in a browser
;; because they send HTMl mails."
;;   (cond ((string-match listadirecciones
;;                        (notmuch-show-get-from))
;;          (ism/notmuch-show-view-html+)))
;;   )

;; ;; theoretically we should use a hook, but the hook notmuch-show-hook
;; ;; does not work I have the impression that the buffer is not ready when
;; ;; it is executed.
;; (advice-add 'notmuch-search-show-thread
;;             :after 'ism/--open-with-browser)

;; original es notmuch postpone
(define-key notmuch-message-mode-map (kbd "C-c C-p") 'gnus-alias-select-identity)
(define-key notmuch-show-mode-map (kbd "C-c C-v") 'ism/notmuch-show-view-html+)


(setq bbdb-mua-pop-up t)
(setq bbdb-mua-pop-up-window-size 5)

;; notmuch-setup convierte los comapny-backends en solo el de notmuch
;; que completa direccones, pero eso me me interesa.

;; en principio uso esto que añade esos dos backends AL FINAL (con esa t
;; final). Los añade agrupados. Praece que funciona. Si no usar la
;; versión que está abajo que lo único que hace es sustituir
;; cmpletamente los backends y por tanto perder company-notmuch que es
;; el que viene por defecto con las direcciones,e tc.
;; (defun my-notmuch-messagemode-hook ()
;;   (add-to-list 'company-backends '(company-ispell company-dabbrev) t)
;;   )

;; (add-hook 'notmuch-message-mode-hook 'my-notmuch-messagemode-hook)

(add-to-list 'load-path "~/latexpruebas/git/ol-notmuch/")

(require 'ol-notmuch)

(use-package notmuch-indicator
  :ensure t
  :after notmuch
  :config
  (setq notmuch-indicator-args
        '((:terms "tag:inbox and tag:unread and not tag:info and not tag:server and not tag:eui and date:1M.."
                  :label "@ ")
           (:terms "tag:unread and tag:eui" :label "# ")
           ;; (:terms "tag:unread and tag:eui" :label "👈")
          ;; (:terms "from:nathalie" :label "💕") 
          ))
  (setq notmuch-indicator-hide-empty-counters t)
  (notmuch-indicator-mode)
)

;; https://notmuchmail.org/emacstips/
(defun my-notmuch-mua-empty-subject-check ()
  "Request confirmation before sending a message with empty subject"
  (when (and (null (message-field-value "Subject"))
             (not (y-or-n-p "Asunto está vacío, ¿enviar de todas formas? ")))
    (error "Sending message cancelled: empty subject.")))

(add-hook 'message-send-hook 'my-notmuch-mua-empty-subject-check)

;; que se vea la dirección del destinatario en lugar de mi nombre
;; https://notmuchmail.org/emacstips/#index30h2
;; problemas:
;; 1. ahora solo vale para eui... Habría que cambiar lo de string-match a regex-match, etc.
;; 2. realmente solo vale para unthread y no para tree (en el caso de tree realmente
;; habŕia que hacerlo solo cuando hay un mensaje...)
(defun my/notmuch-unthreaded-show-recipient-if-sent (format-string result)
(let* ((headers (plist-get result :headers))
       (to (plist-get headers :To))
       (author (plist-get headers :From))
       (face (if (plist-get result :match)
                 'notmuch-tree-match-author-face
               'notmuch-tree-no-match-author-face)))
  (propertize
   (format format-string
           (if (string-match "Igor.Sosa@eui.eu" author)
               (concat "↦ " (notmuch-tree-clean-address to))
               (notmuch-tree-clean-address to)
             author))
   'face face)))

(setq notmuch-unthreaded-result-format
      '(("date" . "%12s  ")
        (my/notmuch-unthreaded-show-recipient-if-sent . "%-40.40s")
        ((("subject" . "%s"))
         . " %-54s ")
        ("tags" . "(%s)")))

(provide 'ism-notmuch)
;;; ism-notmuch.el ends here
