(message "Helm-Bibtex-Einstellungen werden geladen...")

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

;; Esto tan raro realmente está copiado casi tal cual de las fuentes.
;; El asunto es que reordeno las acciones para poner primero las que
;; me interesan a mí.
(setq helm-source-bibtex
  (helm-build-sync-source "BibTeX entries"
    :header-name (lambda (name)
                   (format "%s%s: " name (if helm-bibtex-local-bib " (local)" "")))
    :candidates 'helm-bibtex-candidates
    :filtered-candidate-transformer 'helm-bibtex-candidates-formatter
    :action (helm-make-actions
             "Insert citation"            'helm-bibtex-insert-citation
             "Insert reference"           'helm-bibtex-insert-reference
             "Insert BibTeX key"          'helm-bibtex-insert-key
             "Insert BibTeX entry"        'helm-bibtex-insert-bibtex
             "Open PDF, URL or DOI"       'helm-bibtex-open-any
             "Open URL or DOI in browser" 'helm-bibtex-open-url-or-doi
             "Attach PDF to email"        'helm-bibtex-add-PDF-attachment
             "Edit notes"                 'helm-bibtex-edit-notes
             "Show entry"                 'helm-bibtex-show-entry
             "Add PDF to library"         'helm-bibtex-add-pdf-to-library)))

;; En principio los pdfs se abren dentro del propio emacs, entiendo.
;; Pero con esto...
(setq bibtex-completion-pdf-open-function
  (lambda (fpath)
    (call-process "zathura" nil 0 nil fpath)))

(provide 'ism-helm-bibtex)
