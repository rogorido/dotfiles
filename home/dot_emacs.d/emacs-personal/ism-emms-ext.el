(message "Loading EMMS filters...")

(setq ism/emms-general-filters
      '(
        ("Directory" "clasica" "musica/clasica")
        ("Directory" "renacimiento" "musica/renacimiento")
        ("Directory" "medieval" "musica/medieval")
        ("Directory" "extraeuropea" "musica/extraeuropea")
        ("Directory" "tradicional" "musica/tradicional")
        ("Directory" "cantautores" "musica/cantautores")
        ("Directory" "opera" "musica/opera")
        ("Directory" "pop" "musica/pop")

        ("Genre" "Barroco"    "Barroco")
        ("Genre" "Early music"    "Early Music")
        ;; ("Genre" "Opera"    "opera")

        ("Artist" "mozart"  "Mozart")
        ("Artist" "Francesco Geminiani" "Geminiani")
        ("Artist" "Francisco Tárrega" "Tárrega")
        ("Artist" "Carlos Gardel" "Carlos Gardel")
        ("Artist" "Johann Rosenmüller" "Johann Rosenmüller")
        ("Artist" "John Dowland 1563-1626" "John Dowland")
        ("Artist" "Luigi Boccherini" "Luigi Boccherini")
        ("Artist" "Luys Milan (c.1500-1561)" "Luys Milan")
        ("Artist" "Mateo Flecha, el Viejo" "Mateo Flecha, el Viejo")
        ("Artist" "Roland de Lassus (1536-1593)" "Roland de Lassus")
        ("Artist" "Fernando Sor (1778-1839)" "Fernando Sor")
        ("Artist" "Pierre Guédron (1570-1620)" "Pierre Guédron")
        ("Artist" "Étienne Moulinié (1599-1676)" "Étienne Moulinié")
        ("Artist" "Antoine Boësset (1587-1643)" "Antoine Boesset")
        ("Artist" "Michel Lambert (1610-1696)" "Michel Lambert")

        ;; crussell
        ("Album" "Cuarteto de clarinete" "Clarinet Quartets") 
        
        ;; all "modern" music...
        ("Multi-filter"
         "trad++"
         (("pop" "tradicional" "cantautores"))) 

        ("Multi-filter"
         "Barroco | Early Music"
         (("Barroco" "Early music")))

        ("Multi-filter"
         "mozart opera"
         (("Opera") ("mozart")))

        ("Multi-filter"
         "clásica española"
         (("Fernando Sor (1778-1839)" "Mateo Flecha, el Viejo"
           "Francisco Tárrega" "Luys Milan (c.1500-1561)")))

        ;; air de cour
        ("Multi-filter"
         "Air de cour"
         (("Étienne Moulinié (1599-1676)" "Pierre Guédron (1570-1620)" "Antoine Boësset (1587-1643)"
           "Michel Lambert (1610-1696)")))

        ("Multi-filter"
         "mozart (sin ópera)"
         (("mozart") (:not "Opera"))) ;; funciona pero mal por tags!

        ("Multi-filter"
         "clásica total"
         (("clasica" "renacimiento")))))

(provide 'ism-emms-ext)
;;; ism-emms-ext.el ends here
