(message "Loading emms-ext...")

(setq general-filters
      '(
        ("Directory" "clasica" "musica/clasica")
        ("Directory" "renacimiento" "musica/renacimiento")
        ("Directory" "medieval" "musica/medieval")
        ("Directory" "extraeuropea" "musica/extraeuropea")
        ("Directory" "tradicional" "musica/tradicional")
        ("Directory" "cantautores" "musica/cantautores")

        ("Genre" "Barroco"    "Barroco")
        ("Genre" "Early music"    "Early Music")
        ("Genre" "Opera"    "opera")

        ("Artist" "mozart"  "Mozart")
        ("Artist" "Francesco Geminiani" "Geminiani")
        ("Artist" "Francisco Tárrega" "Tárrega")
        ("Artist" "Carlos Gardel" "Carlos Gardel")
        ("Artist" "Johann Rosenmüller" "Johann Rosenmüller")
        ("Artist" "John Dowland 1563-1626" "John Dowland")
        ("Artist" "Luigi Boccherini" "Luigi Boccherini")
        ("Artist" "Mateo Flecha, el Viejo" "Mateo Flecha, el Viejo")
        ("Artist" "Roland de Lassus (1536-1593)" "Roland de Lassus")

        ("Multi-filter"
         "Barroco | Early Music"
         (("Barroco" "Early music")))

        ("Multi-filter"
         "mozart opera"
         (("Opera") ("mozart")))

        ("Multi-filter"
         "mozart (sin ópera)"
         (("mozart") (:not "Opera"))) ;; funciona pero mal por tags!

        ("Multi-filter"
         "clásica total"
         (("clasica" "renacimiento")))
