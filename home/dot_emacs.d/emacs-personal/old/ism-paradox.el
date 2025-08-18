(message "Paradox-Einstellungen werden geladen...")

;; el paquete que mejora packages
(require 'paradox)
(setq paradox-lines-per-entry 1)
;(setq paradox-automatically-star t)

(setq paradox-execute-asynchronously t 
        ;paradox-spinner-type 'half-circle  ; Fancy spinner
        paradox-spinner-type 'box-in-box  ; Fancy spinner
        paradox-display-download-count t
        paradox-display-star-count t
        paradox-automatically-star nil
        ;; Hide download button, and wiki packages
        paradox-use-homepage-buttons nil ; Can type v instead
        paradox-hide-wiki-packages t)

(paradox-enable)

(provide 'ism-paradox)
