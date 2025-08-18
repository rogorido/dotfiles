(message "Loading EMMS settings...")

(require 'emms-setup)
(emms-all)

;; Para actualizar el caché parece que lo mejor es hacer
;; C-u M-x emms-cache-sync
;; pues me conserva bien los datos...

;; he experimentado con emms-info-exiftool y va mucho más lento y no
;; parece que los resultados sean muy diferentes... 
(setq emms-player-list '(emms-player-mpv)
      emms-info-functions '(emms-info-native))

;; mpd
;; (require 'emms-player-mpd)
;; (setq emms-player-mpd-server-name "localhost")
;; (setq emms-player-mpd-server-port "6600")
;; (add-to-list 'emms-info-functions 'emms-info-mpd)
;; (setq  emms-player-list '(emms-player-mpd))

;; (setq emms-player-mpd-music-directory "~/musica")
;; (setq emms-player-mpd-sync-playlist nil)

;; When asked for emms-play-directory,
;; always start from this one
(setq emms-source-file-default-directory "~/musica/")

;; Show the current track each time EMMS
;; starts to play a track with "NP : "
(add-hook 'emms-player-started-hook 'emms-show)
(setq emms-show-format "NP: %s")

; esta variable tiene dos opciones y esta es la más rápida
; es algo de buscar los directorios.
(setq emms-source-file-directory-tree-function 'emms-source-file-directory-tree-find)

;; (emms-browser-make-filter "clasica"
;;                           (emms-browser-filter-only-dir "~/musica/clasica"))


;; ;; no entiendo por qué funciona esto... por qué se unen con or y no con and?
;; (emms-browser-make-filter "clasica-not-played"
;;                           (lambda (track)
;;                             (or
;;                              (funcall (emms-browser-filter-only-dir "~/musica/clasica") track)
;;                                  (not (funcall (emms-browser-filter-only-recent 30) track)))))

;; ;;; esto es un misterio: no sé por qué hay que negar con not
;; ;;; pero sin el not escoge todos los que no son clasica/opera
;; (emms-browser-make-filter "clasica-total"
;;   (lambda (track)
;;     (let ((directory (file-name-directory (emms-track-name track))))
;;       (not
;;        (or (string-prefix-p (expand-file-name "~/musica/clasica") directory)
;;            (string-prefix-p (expand-file-name "~/musica/renacimiento") directory)
;;            (string-prefix-p (expand-file-name "~/musica/opera") directory))))))

;; (emms-browser-make-filter "opera"
;;                           (emms-browser-filter-only-dir "~/musica/opera"))
;; (emms-browser-make-filter "medieval"
;;                           (emms-browser-filter-only-dir "~/musica/medieval"))
;; (emms-browser-make-filter "renacimiento"
;;                           (emms-browser-filter-only-dir "~/musica/renacimiento"))
;; (emms-browser-make-filter "extraeuropea"
;;                           (emms-browser-filter-only-dir "~/musica/extraeuropea"))

;; (emms-browser-make-filter "last-month-not-played"
;;    (lambda (track)
;;      (not (funcall (emms-browser-filter-only-recent 30) track))))

;; (emms-browser-make-filter "last-month-played"
;;    (lambda (track)
;;      (funcall (emms-browser-filter-only-recent 30) track)))

;; (emms-browser-make-filter "tradicional"
;;                           (emms-browser-filter-only-dir "~/musica/tradicional"))

;; (emms-browser-make-filter "pop"
;;                           (emms-browser-filter-only-dir "~/musica/pop"))

;; (emms-browser-make-filter "cantautores"
;;                           (emms-browser-filter-only-dir "~/musica/cantautores"))

;; ;;; esto es un misterio: no sé por qué hay que negar con not
;; ;;; pero sin el not escoge todos los que no son clasica/opera
;; (emms-browser-make-filter "chungui-total"
;;   (lambda (track)
;;     (let ((directory (file-name-directory (emms-track-name track))))
;;       (not
;;        (or (string-prefix-p (expand-file-name "~/musica/tradicional") directory)
;;            (string-prefix-p (expand-file-name "~/musica/pop") directory)
;;            (string-prefix-p (expand-file-name "~/musica/cantautores") directory))))))

;; (emms-browser-make-filter "all" 'ignore)

;; ;; Set "all" as the default filter
;; (emms-browser-set-filter (assoc "all" emms-browser-filters))

;; ;; Pequeña función para escoger los filtros; realmente según chatgpt
;; ;; hay un sistema mejor porque es posible extraer de obarray los nombres
;; ;; de los filtros, etc.
;; (setq ism/--own-emms-filters
;;       '("all" "clasica" "opera" "clasica-total" "chungui-total" "tradicional"
;;         "extraeuropea" "last-month-not-played" "medieval" "renacimiento"
;;         "last-month-played" "pop" "cantautores" "clasica-not-played"))

;; (defun ism/emms-browser-run-filter ()
;;   "Muestra una lista de filtros EMMS definidos (prefijo
;; 'emms-browser-show-') y ejecuta el filtro seleccionado."
;;   (interactive)
;;   (let
;;       ((selected-filter (completing-read "Selecciona un filtro EMMS: " ism/--own-emms-filters nil t)))
;;     (funcall (intern (concat "emms-browser-show-" selected-filter)))))

; esto es para emms
(setq emms-lyrics-dir "~/.lyrics/")

;; covers
(setq emms-browser-covers #'emms-browser-cache-thumbnail-async)
(setq emms-browser-default-covers
      '("~/musica/nocover_small.jpg" "~/musica/nocover_medium.jpg" "~/musica/nocover.jpg"))

;; realmente no quiero que me cargue todas las listas medio-temporales
;; que puedo crear...
;; (require 'emms-history)
;; (emms-history-load)
(emms-cache-enable)

(require 'emms-listenbrainz-scrobbler)
(emms-listenbrainz-scrobbler-enable)
;; que no esté dando la pesadez de que envía el asunto... 
(setq emms-listenbrainz-scrobbler-display-submissions nil)

;; teclas generales
(dolist (key-func '(("C-c e e" . emms-smart-browse)
                    ("C-c e p" . emms-pause)
                    ("C-c e s" . emms-stop)
                    ("C-c e n" . emms-next)
                    ("C-c e z" . emms-toggle-repeat-track)
                    ("C-c e u" . emms-score-up-playing)
                    ("C-c e d" . emms-score-down-playing)
                    ("C-c e f" . ism/emms-browser-run-filter)
                    ("C-c e C-r" . emms-toggle-repeat-playlist)
                    ("C-c e C-b" . emms-browser)
                    ("C-c e C-p" . emms-playlist-mode-go)))
  (global-set-key (kbd (car key-func)) (cdr key-func)))

;; Teclas en emms-browser
(dolist (key-func '(("e" . emms-smart-browse)
                    ("P" . emms-pause)
                    ("SPC" . emms-pause)
                    ("S" . emms-stop)
                    ("z" . emms-toggle-repeat-track)
                    ("f" . ism/emms-browser-run-filter)
                    ("j" . next-line)
                    ("k" . previous-line)
                    ("1" . emms-browse-by-artist)
                    ("2" . emms-browse-by-album)
                    ("3" . emms-browse-by-genre)
                    ("4" . emms-browse-by-year)
                    ("5" . emms-browse-by-composer)
                    ("6" . emms-browse-by-performer)
                    ("b 1" . emms-browser-collapse-all)
                    ("L c" . emms-browser-lookup-composer-on-wikipedia) ;; era W C w 
                    ("L a" . emms-browser-lookup-artist-on-wikipedia) ;; era W C A
                    ("L A" . emms-browser-lookup-album-on-wikipedia) ;; era W C a
                    ;;("b 2" . emms-browser-expand-to-level-2) ;; deshabilitamos: muy lento
                    ;;("b 3" . emms-browser-expand-to-level-3) ;; deshabilitamos: muy lento
                    ;;("b 4" . emms-browser-expand-to-level-4) ;; deshabilitamos: muy lento
                    ("+" . emms-browser-next-filter)
                    ("-" . emms-browser-previous-filter)
                    ))
  (define-key emms-browser-mode-map (kbd (car key-func)) (cdr key-func)))

;; Teclas en emms-playlist
(define-key emms-playlist-mode-map "e" 'emms-smart-browse)
(define-key emms-playlist-mode-map (kbd "SPC") #'emms-pause)
(define-key emms-playlist-mode-map "z" 'emms-toggle-repeat-track)
;; por qué no funciona esto?
;;(define-key emms-playlist-mode-map "j" 'emms-playlist-next)


;; (global-set-key (kbd "<kp-subtract>") 'emms-previous)
;; (global-set-key (kbd "<kp-add>") 'emms-next)
;; (global-set-key (kbd "<kp-multiply>") 'emms-random)

;;; muy simple
;; (setq emms-browser-info-year-format      "%i+ %n")
;; (setq emms-browser-info-genre-format     "%i+ %n")
;; (setq emms-browser-info-performer-format "%i+ %n")
;; (setq emms-browser-info-composer-format  "%i+ %n")
;; (setq emms-browser-info-artist-format    "%i* %n")
;; (setq emms-browser-info-album-format     "%i- %n")
;; (setq emms-browser-info-title-format     "%i♪ %n")
;; (setq emms-browser-playlist-info-year-format      "%i+ %n")
;; (setq emms-browser-playlist-info-genre-format     "%i+ %n")
;; (setq emms-browser-playlist-info-performer-format "%i+ %n")
;; (setq emms-browser-playlist-info-composer-format  "%i+ %n")
;; (setq emms-browser-playlist-info-artist-format    "%i* %n")
;; (setq emms-browser-playlist-info-album-format     "%i- %n")
;; (setq emms-browser-playlist-info-title-format     "%i♪ %n")

;; (setq alist-compositores '(("Antonio Vivaldi" . "1800-1900")
;;                            ("Jan Dismas Zelenka" . "1679-1745")
;;                            ("Felix Mendelssohn" . "1809-1847")
;;                            ("Wolfgang Amadeus Mozart" . "1756-1791")))


;; (defun actualizar-compositores-concatenando (alist-compositores)
;;   "Actualizar `info-composer` en `HASH-TABLE` concatenando según `ALIST-COMPOSITORES`.
;;    Si un compositor de `info-composer` está en `ALIST-COMPOSITORES`,
;;    se concatena el valor (e.g., 'Verdi' -> 'Verdi 1800-1900')."
;;   (interactive)
;;   (maphash
;;    (lambda (key value)
;;      ;; Recorremos la lista asociada a la clave
;;      (dolist (item value)
;;        ;; Si `item` es un alist y contiene `info-composer`
;;        (when (and (consp item)
;;                   (eq (car item) 'info-composer))
;;          (let* ((composer (cdr item)) ;; Valor del info-composer actual
;;                 (nuevo-composer (assoc composer alist-compositores)))
;;            ;; Si hay un nuevo compositor en la lista, concatenamos
;;            (when nuevo-composer
;;              (setcdr item (concat composer " " (cdr nuevo-composer))))))))
;;    emms-cache-db)
;;   (emms-cache-dirty)
;;   )


;; ;; Actualizamos la hash table concatenando valores
;; ;; (actualizar-compositores-concatenando alist-compositores)


;; (defun ism/--obtener-compositores-unicos ()
;;   "Extrae una lista única de compositores desde `emms-cache-db`."
;;   (let (compositores)
;;     (maphash (lambda (_file track)
;;                (let ((compositor (alist-get 'info-composer track)))
;;                  (when compositor
;;                    (push compositor compositores))))
;;              emms-cache-db)
;;     ;; Eliminar duplicados y devolver la lista
;;     (delete-dups compositores)))


;; ;;; buscar-por-compositores
;; (defun ism/buscar-por-compositores ()
;;   "Selecciona compositores únicos y busca sus pistas en EMMS."
;;   (interactive)
;;   (let* ((compositores (ism/--obtener-compositores-unicos))
;;          (seleccionados (completing-read-multiple
;;                          "Selecciona compositores: "
;;                          compositores)))
;;     (when seleccionados
;;        (save-excursion
;;         ;; Cambiar temporalmente al buffer de la playlist;
;;         ;; deberíamos complrobar si existe...
;;         (set-buffer emms-playlist-buffer)
;;         (let (pistas-encontradas)
;;           ;; Buscar pistas para los compositores seleccionados
;;           (dolist (compositor seleccionados)
;;             (maphash (lambda (_file track)
;;                        (when (and (alist-get 'info-composer track)
;;                                   (string= compositor (alist-get 'info-composer track)))
;;                          (push (alist-get 'name track) pistas-encontradas)))
;;                      emms-cache-db))
;;           ;; Reproducir o mostrar pistas
;;           (if pistas-encontradas
;;               (progn
;;                 (emms-playlist-clear)
;;                 (dolist (pista pistas-encontradas)
;;                   (emms-add-file pista))
;;                 (message "Pistas añadidas a la lista de reproducción."))
;;             (message "No se encontraron pistas para los compositores seleccionados.")))))))

;; ;; lo mismo pero con artistas
;; (defun ism/--obtener-artistas-unicos ()
;;   "Extrae una lista única de artistas desde `emms-cache-db`."
;;   (let (artists)
;;     (maphash (lambda (_file track)
;;                (let ((artist (alist-get 'info-artist track)))
;;                  (when artist
;;                    (push artist artists))))
;;              emms-cache-db)
;;     ;; Eliminar duplicados y devolver la lista
;;     (delete-dups artists)))


;; ;;; buscar-por-compositores
;; (defun ism/buscar-por-artistas ()
;;   "Selecciona artistas únicos y busca sus pistas en EMMS."
;;   (interactive)
;;   (let* ((artistas (ism/--obtener-artistas-unicos))
;;          (seleccionados (completing-read-multiple
;;                          "Selecciona artists: "
;;                          artistas)))
;;     (when seleccionados
;;        (save-excursion
;;         ;; Cambiar temporalmente al buffer de la playlist;
;;         ;; deberíamos complrobar si existe...
;;         (set-buffer emms-playlist-buffer)
;;         (let (pistas-encontradas)
;;           ;; Buscar pistas para los artists seleccionados
;;           (dolist (artista seleccionados)
;;             (maphash (lambda (_file track)
;;                        (when (and (alist-get 'info-artist track)
;;                                   (string= artista (alist-get 'info-artist track)))
;;                          (push (alist-get 'name track) pistas-encontradas)))
;;                      emms-cache-db))
;;           ;; Reproducir o mostrar pistas
;;           (if pistas-encontradas
;;               (progn
;;                 (emms-playlist-clear)
;;                 (dolist (pista pistas-encontradas)
;;                   (emms-add-file pista))
;;                 (message "Pistas añadidas a la lista de reproducción."))
;;             (message "No se encontraron pistas para los artistas seleccionados.")))))))

;; ;; con algo así se podría escoger una playlist
;; ;; (defun emms-agregar-tracks-de-compositor-multiple-playlists (compositor)
;; ;;   "Agrega a una playlist seleccionada todos los tracks del compositor especificado desde `emms-cache-db`.
;; ;; Permite elegir el buffer de la playlist si hay múltiples listas de reproducción activas."
;; ;;   (interactive
;; ;;    (list (completing-read "Selecciona un compositor: "
;; ;;                           (emms-extraer-compositores)
;; ;;                           nil t)))
;; ;;   (let* ((buffers (seq-filter (lambda (buf)
;; ;;                                 (with-current-buffer buf
;; ;;                                   (derived-mode-p 'emms-playlist-mode)))
;; ;;                               (buffer-list)))
;; ;;          (playlist-buffer
;; ;;           (if (= (length buffers) 1)
;; ;;               (car buffers)
;; ;;             (completing-read "Selecciona una playlist: "
;; ;;                              (mapcar #'buffer-name buffers)
;; ;;                              nil t))))
;; ;;          (playlist-buffer (get-buffer playlist-buffer)))
;; ;;     (if (not playlist-buffer)
;; ;;         (error "No se seleccionó un buffer de playlist válido")
;; ;;       (save-excursion
;; ;;         ;; Cambiar al buffer seleccionado
;; ;;         (set-buffer playlist-buffer)
;; ;;         (let ((tracks-a-agregar
;; ;;                (seq-filter
;; ;;                 (lambda (track)
;; ;;                   (let ((composer (alist-get 'info-composer track)))
;; ;;                     (and composer (string= compositor composer))))
;; ;;                 (hash-table-values emms-cache-db))))
;; ;;           (if (null tracks-a-agregar)
;; ;;               (message "No se encontraron tracks para el compositor: %s" compositor)
;; ;;             (progn
;; ;;               ;; Agregar los tracks al buffer seleccionado
;; ;;               (mapc #'emms-playlist-new append tracks-a-agregar)
;; ;;               (message "Se agregaron %d tracks del compositor %s a %s"
;; ;;                        (length tracks-a-agregar) compositor (buffer-name playlist-buffer))))))))))


(provide 'ism-emms)
;;; ism-emms.el ends here
