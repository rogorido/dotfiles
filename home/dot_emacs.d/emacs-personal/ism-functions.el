(message "Loading own functions...")

(defun ism/lanzando-todo ()
  "Configura Emacs con 9 tabs y aplicaciones específicas en ciertas tabs."
  (interactive)
  ;; Asegúrate de que `tab-bar-mode` esté activado
  (tab-bar-mode 1)
  ;; Nombres y configuraciones de los tabs
  (let ((tabs-config '(("Georeligion" nil)
                       ("Cataluña" nil)
                       ("Lernenweb" nil)
                       ("Agenda" org-agenda-list)
                       ("EMMS" emms-smart-browse)
                       ("Telega" telega)
                       ("Email" notmuch)
                       ("Elisp" nil)
                       ("Otros" nil))))
    ;; Crea tabs extra (ya hay uno al iniciar Emacs)
    (dotimes (_ (- (length tabs-config) 1))
      (tab-bar-new-tab))
    ;; Renombra y configura cada tab
    (let ((index 1))
      (dolist (tab tabs-config)
        (tab-bar-select-tab index)            ; Cambia al tab por índice
        (tab-bar-rename-tab (car tab))        ; Renombra el tab
        (when (cadr tab)                      ; Ejecuta la acción si está definida
          (funcall (cadr tab)))
        (setq index (1+ index)))))
  ;; Volver al primer tab al final
  (tab-bar-select-tab 1)
  ;; en el numero 1
  (project-switch-project "~/geschichte/projekte/georeligion")
  (tab-bar-select-tab 2)
  (project-switch-project "~/geschichte/projekte/catalunaglobal")
  (tab-bar-select-tab 3)
  (project-switch-project "~/geschichte/web/webprojects/privatesites/lernenweb")
  (tab-bar-select-tab 1)
  )

;; Llama a la función automáticamente al inicio de Emacs
;;(add-hook 'emacs-startup-hook #'ism/lanzando-todo)

; esto define una función para saber si existe un buffer
(defun buffer-exists (bufname) (not (eq nil (get-buffer bufname))))

;;----------------------------------------------------
;; saltar entre buffers
;;----------------------------------------------------

; con esto guardamos en una variable el buffer donde estamos
(setq ism/nombre-del-buffer nil)

(defun ism/switch-buffer-determinado (ventana)
  "Función general para ir a un buffer y volver"
  ; la función buffer-exists la defino arriba
  (if (equal (buffer-name) ventana)
      (switch-to-buffer ism/nombre-del-buffer)
    (progn
      (setq ism/nombre-del-buffer (buffer-name))
      (switch-to-buffer ventana))))

(defun ism/ir-a-agenda ()
  "Ir al buffer de agenda"
  (interactive)
  ; la función buffer-exists la defino arriba
  (ism/switch-buffer-determinado "*Org Agenda*"))

(defun ism/ir-a-r ()
  "Ir al buffer de R"
  (interactive)
  ; la función buffer-exists la defino arriba
  (ism/switch-buffer-determinado "*R*"))

