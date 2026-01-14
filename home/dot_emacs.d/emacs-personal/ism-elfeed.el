(message "Loading settings for elfeed...")

(use-package elfeed
  :ensure t
  :bind
  (:map elfeed-search-mode-map
        ("j" . next-line)
        ("k" . previous-line)
        ("SPC" . elfeed-search-show-entry)
        ("1" . elfeed-read-hsoz-job)
        ("2" . elfeed-read-hsoz-rez)
        ("3" . elfeed-read-hsoz-tagber)
        ("4" . elfeed-read-hsoz-sonst)
        ;; ("2" . elfeed-read-xataka)
        ("/ m" . ism/musica)
        ("/ g" . ism/geopolitik)
        ("/ h" . ism/history)
        ("/ i" . ism/islam)
        ("/ e" . ism/economia)
        ("/ c" . ism/cultura)
        ("/ /" . my/elfeed-search-filter-source)
        ("s" . bjm/elfeed-search-live-filter-space)
        ("d" . elfeed-search-untag-all-unread) ;; mark as read! (from `delete')
        )
  (:map elfeed-show-mode-map
        ("m" . bard/add-video-emms-queue))
        ;; ("m" . mi-multimedia-url-emms))
  :config
  (setq elfeed-search-filter "@1-months-ago +unread")
  (defun my/elfeed-search-filter-source (entry)
    "Filter elfeed search buffer by the feed under cursor."
    (interactive (list (elfeed-search-selected :ignore-region)))
    (when (elfeed-entry-p entry)
      (elfeed-search-set-filter
       (concat
        "@6-months-ago "
        "+unread "
        "="
        (replace-regexp-in-string
         (rx "?" (* not-newline) eos)
         ""
         (elfeed-feed-url (elfeed-entry-feed entry)))))))

   (defun elfeed--read-tag (filter tag)
    "Template for filtering various feed categories.

       FILTER is the filter string to apply, and TAG is a short name of
       the displayed category.

       The cursor is moved to the beginning of the first feed line."
    (setq elfeed-search-filter filter)
    (elfeed-search-update :force)
    ;;(goto-char (point-min))
   ;; (beginend-elfeed-search-mode-goto-beginning)
    (message (concat "elfeed: show " tag)))
   
  (defun elfeed-read-xataka ()
    "Show global news articles"
    (interactive)
    ;; (elfeed--remove-sports)
    (elfeed--read-tag "@1-month-ago +unread =Xataka " "Xataka"))

  (defun elfeed-read-hsoz-job ()
    "Show HSOZ-KULT Jobs."
    (interactive)
    (elfeed--read-tag   "@6-months-ago +unread =HSozKult Job:\\\|Stip: " "HSoz-Kult Jobs"))

  (defun elfeed-read-hsoz-rez ()
    "Show HSOZ-KULT Rezensionen."
    (interactive)
    (elfeed--read-tag   "@6-months-ago +unread =HSozKult Rez: " "HSoz-Kult Rezensionen"))

    (defun elfeed-read-hsoz-tagber ()
    "Show HSOZ-KULT Tagungsbericht."
    (interactive)
    (elfeed--read-tag   "@6-months-ago +unread =HSozKult Tagber: " "HSoz-Kult Tagungsberichte."))

    (defun elfeed-read-hsoz-sonst ()
      "Show HSOZ-KULT other feeds."
      (interactive)
      (elfeed--read-tag   "@6-months-ago +unread =HSozKult !Tagber\\\|Job\\\|Stip\\\|Rez: " "HSoz-Kult Sonst."))
    
  ;; https://www.bardman.dev/technology/elfeed
  (defun bard/add-video-emms-queue ()
    "Play the URL of the entry at point in mpv if it's a YouTube video. Add it to EMMS queue."
    (interactive)
    (let ((entry (elfeed-search-selected :single)))
      (if entry
          (let ((url (elfeed-entry-link entry)))
            (if (and url (string-match-p "https?://\\(www\\.\\)?youtube\\.com\\|youtu\\.be" url))
                (let* ((playlist-name "Watch Later")
                       (playlist-buffer (get-buffer (format " *%s*" playlist-name))))
                  (unless playlist-buffer
                    (setq playlist-buffer (emms-playlist-new (format " *%s*" playlist-name))))
                  (emms-playlist-set-playlist-buffer playlist-buffer)
                  (emms-add-url url)
                  (elfeed-search-untag-all-unread)
                  (message "Added YouTube video to EMMS playlist: %s" url))
              (message "The URL is not a YouTube link: %s" url)))
        (message "No entry selected in Elfeed."))))

  (defun mi-multimedia-url-emms ()
    (interactive)
    (let ((url (get-text-property (point) 'shr-url)))
      (emms-play-url (format "%s" url))))

  ;;insert space before elfeed filter. Why is not the default?
  (defun bjm/elfeed-search-live-filter-space ()
    "Insert space when running elfeed filter"
    (interactive)
    (let ((elfeed-search-filter (concat elfeed-search-filter " ")))
      (elfeed-search-live-filter)))

  (defun ism/islam ()
    (interactive)
    (elfeed-search-set-filter "@6-months-ago +unread +islam")
    )
  (defun ism/musica ()
    (interactive)
    (elfeed-search-set-filter "@6-months-ago +unread +musica")
    )
  (defun ism/geopolitik ()
      (interactive)
    (elfeed-search-set-filter "@6-months-ago +unread +geo")
    )
  (defun ism/cultura ()
    (interactive)
    (elfeed-search-set-filter "@6-months-ago +unread +cultura")
    )
  (defun ism/economia ()
    (interactive)
    (elfeed-search-set-filter "@6-months-ago +unread +economia"))
  (defun ism/history ()
    (interactive)
    (elfeed-search-set-filter "@6-months-ago +unread +history"))
  
  )


(use-package elfeed-protocol
    :ensure t
    :demand t
    :after elfeed
    :config
    (elfeed-protocol-enable)
    :custom
    (elfeed-use-curl t)
    (elfeed-set-timeout 36000)
    (elfeed-log-level 'debug)
    (elfeed-protocol-feeds '(("owncloud+https://rogorido@next.georeligion.org"
                              :password (password-store-get "digital/nextcloud/nextcloud-rogorido-admin")))))

;; esto es porque de manera sorprendente fever no actualiza en las dos direcciones...
;; ahora no sé dónde lo he sacado
;; de todas formas, el protocolo google reader tampoco lo hace
;; (defun my/elfeed-refresh ()
;;   (interactive)
;;   (mark-whole-buffer)
;;      (cl-loop for entry in (elfeed-search-selected)
;; 	      do (elfeed-untag-1 entry 'unread))
;;      (elfeed-search-update--force)
;;      (elfeed-protocol-fever-reinit "https://rogorido@rss.sosawergles.net"))


(use-package elfeed-summary
    :ensure t
    :demand t
    :after elfeed
    )

;; se puede hacer search que usa las búsquedas como elfeed-search-set-filter
;; o también query, pero eso no me funciona porque creo que solo funciona con elfeed-feeds
;; que yo no tengo definidios.. 

;; atención: parece que al menos con search añade él mismo +unread...
(setq elfeed-summary-settings
      '((group (:title . "GitHub")
               (:elements
                (query . (url . "SqrtMinusOne.private.atom"))
                (group . ((:title . "Revistas")
                          (:elements
                           (query . (and technik)))
                          (:hide t)))
                (group . ((:title . "Guix packages")
                          (:elements
                           (query . (and github guix_packages)))
                          (:hide t)))))
        (group (:title . "Blogs [People]")
               (:elements
                (query . (and blogs people (not emacs)))
                (group (:title . "Emacs")
                       (:elements
                        (query . (and blogs people emacs))))))
        (group (:title . "Politik")
               (:elements (search
                           (:filter . "@6-months-ago =Heinrich-Böll-Stiftung")
                           (:title . "Heinrich-Böll-Stiftung"))))
        (group (:title . "GeoPolitik")
               (:elements (search
                           (:filter . "@6-months-ago =Descrifrando")
                           (:title . "Descrifrando la Guerra"))
                          (search
                           (:filter . "@6-months-ago =IRIS")
                           (:title . "IRIS"))
                          (search
                           (:filter . "@6-months-ago =Eastern")
                           (:title . "Center for Eastern Studies"))
                          (search
                           (:filter . "@6-months-ago =Exterior")
                           (:title . "Política Exterior"))
                          (search
                           (:filter . "@6-months-ago =NaherOsten")
                           (:title . "Naher Osten"))
                          (search
                           (:filter . "@6-months-ago =VisualPolitik")
                           (:title . "VisualPolitik"))))
        (group (:title . "Economía")
               (:elements (search
                           (:filter . "@12-months-ago +economia =Gratis")
                           (:title . "Nada es gratis"))
                          (search
                           (:filter . "@12-months-ago +economia =VisualEconomik")
                           (:title . "VisualEconomik"))
                          (search
                           (:filter . "@12-months-ago +economia =Institut")
                           (:title . "Institut der Deutschen Wirtschaft"))))
        (group (:title . "Historia")
               (:elements (search
                           (:filter . "@6-months-ago =HSozKult Job:")
                           (:title . "Soz-Kult Job"))
                          (search
                           (:filter . "@6-months-ago =HSozKult Tagber:")
                           (:title . "Soz-Kult Tagber"))
                          (search
                           (:filter . "@6-months-ago =HSozKult CFP:")
                           (:title . "Soz-Kult CFP"))
                          (search
                           (:filter . "@6-months-ago =HSozKult Zs:")
                           (:title . "Soz-Kult Zeitschriften"))
                          (search
                           (:filter . "@6-months-ago =HSozKult Rez:")
                           (:title . "Soz-Kult Rezensionen"))))
        (group (:title . "Cultura")
               (:elements (search
                           (:filter . "@6-months-ago +musica")
                           (:title . "Música"))))
        (group (:title . "Videos")
               (:elements
                (group
                 (:title . "Music")
                 (:elements
                  (query . (and videos music))))
                (group
                 (:title . "Tech")
                 (:elements
                  (query . (and videos tech))))
                (group
                 (:title . "History")
                 (:elements
                  (query . (and videos history))))

                ))))

;; https://github.com/jeetelongname/elfeed-goodies
(require 'elfeed-goodies)
(elfeed-goodies/setup)

(setq elfeed-goodies/entry-pane-position 'bottom)

(use-package elfeed-score
  :ensure t
  :config
  (progn
    (elfeed-score-enable)
    (define-key elfeed-search-mode-map "=" elfeed-score-map)))


(provide 'ism-elfeed)
;;; ism-elfeed.el ends here
