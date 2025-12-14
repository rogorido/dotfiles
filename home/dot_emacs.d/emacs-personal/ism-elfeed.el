(message "Loading settings for elfeed...")

(use-package elfeed
  :ensure t
  :bind
  (:map elfeed-search-mode-map
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
                           (:filter . "@6-months-ago +politik")
                           (:title . "Alle"))
                          (search
                           (:filter . "@6-months-ago =Heinrich-Böll-Stiftung")
                           (:title . "Heinrich-Böll-Stiftung"))))
        (group (:title . "Economía")
               (:elements (search
                           (:filter . "@6-months-ago +economia")
                           (:title . "Alle"))
                          (search
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
                           (:filter . "@6-months-ago =HSozKult Rez:")
                           (:title . "Soz-Kult Rezensionen"))))
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

(provide 'ism-elfeed)
;;; ism-elfeed.el ends here