(defun ism/gnus-switch-to-group-buffer ()
  "Switch to gnus group buffer if it exists, otherwise start gnus."
  (interactive)
  (if (and (fboundp 'gnus-alive-p)
           (gnus-alive-p))
      (switch-to-buffer gnus-group-buffer)
    (gnus)))

(defun ism/ir-a-gnus ()
  "Ir al buffer de gnus"
  (interactive)
  ; la función buffer-exists la defino arriba
  (ism/switch-buffer-determinado "*Group*"))

;; (defun ism/ir-a-ibuffer ()
;;   "Ir al buffer de ibuffer"
;;   (interactive)
;;   ; la función buffer-exists la defino arriba
;;   (ism/switch-buffer-determinado "*Ibuffer*"))

;; versión mejorada? de lo anterior... sinceramente no me queda claro
;; por qué funciona lo de volver al anterior en el caso de crearlo. 
(defun ism/ir-a-ibuffer ()
  "Ir al buffer de ibuffer"
  (interactive)
  (if (get-buffer "*Ibuffer*")
      (ism/switch-buffer-determinado "*Ibuffer*")
    (ibuffer)))

(defun ism/ir-a-telegram-root ()
  "Ir al buffer de telegram-root"
  (interactive)
  ; la función buffer-exists la defino arriba
  (ism/switch-buffer-determinado "*Telega Root*"))

(defun ism/switch-diccionario ()
  "Cambiar de un diccionario a otro"
  (interactive)
  (if (equal ispell-current-dictionary "castellano8")
      (progn 
	(ispell-change-dictionary "deutsch8")
	(ism/cambiar-completar "alemán"))
    (progn
      (ispell-change-dictionary "castellano8")
      (ism/cambiar-completar "español"))))

(defun ism/org-agenda-heute ()
"Ir a la agenda del día"
  (interactive)
  (org-agenda nil " "))

;; (defun ism/org-agenda-thesis ()
;; "Ir a la agenda del día"
;;   (interactive)
;;   (org-agenda nil "ta"))

;; (defun ism/citas-valladolid ()
;;   "Ver la citas de valladolid")

;; (defun ism/org-capture-e ()
;;   "Crear un email personal"
;;    (interactive)
;;    (org-capture nil "ep"))

;; (defun ism/org-capture-arbeit ()
;;   "Crear un email de trabajo"
;;    (interactive)
;;    (org-capture nil "eb"))

;; (defun ism/org-capture-todo ()
;;   "Crear un tarea general"
;;    (interactive)
;;    (org-capture nil "tp"))

;; (defun ism/org-capture-palabra ()
;;   "Introducir una nueva palabra"
;;    (interactive)
;;    (org-capture nil "p"))

;; (defun ism/email-general ()
;;   "Configuraciones al enviar un email."
;;   (interactive)
;;   (message-goto-from)
;;   (let (p1 p2 myLine)
;;     (setq p1 (line-beginning-position) )
;;     (setq p2 (line-end-position) )
;;     (setq myLine (buffer-substring-no-properties p1 p2))
;;     (setq nombre (substring myLine -20 -1))
;; ; y ahora el if...
;;     (cond ((equal nombre "igor.sosa@gmail.com")
;; 	(progn
;; 	  (message-goto-fcc)
;; 	  (insert "~/sent-items")
;; 	  ))
;; 	  ((equal nombre "Igor.Sosa@eui.emea.microsoftonline.com")
;; 	   (progn
;; 	     (message-goto-fcc)
;; 	     (insert "~/sent-items-eui")
;; 	     (message-goto-signature)
;; 	     (insert "\n--\n")
;; 	     (insert-file "~/.mutt/signature")
;; 	     (message-goto-reply-to)
;; 	     (insert "Igor.Sosa@eui.eu")
;; 	     ))
;; 	  ((equal nombre "joseleopoldo1792@gmail.com")
;; 	   (progn
;; 	     (message-goto-fcc)
;; 	     (insert "~/sent-items")
;; 	     ))
;;       )))

; disable vc for Org mode agenda files (David Maus)
;Even if you use Git to track your agenda files you might not need vc-mode to be enabled for these files
;; (add-hook 'find-file-hook 'dmj/disable-vc-for-agenda-files-hook)
;; (defun dmj/disable-vc-for-agenda-files-hook ()
;;   "Disable vc-mode for Org agenda files."
;;   (if (and (fboundp 'org-agenda-file-p)
;;            (org-agenda-file-p (buffer-file-name)))
;;       (remove-hook 'find-file-hook 'vc-find-file-hook)
;;     (add-hook 'find-file-hook 'vc-find-file-hook)))

; con esto guardamos en una variable el buffer fundamental
(setq ism/buffer-trabajante nil)

(defun ism/ir-a-buffer-trabajante ()
  "Ir al buffer principal de trabajo"
  (interactive)
  (if (boundp 'ism/nombre-del-buffer)
      (switch-to-buffer ism/buffer-trabajante)))

(defun ism/definir-buffer-trabajante ()
  "Definir el  buffer principal de trabajo"
  (interactive)
  ; la función buffer-exists la defino arriba
  (setq ism/buffer-trabajante (buffer-name)))

(defalias 'idb 'ism/definir-buffer-trabajante)

(defconst tareas-reloj '(
			 ("governing" . "8b46c195-2407-4583-81e2-8eeac47cd13b")
			 ("obispos" . "b0709fe7-9080-43a7-be6c-005009abd3f3")
			 ("meter-datos" . "acbe5219-3aa9-4cb9-a505-ae7a656f6d92")
			 ("meter-rentas" . "754c05b9-d078-44a1-a6bf-d76b419b9b58")
			 ("financing" . "9505ed0c-9abf-4a16-99b7-826b814bb178")
                         ("preaching" . "84bc9a06-8247-43c8-bdff-d2ca6b11fce4")
                         ("obras" . "32bbddd5-a1c3-45b0-a698-464af3317841")
			 ("tariqas" . "16cbc6b4-4e39-4c8a-9b55-38b0c213bbc6")
			 ("georeligion" . "17cb31ec-790c-4c2f-8375-7944f38f9434")
))

(defun ism/fichar-en-tarea ()
  "Permite escoger cuál es la tarea básica."
  (interactive)
  (setq bh/keep-clock-running t)
  (setq tareas-lista (mapcar 'car tareas-reloj))
  (setq tarea (ido-completing-read "¿Qué tarea? " tareas-lista))
  (setq codigo (cdr (assoc tarea tareas-reloj)))
  ; y luego el código para saltar a donde queremos
  (save-restriction
    (widen)
    (org-with-point-at (org-id-find codigo 'marker)
      (progn (org-clock-mark-default-task)
	     (org-clock-in nil)))))

(defun ism/archivar ()
  (interactive)
  ;; en lugar de 'file se puede poner 'agenda para que coja todos
  ;; los archivos de la agenda
  (org-map-entries 'org-archive-subtree "/HECHO" 'file))

(defun ism/saltar-a-punto (tarea)
  "Permite escoger cuál es la tarea básica."
  (interactive "s¿Dónde seguir? ")
  (cond ((equal tarea "l") ; limosna
	 ;; no entiendo por qué el widen va antes del org-id-goto
	 ;; pues en teoría debería ir antes al punto y luego ampliar, más que nada porque así
	 ;; estaría en el buffer apropiado, pero solamente funciona así con el widen antes...
	 (progn (widen)
		(org-id-goto  "8f263091-b79b-4c3d-8288-c4610f784322") 
		(org-narrow-to-subtree)))
	((equal tarea "ch") ; chapt hacienda
	 (progn (widen)
		(org-id-goto  "b8c5b1c5-a6ae-40c2-a662-a8e73835e362") 
		(org-narrow-to-subtree)))
 ))

;; (defun ism/conectar-jabber ()
;;   "Función para conectar jabber. La pongo porque el jabber-connect me conecta como offline no sé por qué."
;;   (interactive)
;;   (jabber-connect :username "igor.sosa@gmail.com" :network-server "talk.google.com" :connection-type 'ssl)
;; ;  (jabber-send-presence "dnd" jabber-default-status)
;; )

;; (defalias 'cj 'jabber-connect)
;; (defalias 'dj 'jabber-disconnect)

;; (defalias 'gu 'gnus-unplugged)

;; (defun ism/correo-privado ()
;;   "Abrir vm en la carpeta de correo privado."
;;   (interactive)
;;   (vm-visit-imap-folder propio:nuevo))

(defun ism/arrancar-erc ()
  "Arrancar ERC"
  (interactive)
  (erc :server "irc.libera.chat" :port 6667 :nick "rogorido" :full-name "Igor Sosa Mayor" )
)

(defun ism/arrancar-znc ()
  "Start ERC connection to my ZNC server."
  (interactive)
  ;; I think it is important to use nick and user!
  (erc-tls :server "znc.sosawergles.net" :port 1111
           :nick "rogorido" :user "rogorido"
           :full-name "Igor Sosa Mayor" )
)


(defun ism/enviar-link (titulo url)
  (interactive "sTitulo: \nsURL: ")
  (setq destinatario-lista (mapcar 'car contactos))
  (setq destinatario (ido-completing-read "Email a: " destinatario-lista))
; call-interactively es necesario porque algunas de estas funciones 
; tienen un argumento
  (setq email (cdr (assoc destinatario contactos)))
  (ism/mu4e-personal)
  (mu4e-compose-new)
  (message-goto-to)
  (insert-string email)
  (message-goto-subject) (insert-string titulo)
  (message-goto-body) (insert-string url)
)

(defun ism/enviar-link-desde-gnus ()
  (interactive)
  (let (url)
    (with-current-buffer gnus-original-article-buffer
      (setq url (gnus-fetch-field "Archived-at")))
    (if (not (stringp url))
        (gnus-message 1 "No \"Archived-at\" header found.")
      (setq url (gnus-replace-in-string url "^<\\|>$" "")))
    (gnus-summary-mail-forward)
    (gnus-alias-use-identity "general")
    (message-goto-body)
    (let ((inicio (point)))
      (end-of-buffer)
      (kill-region inicio (point)))
    (insert url)
  (message-goto-to))
)

; esto no sé de dónde sale...
(defun my-bell-function ()
  (unless (memq this-command
        '(isearch-abort abort-recursive-edit exit-minibuffer
               mwheel-scroll down up next-line previous-line
              backward-char forward-char))
    (ding)))
(setq ring-bell-function 'my-bell-function)

; con esto se para el reloj si está en marcha
; importante es que hay que añadirlo al hook
(defun org-clock-out-maybe ()
   "Stop a currently running clock."
   (org-clock-out nil t)
   (org-save-all-org-buffers))

(add-hook 'kill-emacs-hook 'org-clock-out-maybe)

(defun ism/saltar-inicio-footnote ()
  (interactive)
  (goto-char (TeX-find-macro-start))
  (search-forward "{" (TeX-find-macro-end) t))

(defun ism/saltar-fin-footnote ()
  (interactive)
  (goto-char (TeX-find-macro-end))
  (backward-char)
  )

; adaptada de una función que está en
; http://www.emacswiki.org/emacs/KillingBuffers
(defun ism/eliminar-buffers-molestos ()
  "Elimina buffers molestos. Por ahora, dired, ess-help y help."
  (interactive)
  (mapc (lambda (buffer) 
          (when (or (eq 'ess-help-mode (buffer-local-value 'major-mode buffer))
		    (eq 'dired-mode (buffer-local-value 'major-mode buffer))
		    (eq 'magit-status-mode (buffer-local-value 'major-mode buffer))
                    (eq 'helpful-mode (buffer-local-value 'major-mode buffer))
		    (eq 'help-mode (buffer-local-value 'major-mode buffer))
                    ;; esto de las imágenes las abre telega
	            (eq 'image-mode (buffer-local-value 'major-mode buffer)))
            (kill-buffer buffer))) 
        (buffer-list)))

; función para abrir un blog en firefox desde gnus
; cogido de aquí
; https://lists.gnu.org/archive/html/info-gnus-english/2012-10/msg00016.html
(defun ism/gnus-browse-archived-at ()
  "Browse \"Archived-at\" URL of the current article."
  (interactive)
  (let (url)
    (with-current-buffer gnus-original-article-buffer
      (setq url (gnus-fetch-field "Archived-at")))
    (if (not (stringp url))
        (gnus-message 1 "No \"Archived-at\" header found.")
      (setq url (gnus-replace-in-string url "^<\\|>$" ""))
      (browse-url url))))

(defun ism/gnus-browse-titulo-at ()
  "Browse \"Archived-at\" URL of the current article."
  (interactive)
  (with-current-buffer gnus-original-article-buffer
    (setq url (gnus-fetch-field "Subject"))
    (setq direccion (gnus-fetch-field "Archived-at"))
    )
    (message (concat "estamos en: " url " y la direccion es " direccion)))

(defun ism/plegar-topics ()
  (interactive)
  (mapcar  (lambda (topic)
      (gnus-topic-jump-to-topic topic)
      (if (gnus-topic-visible-p)
	  (gnus-topic-fold)))
	   '("R-stats" "blogs" "latex" "mail" "misc" "chess"))
  (gnus-topic-jump-to-topic "emacs"))

(defun ism/erc-mostrar-buffers ()
  (interactive)
  (delete-other-windows)
  (split-window-horizontally)
  (switch-to-buffer "#emacs")
  (other-window 1)
  (split-window-vertically)
  (switch-to-buffer "#emacs-es")
  (other-window 1)
  (switch-to-buffer "##esperanto")
  (balance-windows)
  ; vuelve a la window de #emacs
  (other-window 1)
)

(defalias 'ver-erc 'ism/erc-mostrar-buffers)

;;; Trucos para usar emacs como o y O en vim
;; Behave like vi's o command
(defun open-next-line (arg)
  "Move to the next line and then opens a line.
    See also `newline-and-indent'."
  (interactive "p")
  (end-of-line)
  (forward-line arg)
  (next-line 1)
  (when newline-and-indent
    (indent-according-to-mode)))
(global-set-key (kbd "C-o") 'open-next-line)

;; Behave like vi's O command
(defun open-previous-line (arg)
  "Open a new line before the current one. 
     See also `newline-and-indent'."
  (interactive "p")
  (beginning-of-line)
  (open-line arg)
  (when newline-and-indent
    (indent-according-to-mode)))
(global-set-key (kbd "M-o") 'open-previous-line)
;; Autoindent open-*-lines
(defvar newline-and-indent t
  "Modify the behavior of the open-*-line functions to cause them to autoindent.")

(defun ism/gnus-limpiar-mensaje ()
  "Limpiar las citas de un mensaje."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (delete-matching-lines "^[>]\\{2,\\}")
  )
)

;; ; para borrar las footnotes que pone scid
;; (defun ism/borrar-notas-ajedrez ()
;;   (interactive)
;;   (query-replace-regexp "\\$^{[0-9]+}\\$" "")
;;   )

;; ; para lo de puntos, comas que no van seguidos de espacios sería esto:
;; ; "[.,?!][a-zA-Z]"
;; ;; (defun ism/corregir-sin-espacio ()
;; ;;   (interactive)
;; ;;   (query-replace-regexp "\\([.,?!]\\)\\([a-zA-Z]\\)" "\\1 \\2")
;; ;;   )

;; ; lo mismo que lo anterior pero con occur, que es mejor!
;; ; lo otro es muy agresivo!
;; (defun ism/occur-sin-espacio ()
;;   (interactive)
;;   (occur "[.,?!][a-zA-Z]")
;;   )

;; (defun ism/exportar-gnus-to-mutt ()
;;   (interactive)
;;   (if (fboundp 'gnus-group-exit)
;;       (gnus-group-exit))
;;   (shell-command "~/bin/gnus2mutt.sh")
;;   )

(defun ism/latex-reducir-vision-texto ()
  "Esta función sirve de una especie de narrow para latex."
  (interactive)
  (save-excursion
    (LaTeX-mark-section t) ; la t sirve para que NO marque subsections!
    (narrow-to-region (region-beginning) (region-end))
    (deactivate-mark))
  )

(global-set-key (kbd "C-x n l") 'ism/latex-reducir-vision-texto)

; cambiar el diccionario de completar
(defun ism/cambiar-completar (&optional lengua)
  "Cambiar el fichero de completar"
  (interactive)
  (or lengua
      (progn
      (setq idiomas '("alemán" "español"))
      (setq lengua (ido-completing-read "Cambiar a: " idiomas))))
  (if (equal lengua "español")
      (setq ac-dictionary-files '("~/.dict"))
    (setq ac-dictionary-files '("~/.aleman")))
  (ac-config-default)
  (ac-clear-dictionary-cache)
)

(defun ism/borrar-frase ()
  "Borrar una frase entera aunque estemos en media de ella.
Es decir, mejora kill-sentence (M-k)"
  (interactive)
  (backward-sentence)
  (kill-sentence)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; change case of letters                                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; http://ergoemacs.org/emacs/modernization_upcase-word.html
(defun toggle-letter-case ()
  "Toggle the letter case of current word or text selection.
Toggles between: all lower, Init Caps, ALL CAPS."
  (interactive)
  (let (p1 p2 (deactivate-mark nil) (case-fold-search nil))
    (if (region-active-p)
        (setq p1 (region-beginning) p2 (region-end))
      (let ((bds (bounds-of-thing-at-point 'word) ) )
        (setq p1 (car bds) p2 (cdr bds)) ) )

    (when (not (eq last-command this-command))
      (save-excursion
        (goto-char p1)
        (cond
         ((looking-at "[[:lower:]][[:lower:]]") (put this-command 'state "all lower"))
         ((looking-at "[[:upper:]][[:upper:]]") (put this-command 'state "all caps") )
         ((looking-at "[[:upper:]][[:lower:]]") (put this-command 'state "init caps") )
         ((looking-at "[[:lower:]]") (put this-command 'state "all lower"))
         ((looking-at "[[:upper:]]") (put this-command 'state "all caps") )
         (t (put this-command 'state "all lower") ) ) )
      )

    (cond
     ((string= "all lower" (get this-command 'state))
      (upcase-initials-region p1 p2) (put this-command 'state "init caps"))
     ((string= "init caps" (get this-command 'state))
      (upcase-region p1 p2) (put this-command 'state "all caps"))
     ((string= "all caps" (get this-command 'state))
      (downcase-region p1 p2) (put this-command 'state "all lower")) )
    )
  )

;;set this to M-c
(global-set-key "\M-c" 'toggle-letter-case)

(defun ism/buscar-en-dominicos-rg (termino)
  "Buscar en el directorio de dominicos con ripgrep."
  (interactive "s¿Qué buscar? ")
  (rg termino "org" "~/geschichte/projekte/dominicos/"))

; realmente esto se podría tal vez hacer un poco más fácil
; cambiando con una función la variable default-directory
(defun ism/abrir-ficheros-zusammenfassungen ()
  "Abrir fichero en el directorio de zusammenfassungen."
  (interactive)
  (setq dir  "~/geschichte/zusfassungen/"
	zf (directory-files dir nil "\\(org\\|tex\\)$"))
    ;; (setq candidate (ido-completing-read "Abrir el fichero: " zf))
  (setq candidate (ivy-read "Abrir el fichero: " zf))
  (find-file (concat dir candidate))
  )

(defun ism/abrir-ficheros-dominicos ()
  "Abrir fichero en el directorio de ficheros de dominicos."
  (interactive)
  (setq dir "~/geschichte/projekte/dominicos/"
	zf (directory-files dir nil "\\(org\\|tex\\)$"))
  ;; (setq candidate (ido-completing-read "Abrir el fichero: " zf))
  (setq candidate (ivy-read "Abrir el fichero: " zf))
  (find-file (concat dir candidate))
  )
; ---------------------------------------------------------
; para lernen
; ---------------------------------------------------------
(defun ism/abrir-ficheros-lernen ()
  "Abrir fichero en el directorio de ficheros de lernen."
  (interactive)
  (setq 
   zf (directory-files-recursively "~/Documents/lernen/" "org$"))
  (find-file (completing-read "Abrir el fichero: " zf))
  )

; ---------------------------------------------------------
; para ficheros org 
; ---------------------------------------------------------
(defun ism/abrir-ficheros-org ()
  "Abrir fichero en el directorio de ficheros de Documents/org."
  (interactive)
  (setq 
	zf (directory-files-recursively "~/Documents/org/" "org$"))
  (find-file (completing-read "Abrir el fichero: " zf))
  )

(defun ism/abrir-ficheros-config-emacs ()
  "Abrir con ido el directorio de ficheros de configuración de emacs."
  (interactive)
  (setq dir "~/.emacs.d/emacs-personal/"
	zf (directory-files dir t "el$"))
  (find-file (completing-read "Abrir el fichero: " zf))
  )

(defun ism/abrir-cajones ()
  "Abrir fichero en el directorio org pero para lo de los cajones..."
  (interactive)
  (setq dir "~/Documents/org/"
	zf (directory-files dir t "^cajon"))
  (find-file (completing-read "Abrir el fichero: " zf))
  )

;;(defalias 'quitar/poner-barramenu 'toggle-menu-bar-mode-from-frame)

(defun nickname-freenode-after-connect (server nick)
  (when (and (string-match "freenode\\.net" server)
	     (boundp 'ism-freenode-nick-passwd))
    (erc-message "PRIVMSG" (concat "NickServ identify " ism-freenode-nick-passwd)))
  (when (and (string-match "oftc\\.net" server)
	     (boundp 'ism-oftc-nick-passwd))
    (erc-message "PRIVMSG" (concat "NickServ identify " ism-oftc-nick-passwd))))

(add-hook 'erc-after-connect 'nickname-freenode-after-connect)

(defun ism/--abrir-postgresql-dominicos ()
  "Abrimos el scratch.sql y al mismo tiempo la bd de los
dominicos"
  (interactive)
  (sql-postgres)
  (find-file "~/latexpruebas/scratch.sql")
  (goto-char (point-max))
  (sql-set-sqli-buffer)
  (get-buffer "*SQL*")
  )

;; esto creo que ya está con comment-dwim 
;; comment-or-uncomment-region-or-line
;; https://stackoverflow.com/questions/9688748/emacs-comment-uncomment-current-line
(defun st/comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)
        (next-line)))

(defun ism/buscar-rae (palabra)
  "Busca una palabra en la RAE."
  (interactive "s¿Qué palabra quieres buscar? ")
  (eww (concat "https://dle.rae.es/" palabra))
  )

(defun ism/buscar-sinonimo (palabra)
    "Busca una palabra en un diccionario de sinónimos"
    (interactive "s¿Qué palabra quieres buscar? ")
    (eww (concat "https://www.wordreference.com/sinonimos/" palabra))
    )

(defun ism/traducir (palabra)
    "Traduccion de inglés a español"
    (interactive "s¿Qué palabra quieres buscar? ")
    (eww (concat "https://www.wordreference.com/es/en/translation.asp?spen=" palabra))
    )

;;
;; Funciones de EMMS
;; 
(defun ism/emms-escoger-playlist ()
  "Presenta todos los archivos de un DIRECTORIO y sus subdirectorios
en un completing-read para seleccionar uno y reproducirlo con
emms-play-file."
  (interactive)
  (let* ((all-files (directory-files-recursively "/home/igor/.playlists" ".*"))  ;; Obtén todos los archivos
         (selected-file
          (completing-read "Elige un archivo para reproducir: " all-files nil t)))
    (emms-play-playlist selected-file)))  ;; Reproduce el archivo seleccionado


;; Toggle two window layout vertically or horizontally
;; https://github.com/redguardtoo/emacs.d/blob/master/lisp/init-windows.el
(defun ism/toggle-two-split-window ()
  "Toggle two window layout vertically or horizontally."
  (interactive)
  (when (= (count-windows) 2)
    (let* ((this-win-buffer (window-buffer))
           (next-win-buffer (window-buffer (next-window)))
           (this-win-edges (window-edges (selected-window)))
           (next-win-edges (window-edges (next-window)))
           (this-win-2nd (not (and (<= (car this-win-edges)
                                       (car next-win-edges))
                                   (<= (cadr this-win-edges)
                                       (cadr next-win-edges)))))
           (splitter
            (if (= (car this-win-edges)
                   (car (window-edges (next-window))))
                'split-window-horizontally
              'split-window-vertically)))
      (delete-other-windows)
      (let* ((first-win (selected-window)))
        (funcall splitter)
        (if this-win-2nd (other-window 1))
        (set-window-buffer (selected-window) this-win-buffer)
        (set-window-buffer (next-window) next-win-buffer)
        (select-window first-win)
        (if this-win-2nd (other-window 1))))))

;;
;; Functions to manage chats with gptel.
;; 

;; macro to create the functions!
(defmacro ism/--switch-to-chat (buffer-name)
  "Genera una función que cambia al buffer de chat especificado."
  `(defun ,(intern (format "ism/switch-to-chat-%s" buffer-name)) ()
     "Switch to the %s chat buffer."
     (interactive)
     (let* ((real-buffer-name ,(concat "chat" buffer-name ".org"))
            (buffer (get-buffer real-buffer-name)))
       (if buffer
           (switch-to-buffer buffer)
         (progn
           (find-file (concat "~/latexpruebas/" real-buffer-name))
           (gptel-mode))))))

;; We create the functions using the macro 

(ism/--switch-to-chat "linux")
(ism/--switch-to-chat "science")
(ism/--switch-to-chat "prog")
(ism/--switch-to-chat "general")


(provide 'ism-functions)
;;; ism-functions.el ends here
