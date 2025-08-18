(message "Loading spell and WriteGood settings...")

;; con esto se activa aspell como programa de ortografía en lugar de ispell
(setq-default ispell-program-name "aspell")

;;con esto se arranca el modo flyspell para los modos de texto y parecidos (también latex)
;(add-hook 'text-mode-hook 'flyspell-mode)
;(setq flyspell-issue-welcome-flag nil)

;;todo estas 3 siguientes cargan los diccionarios...
(setq ispell-dictionary "castellano"
      ispell-local-dictionary "castellano"
      flyspell-default-dictionary "castellano"
      ispell-highlight-face 'highlight
      ispell-silently-savep t)

; atención en ism-latex.el tengo una configuración para
; que se salte cosas de latex

;; tomado de aquí:
;; http://home.thep.lu.se/~karlf/emacs.html
(defun ism/--org-ispell ()
  "Configure `ispell-skip-region-alist' for `org-mode'."
  (make-local-variable 'ispell-skip-region-alist)
  (add-to-list 'ispell-skip-region-alist '(org-property-drawer-re))
  (add-to-list 'ispell-skip-region-alist '("~" "~"))
  (add-to-list 'ispell-skip-region-alist '("=" "="))
  (add-to-list 'ispell-skip-region-alist '("^#\\+BEGIN_SRC" . "^#\\+END_SRC")))
(add-hook 'org-mode-hook #'ism/--org-ispell)

;; Cosas de writegood-mode 

;; atneción no hacer M-q porque me separa en dos líneas cosas como
;; lo cierto es que
;; y me lo jode 
(setq writegood-weasel-words
      '("extrañar" "extraño"
        "crucial" "cruciales" "relevante" "notable"
        "relevantes" "por el contrario"
        "toda vez que" "lo cierto es que" "Lo cierto es que"
        "no es extraño"
        "denso" "densa" "densos" "densas"
        "conviene"
        "presenta" "presentan" "indudable" "indudablemnte"
        "es por ello" "concretamente" "para ello"))

;;
;; no sé por qué no funciona con .*
;; lo de los verbos no veo otra opción que la de [a-z]*
;; luego el problema es que [a-z] no incluye non-ascii y por eso hay que poner
;; [a-zéá]*
(defvar ism/weasel1 "abord[a-záé]*\\b\\|record[a-záé]*\\b\\|analiz[a-záé]*\\b\\|present[a-záé]*\\b\\|incid[a-záéí]*\\b\\|cuesti[oó]n[a-z]+?\\b")
(defvar ism/weasel2 "\\|centrar[a-zéá]*\\b\\|\\bsobre\\b\\|contamos\\|\\bmostr[a-záé]*\\b")
(setq writegood-weasel-words-additional-regexp (concat ism/weasel1 ism/weasel2 ))

;; (use-package flyspell-correct
;;   :after flyspell
;;   :bind (:map flyspell-mode-map ("C-;" . flyspell-correct-wrapper)))

;; (use-package flyspell-correct-ivy
;;   :after (flyspell ivy)
;;   :init (setq flyspell-correct-interface #'flyspell-correct-ivy))


; con esto se consigue que flyspell meta las correcciones en
; la tabla de abbrev y por tanto luego se corrijan automáticamente
(setq flyspell-abbrev-p t)
(setq flyspell-use-global-abbrev-table-p t)

(provide 'ism-aspell)
;;; ism-aspell.el ends here
