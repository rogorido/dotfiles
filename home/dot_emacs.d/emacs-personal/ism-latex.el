(message "Loading latex settings...")

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
;;(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode
(add-hook 'LaTeX-mode-hook (lambda ()
			     (TeX-fold-mode 1)))

;; (add-hook 'LaTeX-mode-hook 'outline-minor-mode)

(setq-default TeX-master nil) ; Query for master file
(setq TeX-parse-self t) ; Enable parse on load.
(setq TeX-auto-save t) ; Enable parse on save.
(setq reftex-plug-into-AUCTeX t) ; esto al parecer es para utilizar reftex con auctex

;; (setq reftex-load-hook (quote (imenu-add-menubar-index)))
;; (setq reftex-mode-hook (quote (imenu-add-menubar-index)))

;; Default bibliography
(setq reftex-default-bibliography
      '("/home/igor/Documents/bib-dateien/bibliogeneral.bib"))

; con esto se compila por defecto a pdf
(setq TeX-PDF-mode t)
(setq TeX-view-program-list '(("pdfviewer" "zathura %o")))
(setq TeX-view-program-selection '((output-pdf "pdfviewer")))

;; (setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))

; para las comillas;
; hay que cargar babel después de csquotes
(setq LaTeX-csquotes-close-quote "}"
      LaTeX-csquotes-open-quote "\\enquote{")

; para usar Latexmk
(add-hook 'LaTeX-mode-hook (lambda ()
  (push 
    '("latexmk" "latexmk -synctex=1 -pvc %(mode) %s " TeX-run-TeX nil t
      :help "Run Latexmk on file")
    TeX-command-list)))
(add-hook 'TeX-mode-hook #'(lambda ()
			    (setq TeX-command-default "latexmk")))

;; corregir con flyspell
(add-hook 'LaTeX-mode-hook 'flyspell-mode)

;; para que me mostre las palabras esas que uso constantemente
(add-hook 'LaTeX-mode-hook 'writegood-mode)

;; activar también flycheck
;; (add-hook 'LaTeX-mode-hook 'flycheck-mode)

;;Inserts {} automaticly on _ and ^
(setq TeX-electric-sub-and-superscript t)

;; con esto evito que indente las footnote, los enquote, etc
(setq TeX-brace-indent-level 0)

; para marcar \com{}
(setq font-latex-user-keyword-classes
      '(("make-it-outstanding" (("com" "{")) warning command)
	("shadow-hidden" (("hide" "{")) shadow command)
	("shadow-comment" (("comment" "{")) shadow command)))

(setq reftex-toc-split-windows-fraction 0.35)

(setq reftex-cite-format
           '((?\C-m . "\\cite[]{%l}")
;             (?f . "\\footcite[][]{%l}")
             (?t . "\\textcite[]{%l}")
             (?p . "\\parencite[]{%l}")
             (?n . "\\nocite{%l}")))

; rehago la lista de macros que va a ocultar con fold-mode: con el 1
; indico que solo deja el contenido que hay en \enquote{1}
; con {1}:[1] se indica que el use el 1er argumento que está en {...}
; y el 1er arguemnto que está en [...]
(setq TeX-fold-macro-spec-list
      '(("[f]" ("footnote" "marginpar"))
       ("{1}:[1]||{1}" ("cite"))
       ("{1}:[1]" ("textcite"))
       ("[l]" ("label"))
       ("[r]" ("ref" "pageref" "eqref"))
       ("[i]" ("index" "glossary"))
       ("[1]:||*" ("item"))
       ("..." ("dots" "ldots"))
       (1 ("enquote" "com"))
       (1 ("part" "chapter" "section" "subsection" "subsubsection"
	   "paragraph" "subparagraph"
	   "part*" "chapter*" "section*" "subsection*" "subsubsection*"
	   "paragraph*" "subparagraph*"
	   "emph" "textit" "textsl" "textmd" "textrm" "textsf" "texttt"
	   "textbf" "textsc" "textup"))))

; para que ispell se salte algunas cosas: añado lo de enquote
; pero mejor citaorig
(setq ispell-tex-skip-alists
  '((;;("%\\[" . "%\\]") ; AMStex block comment...
     ;; All the standard LaTeX keywords from L. Lamport's guide:
     ;; \cite, \hspace, \hspace*, \hyphenation, \include, \includeonly, \input,
     ;; \label, \nocite, \rule (in ispell - rest included here)
     ("\\\\addcontentsline"              ispell-tex-arg-end 2)
     ("\\\\textcite"                     ispell-tex-arg-end 2) ; añadido por mí
     ("\\\\add\\(tocontents\\|vspace\\)" ispell-tex-arg-end)
     ("\\\\\\([aA]lph\\|arabic\\)"	 ispell-tex-arg-end)
;     ("\\\\enquote"                      ispell-tex-arg-end)
     ("\\\\citaorig"                      ispell-tex-arg-end)
     ;;("\\\\author"			 ispell-tex-arg-end)
     ("\\\\bibliographystyle"		 ispell-tex-arg-end)
     ("\\\\makebox"			 ispell-tex-arg-end 0)
     ("\\\\e?psfig"			 ispell-tex-arg-end)
     ("\\\\document\\(class\\|style\\)" .
      "\\\\begin[ \t\n]*{[ \t\n]*document[ \t\n]*}"))
    (;; delimited with \begin.  In ispell: displaymath, eqnarray, eqnarray*,
     ;; equation, minipage, picture, tabular, tabular* (ispell)
     ("\\(figure\\|table\\)\\*?"	 ispell-tex-arg-end 0)
     ("list"				 ispell-tex-arg-end 2)
     ("program"		. "\\\\end[ \t\n]*{[ \t\n]*program[ \t\n]*}")
     ("verbatim\\*?"	. "\\\\end[ \t\n]*{[ \t\n]*verbatim\\*?[ \t\n]*}"))))

; con esto obligo a que reftex use
; kpsewhich -format=bib %f
; y así encuentra los ficheros bib que están en ~/texmf/bibtex/bib
; que realmente son links a los ficheros en los diferentes
; directorios de los proyectos
(setq reftex-use-external-file-finders t)

;; con esto se carga una función que hace que TAB
;; funcione sobre sections como en orgmode
;(add-hook 'LaTeX-mode-hook #'latex-extra-mode)

(setq font-latex-fontify-script nil ;;Don't fontify sub/super: _ ^
      ; TeX-auto-untabify t           ;; remove Tabs at save
      ispell-check-comments nil)    ;;don't spell check comments

;; https://www.emacswiki.org/emacs/LaTeXPreviewPane
;; (latex-preview-pane-enable)

;;; mirar todo esto de abajo para integrarlo arriba!

;; Use pdf-tools to open PDF files
(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-source-correlate-start-server t)

;; Update PDF buffers after successful LaTeX runs
(add-hook 'TeX-after-compilation-finished-functions
          #'TeX-revert-document-buffer)

(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(setq TeX-source-correlate-method 'synctex)
(setq TeX-source-correlate-start-server t)

(provide 'ism-latex)
;;; ism-latex.el ends here
