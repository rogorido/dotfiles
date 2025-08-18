(message "Loading bibtex settings...")

;; cosas de helm-bibtex
(setq bibtex-completion-bibliography
      '("/home/igor/Documents/bib-dateien/bibliogeneral.bib"
	"/home/igor/Documents/bib-dateien/biblio-allgemein.bib"))

;; aquí se indica dónde están los pdfs
(setq bibtex-completion-library-path '("/home/igor/downloads"))

;; aquí se indica dónde están las notas
(setq bibtex-completion-notes-path "/home/igor/geschichte/zusfassungen")

;; cómo se muestra. también se puede hacer por tipo de documetno...
(setq bibtex-completion-display-formats
      '((t . "${author:36} ${title:80} ${year:4} ${=has-pdf=:1}${=has-note=:1} ${=type=:10}")))

(setq bibtex-completion-additional-search-fields '(keywords tags))

(setq bibtex-completion-pdf-symbol "⌘")
(setq bibtex-completion-notes-symbol "✎")

;; En principio los pdfs se abren dentro del propio emacs, entiendo.
;; Pero con esto...
(setq bibtex-completion-pdf-open-function
  (lambda (fpath)
    (call-process "zathura" nil 0 nil fpath)))

(provide 'ism-bibtex)
;;; ism-bibtex.el ends here
