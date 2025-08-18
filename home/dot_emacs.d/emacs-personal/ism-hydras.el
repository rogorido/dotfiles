(message "Loading own hydras...")

;; interesting for conditional hydras:
;; https://github.com/abo-abo/hydra/wiki/Conditional-Hydra

;; "Some are bound here:
;; https://github.com/rememberYou/.emacs.d/blob/master/config.org

;; Look at the one below Hydra-org-agenda-view and another one which
;; opens/closes Hydra with the same key, i.e., pressing 'v'.

(defconst cptestructuraspoliticas "/home/igor/geschichte/notes/20241129T184807--cptbook-estructuras-políticas__geobook.org")
(defconst cptcomercio "/home/igor/geschichte/notes/20241129T185058--cptbook-comercio__geobook.org")
(defconst cpttesis "/home/igor/geschichte/notes/20241129T185819--cptbook-tesis-e-hipótesis__geobook.org")
(defconst cptcontactos "/home/igor/geschichte/notes/20241129T193820--cptbook-intensificación-de-los-contactos-culturales__geobook.org")
(defconst cptconceptos "/home/igor/geschichte/notes/20241129T194021--cptbook-conceptualizaciones-y-métodos__geobook.org")
(defconst cptespacio "/home/igor/geschichte/notes/20241129T194311--cptbook-espacio-y-religión__geobook.org")
(defconst cptfechas "/home/igor/geschichte/notes/20241211T180850--cptbook-fechas__geobook.org")
(defconst cptlugares "/home/igor/geschichte/notes/20241211T193552--cptbook-lugares__geobook.org")
(defconst cptpersonajes "/home/igor/geschichte/notes/20241211T194838--cptbook-personajes__geobook.org")

(defhydra hydra-erc (:color blue)
  "erc"
  ("c" ism/arrancar-erc "conectar")
  ("v" ism/erc-mostrar-buffers "ver erc")
  ("b" erc-switch-to-buffer "ver erc"))

(defhydra hydra-dashboard (:color blue :hint nil)
  "
^
^General^         ^Georeligion^                ^Trabajo^                     ^Otros^                ^Agenda^         
^─────────^─────────^───^────────^───────────^──────^───────────────^──────^─────────^─────────^───^────────^────────────────────
_b_ buscar        _gg_ abrir proyecto        _tr_ georeligion              _l_ lernen             _acv_ citas (V)    
_m_ música        _gb_ abrir bookgeo         _tf_ fichar                   _O_ orgs               _acp_ citas (P)    
_G_ gastos        _gr_ abrir georeligion     _tz_ zfassungen               _x_ buffers molestos   ^ ^                
_ce_ .emacs       _gc_ capítulos             _tc_ cajones                  ^ ^                    ^ ^                
_co_ config       _dr_ rezos                 _tk_ konferenzen              ^ ^                    ^ ^                
_k_ Kinder        _dg_ gobierno              _tC_ Cataluña                 ^ ^                    ^ ^                
_s_ sol           ^ ^                        _tl_ Lernenweb                ^ ^                    ^ ^                
"
  ("b" hydra-buscar/body)
  ("ce" (find-file "~/.emacs"))
  ("co" ism/abrir-ficheros-config-emacs)
  ("l" ism/abrir-ficheros-lernen)
  ("O" ism/abrir-ficheros-org)
  ("e" hydra-erc/body)
  ("k" (find-file "~/Documents/org/kinder.org"))
  ("T" ism/ir-a-telegram-root)
  ("G" (find-file "~/Documents/gastos/ledgers/2024-gastos.ledger"))
  ("m" (tab-bar-select-tab 5))
  ("gg" (project-switch-project "~/geschichte/projekte/georeligion"))
  ("gb" (find-file "~/geschichte/projekte/georeligion/bookgeo.org"))
  ("gc" hydra-georeligion/body)
  ("gr" (bookmark-jump "leergeo"))
  ("ds" ism/--abrir-postgresql-dominicos)
  ("df" ism/abrir-ficheros-dominicos)
  ("dr" (find-file "~/geschichte/artikel/preachingglobally/preachingglobally.org"))
  ("dg" (find-file "~/geschichte/artikel/governingorder/governingorder.org"))
  ("tr" (tab-bar-select-tab 1))
  ("tl" (tab-bar-select-tab 3))
  ("tk" (find-file "~/Documents/org/konferenzen.org"))
  ("tf" ism/fichar-en-tarea)
  ("tz" ism/abrir-ficheros-zusammenfassungen)
  ("tc" ism/abrir-cajones)
  ("tC" (tab-bar-select-tab 2))
  ("x" ism/eliminar-buffers-molestos)
  ("acv" (org-agenda nil "cv"))
  ("acp" (org-agenda nil "cp"))
  ("s" sunrise-sunset :exit nil)
  ("s-." nil "salir" :color blue) ; con esto consigo que se abra/cierre... pero no entiendo por qué...
  ("q" nil "salir" :color red))

