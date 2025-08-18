(defun ism/emms-play-matching (pattern)
  "Play matching song."
  (interactive "sPlay song matching: ")
  (when emms-playlist-buffer
    (save-excursion
      (set-buffer emms-playlist-buffer)
      (emms-playlist-clear)))
  (emms-play-find emms-source-file-default-directory pattern))

(defalias 'editar-tag 'emms-tag-editor-edit-track)

;esto es de emms-get-lyrics
(defalias 'descargar-letra 'emms-get-lyrics-current-song)

(defun ism/emms-cargar-lista (lista)
  "Cargar una lista de música en EMMS."
  (interactive "s¿Qué lista cargar? ")
  (when emms-playlist-buffer
    (save-excursion
      (set-buffer emms-playlist-buffer)
      (emms-playlist-clear)))
  (cond 
   ((equal lista "zau")
    (setq tocar  "~/musica/playlists/zauberfloete.m3u"))
   ((equal lista "tip")
    (setq tocar  "~/musica/playlists/tipica.m3u"))
   ((equal lista "trav")
    (setq tocar  "~/musica/playlists/traviata.m3u"))
   ((equal lista "fig")
    (setq tocar  "~/musica/playlists/figaro.m3u"))
   )
  (emms-play-m3u-playlist tocar))

(defun ism/emms-cargar-lista-zau ()
  "Cargar la zauberflöte en EMMS."
  (interactive)
  (ism/emms-cargar-lista "zau"))

(defun ism/emms-cargar-lista-tipica ()
  "Cargar la típica en EMMS."
  (interactive)
  (ism/emms-cargar-lista "tip")
(emms-shuffle)
)

(defun ism/emms-cargar-lista-traviata ()
  "Cargar la Traviata en EMMS."
  (interactive)
  (ism/emms-cargar-lista "trav"))

(defun ism/emms-cargar-lista-figaro ()
  "Cargar Figaro en EMMS."
  (interactive)
  (ism/emms-cargar-lista "fig"))

(defalias 'zau 'ism/emms-cargar-lista-zau)
(defalias 'tip 'ism/emms-cargar-lista-tipica)
(defalias 'trav 'ism/emms-cargar-lista-traviata)
(defalias 'fig 'ism/emms-cargar-lista-figaro)

(defun de-toggle-playing ()
  (interactive)
  (if emms-player-playing-p
      (emms-pause)
    (emms-start)))


(defun rgr/ido-erc-buffer()
  (interactive)
  (switch-to-buffer
   (ido-completing-read "Channel:" 
                        (save-excursion
                          (delq
                           nil
                           (mapcar (lambda (buf)
                                     (when (buffer-live-p buf)
                                       (with-current-buffer buf
                                         (and (eq major-mode 'erc-mode)
                                              (buffer-name buf)))))
                                   (buffer-list)))))))


; lo tengo como C-c f
(defun recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))


; http://whattheemacsd.com/
;; (defun rotate-windows ()
;;   "Rotate your windows"
;;   (interactive)
;;   (cond ((not (> (count-windows)1))
;;          (message "You can't rotate a single window!"))
;;         (t
;;          (setq i 1)
;;          (setq numWindows (count-windows))
;;          (while  (< i numWindows)
;;            (let* (
;;                   (w1 (elt (window-list) i))
;;                   (w2 (elt (window-list) (+ (% i numWindows) 1)))

;;                   (b1 (window-buffer w1))
;;                   (b2 (window-buffer w2))

;;                   (s1 (window-start w1))
;;                   (s2 (window-start w2))
;;                   )
;;              (set-window-buffer w1  b2)
;;              (set-window-buffer w2 b1)
;;              (set-window-start w1 s2)
;;              (set-window-start w2 s1)
;;              (setq i (1+ i)))))))


;; (defun insert-date (prefix)
;;     "Insert the current date. With prefix-argument, use ISO format. With
;;    two prefix arguments, write out the day and month name."
;;     (interactive "P")
;;     (let ((format (cond
;;                    ((not prefix) "%d/%m/%Y")
;;                    ((equal prefix '(4)) "%Y-%m-%d")
;;                    ((equal prefix '(16)) "%A, %d. %B %Y")))
;;           (system-time-locale "de_DE"))
;;       (insert (format-time-string format))))

;; esto creo que ya está incluido ahora en emacs como count-words
;; (defun word-count ()
;;   "Count words in buffer"
;;   (interactive)
;;   (shell-command-on-region (point-min) (point-max) "wc -w"))

(defun ism/mu4e-cambiar-direccion-erfurt ()
  "Cambia la dirección y otras variables en una respuesta a
la dirección de Erfurt."
  (interactive)
  (save-excursion
    (message-narrow-to-headers)
    (replace-string "igor.sosa@gmail.com" "igor.sosa_mayor@uni-erfurt.de")
    (widen)
    (make-local-variable 'mu4e-sent-folder)
    (make-local-variable 'message-signature-file)
    (make-local-variable 'message-signature)
    (setq mu4e-sent-folder "/erfurt/Sent")
    (setq message-signature t)
    (setq message-signature-file "~/.mutt/signature-erfurt")
    (message-insert-signature)))

(defun ism/abrir-directorio-tesis ()
  "Abrir el directorio de la tesis en dired"
  (interactive)
  (dired "~/geschichte/konfessiodiss/text/versionfinal")
  )

;; ;;----------------------------------------------------
;; ;; Esto es una verdadera maravilla: sirve para cambiar
;; ;; entre los buffers con SHIFT-TECLA CURSOR DERECHA o IZQUIERDA
;; ;;----------------------------------------------------

;; ;; Buffer wechseln wie click auf modeline, aber mit
;;      ;; tasten...
;;      (defun ska-previous-buffer ()
;;        "Hmm, to be frank, this is just the same as bury-buffer.
;;      Used to wander through the buffer stack with the keyboard."
;;        (interactive)
;;        (bury-buffer))

;;      (defun ska-next-buffer ()
;;        "Cycle to the next buffer with keyboard."
;;        (interactive)
;;        (let* ((bufs (buffer-list))
;;            (entry (1- (length bufs)))
;;            val)
;;          (while (not (setq val (nth entry bufs)
;;                   val (and (/= (aref (buffer-name val) 0)
;;                        ? )
;;                        val)))
;;            (setq entry (1- entry)))
;;            (switch-to-buffer val)))

;; ;; Buffer cycling like on modeline
;;        (define-key global-map [(alt right)] 'ska-next-buffer)
;;        (define-key global-map [(alt left)]  'ska-previous-buffer)

;;----------------------------------------------------
;; Esto es una verdadera maravilla: sirve para cambiar
;; entre los windows con SHIFT-TECLA CURSOR ARRIBA o ABAJO
;;----------------------------------------------------


;; Fenster rückwärts springen   
;;           (defun other-window-backward (n)
;;             "Select Nth previous window."
;;             (interactive "p")
;;             (other-window (- n)))

;; (global-set-key [(shift down)] 'other-window)
;; (global-set-key [(shift up)] 'other-window-backward)
