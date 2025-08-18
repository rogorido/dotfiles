(message "Loading ef-themes...")

;; Make customisations that affect Emacs faces BEFORE loading a theme
;; (any change needs a theme re-load to take effect).
(require 'ef-themes)

;; If you like two specific themes and want to switch between them, you
;; can specify them in `ef-themes-to-toggle' and then invoke the command
;; `ef-themes-toggle'.  All the themes are included in the variable
;; `ef-themes-collection'.
; (setq ef-themes-to-toggle '(ef-summer ef-winter))
(setq ef-themes-to-toggle '(ef-cyprus ef-spring ef-autumn))

(setq ef-themes-headings ; read the manual's entry or the doc string
      '((0 . (variable-pitch light 1.9))
        (1 . (variable-pitch light 1.3))
        (2 . (variable-pitch regular 1.2))
        (3 . (variable-pitch regular 1.2))
        (4 . (variable-pitch regular 1.2))
        (5 . (variable-pitch 1.1)) ; absence of weight means `bold'
        (6 . (variable-pitch 1.1))
        (7 . (variable-pitch 1.1))
        (t . (variable-pitch 1.1))))

;; They are nil by default...
;; (setq ef-themes-mixed-fonts t
;;       ef-themes-variable-pitch-ui t)

;; Read the doc string or manual for this one.  The symbols can be
;; combined in any order.
;; TODO: this is obsolete!
(setq ef-themes-region '(intense no-extend neutral))

;; Disable all other themes to avoid awkward blending:
(mapc #'disable-theme custom-enabled-themes)

;; Load the theme of choice:
;(load-theme 'ef-cyprus :no-confirm)
(load-theme 'ef-autumn :no-confirm)

;; OR use this to load the theme which also calls `ef-themes-post-load-hook':
;;(ef-themes-select 'ef-summer)

;; The themes we provide are recorded in the `ef-themes-dark-themes',
;; `ef-themes-light-themes'.

;; We also provide these commands, but do not assign them to any key:
;;
;; - `ef-themes-toggle'
;; - `ef-themes-select'
;; - `ef-themes-load-random'
;; - `ef-themes-preview-colors'
;; - `ef-themes-preview-colors-current'

(provide 'ism-efthemes)
;;; ism-efthemes.el ends here