(defhydra hydra-georeligion (:color blue :hint nil)
  "
^
^Capítulos^  
^───────
_e_ Estructuras políticas
_c_ Comercio
_t_ Tesis
_i_ Interculturales
_p_ Conceptos
_s_ Espacio 
_f_ Fechas 
_l_ Lugares
_j_ Personajes
"
  ("b" hydra-buscar/body)
  ("e" (find-file cptestructuraspoliticas))
  ("c" (find-file cptcomercio))
  ("t" (find-file cpttesis))
  ("i" (find-file cptcontactos))
  ("p" (find-file cptconceptos))
  ("s" (find-file cptespacio))
  ("f" (find-file cptfechas))
  ("l" (find-file cptlugares))
  ("j" (find-file cptpersonajes))
  ;; ("ct" (org-agenda nil "42"))
  ;; ("cc" (org-agenda nil "43"))
  ;; ("cs" (org-agenda nil "41")) ; agenda simple todo junto.
  ;; ("ca" (org-agenda nil "45")) ; agenda anual
  ("q" nil "salir" :color red))


(defhydra hydra-proyecto (:color blue :hint nil)
  "
^
^General^          ^Agenda^      
^─────────^───────────────
_g_ Org general   _cs_ Simple
_G_ Gastos        _ca_ Agenda anual
_b_ Buscar        _ct_ Temática
^ ^               _cc_ Citas/tareas semana
^ ^               _cd_ Deadlines (cfw)
"
  ("b" hydra-buscar/body)
  ("g" (find-file "~/geschichte/projekte/proyectonacional/proyectonacional.org"))
  ("G" (find-file "~/geschichte/projekte/proyectonacional/gastos/domgastos.ledger"))
  ("ct" (org-agenda nil "42"))
  ("cc" (org-agenda nil "43"))
  ("cs" (org-agenda nil "41")) ; agenda simple todo junto.
  ("ca" (org-agenda nil "45")) ; agenda anual 
  ("cd" ism/cfw-deadlines-proyectonacional)
  ("q" nil "salir" :color red))

(defhydra hydra-web (:color blue :hint nil)
  "
^
^General^          
^───────────
_g_ Web general   
_as_ Agenda simple
_at_ Agenda twitter 
_ao_ Agenda en bloques 
"
  ("g" (find-file "~/geschichte/web/gestiongeneral/webgeneral.org"))
  ("at" (org-agenda nil "53"))
  ("as" (org-agenda nil "51"))
  ("ao" (org-agenda nil "52")) ; agenda anual 
  ("q" nil "salir" :color red))


;; hydra para usar fdç, ag, etc. 
(defhydra hydra-buscar (:color pink
                             :hint nil :exit t)
  "
^Nombre de ficheros^          ^Dentro de ficheros^         
^^^^^^^^-----------------------------------------------------------------------
_f_ fd-dired (Windows-ñ)      _r_: General (rg-menu)
_v_ volver                    ^^
"
  ("f" consult-fd)
  ("r" rg-menu)
  ("v" hydra-dashboard/body)
  ("q" nil "cancel"))

;; see ism-ediff for another hydra for smerge-mode!

(provide 'ism-hydras)
;;; ism-hydras.el ends here
