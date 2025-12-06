(message "Loading EMMS settings...")

;; important information for updating the database
;; 1. emms-add-directory-tree
;; 2. emms-cache-save
;; 3. emms-cache-sync (and C-u M-x emms-cache-sync for updating also removed items!)

(require 'emms-setup)
(emms-all)

(require 'ism-emms-ext)

;; (require 'emms-player-mpv)
;; (require 'emms-source-file) ;; probably not necessary...
;; (require 'emms-source-playlist)
;; (require 'emms-playlist-mode)
;; (require 'emms-info-native) ;; info-mp3info, etc.?
;; (require 'emms-cache)
;; (require 'emms-mode-line)
;; (require 'emms-mark)
;; (require 'emms-show-all)
;; (require 'emms-playing-time)
;; ;; (require 'emms-playlist-sort) ;; I do not sort the playlist...
;; (require 'emms-browser)
;; ;; (require 'emms-bookmarks) ;; do I need that?
;; ;; (require 'emms-score) ;; I do not use it, but maybe...
;; (require 'emms-playlist-limit)
;; (require 'emms-idapi-musicbrainz)
;; (require 'emms-metaplaylist-mode)
;; (require 'emms-playlist-limit)
;; (require 'emms-history)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; some configs found in emms-all in emms-setup.el
;; ;;
;; (setq emms-playlist-default-major-mode #'emms-playlist-mode)
;; (add-to-list 'emms-track-initialize-functions #'emms-info-initialize-track)
;; (setq emms-track-description-function #'emms-info-track-description)
;; (when (fboundp 'emms-cache); work around compiler warning
;;   (emms-cache 1))
;; ;; (emms-mode-line-mode 1)
;; ;; (emms-mode-line-blank)
;; ;; this is important! otherwise listenbrainz does not send the played track
;; ;; because it relies on the playing-time!
;; (emms-playing-time-mode 1)
;; ;; but I do not want to see the playing time
;; ;;(emms-playing-time-disable-display) ;; obsolete!

;; (add-hook 'emms-player-started-hook #'emms-last-played-update-current)
;; (remove-hook 'emms-player-started-hook #'emms-lyrics-start)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; he experimentado con emms-info-exiftool y va mucho más lento y no
;; parece que los resultados sean muy diferentes... 
(setq emms-player-list '(emms-player-mpv)
      emms-info-functions '(emms-info-native))

;; When asked for emms-play-directory,
;; always start from this one
(setq emms-source-file-default-directory "~/musica/"
      emms-source-playlist-default-format 'native
      emms-playlist-mode-center-when-go t)
(emms-mode-line-mode -1)

;; Show the current track each time EMMS
;; starts to play a track with "NP : "
(add-hook 'emms-player-started-hook 'emms-show)
(setq emms-show-format "NP: %s")

; esta variable tiene dos opciones y esta es la más rápida
; es algo de buscar los directorios.
(setq emms-source-file-directory-tree-function 'emms-source-file-directory-tree-find)

(setq emms-filters-multi-filter-save-file "~/.emacs.d/emmsfilters.el")

(emms-filters-make-filters general-filters)
(remove-hook 'emms-filters-expand-render-hook 'emms-browser-expand-all)
(emms-filters-add-to-filter-menu-from-filter-list "Propios" general-filters)

;; (defun emms-filters-make-filter-has-played ()
;;  "Show only tracks that have been played."
;;  #'(lambda (track)
;;      (emms-track-get track 'last-played nil)))

;; (emms-filters-register-filter-factory "Tocado"
;;                          'emms-filters-make-filter-has-played
;;                          '())

(require 'emms-lyrics)
(emms-lyrics 1)
(add-hook 'emms-player-started-hook 'emms-lyrics-lrclib-get)
;; (setq emms-lyrics-dir "~/.lyrics/")

;; covers
(setq emms-browser-covers #'emms-browser-cache-thumbnail-async)
(setq emms-browser-default-covers
      '("~/musica/nocover_small.jpg" "~/musica/nocover_medium.jpg" "~/musica/nocover.jpg"))

;; realmente no quiero que me cargue todas las listas medio-temporales
;; que puedo crear...
;; (require 'emms-history)
;; (emms-history-load)
(emms-cache-enable)

(add-hook 'emms-playlist-mode-hook 'hl-line-mode)

(require 'emms-listenbrainz-scrobbler)
(emms-listenbrainz-scrobbler-enable)
;; que no esté dando la pesadez de que envía el asunto... 
(setq emms-listenbrainz-scrobbler-display-submissions nil)

;; teclas generales
(dolist (key-func '(("C-c e e" . emms-smart-browse)
                    ("C-c e p" . emms-pause)
                    ("C-c e s" . emms-stop)
                    ("C-c e n" . emms-next)
                    ("C-c e g" . emms-metaplaylist-mode-go)
                    ("C-c e z" . emms-toggle-repeat-track)
                    ("C-c e u" . emms-score-up-playing)
                    ("C-c e d" . emms-score-down-playing)
                    ("C-c e C-r" . emms-toggle-repeat-playlist)
                    ("C-c e C-b" . emms-browser)
                    ("C-c e C-p" . emms-playlist-mode-go)))
  (global-set-key (kbd (car key-func)) (cdr key-func)))

;; Keybindings for emms-browser
(dolist (key-func '(("e" . emms-smart-browse)
                    ("P" . emms-pause)
                    ("SPC" . emms-pause)
                    ("S" . emms-stop)
                    ("z" . emms-toggle-repeat-track)
                    ("j" . next-line)
                    ("k" . previous-line)
                    ("N" . emms-playlist-new)
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
                    ;;("b 2" . emms-browser-expand-to-level-2) ;; too slow
                    ;;("b 3" . emms-browser-expand-to-level-3) ;; too slow 
                    ;;("b 4" . emms-browser-expand-to-level-4) ;; too slow
                    ;; ("+" . emms-browser-next-filter)
                    ;; ("-" . emms-browser-previous-filter)
                    ))
  (define-key emms-browser-mode-map (kbd (car key-func)) (cdr key-func)))

;; Keybindings for emms-playlist 
(dolist (key-func '(("j" . next-line)
                    ("k" . previous-line)
                    ("SPC" . emms-pause)
                    ("z" . emms-toggle-repeat-track)
                    ("e" . emms-smart-browse)
                    ("N" . emms-playlist-new)
                    ))
  (define-key emms-playlist-mode-map (kbd (car key-func)) (cdr key-func)))

;; Keybindings for emms-browser
(dolist (key-func '(("q" . kill-current-buffer)
                    ("j" . next-line)
                    ("k" . previous-line)
                    ))
  (define-key emms-metaplaylist-mode-map (kbd (car key-func)) (cdr key-func)))

(emms-history-load)

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


;; https://sqrtminusone.xyz/posts/2021-09-07-emms/
(defun my/emms-cleanup-urls ()
  (interactive)
  (let ((keys-to-delete '()))
    (maphash (lambda (key value)
               (when (eq (cdr (assoc 'type value)) 'url)
                 (add-to-list 'keys-to-delete key)))
             emms-cache-db)
    (dolist (key keys-to-delete)
      (remhash key emms-cache-db)))
  (setq emms-cache-dirty t))

(defun my/emms-cleanup-streams ()
  (interactive)
  (let ((keys-to-delete '()))
    (maphash (lambda (key value)
               (when (eq (cdr (assoc 'type value)) 'playlist)
                 (add-to-list 'keys-to-delete key)))
             emms-cache-db)
    (dolist (key keys-to-delete)
      (remhash key emms-cache-db)))
  (setq emms-cache-dirty t))

(provide 'ism-emms)
;;; ism-emms.el ends here
