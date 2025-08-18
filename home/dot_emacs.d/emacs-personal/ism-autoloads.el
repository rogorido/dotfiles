(message "Loading auto-mode-list...")

;; Esto hay que ponerlo antes de los ficheros que cargo porque luego
;; ahí cambio algunas cosas y si no me lo estropea...
(add-to-list 'auto-mode-alist '("\\.*rc$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.*conf$" . conf-mode))
(add-to-list 'auto-mode-alist '("autostart$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.zsh$" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.SCORE$" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("\\.ADAPT$" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("abbrev_defs$" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("configure\\(\\.in\\)?\\'" . autoconf-mode))
;; https://github.com/wasamasa/nov.el
(add-to-list 'auto-mode-alist '("CMakeLists.txt" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.http$" . restclient-mode))

; esto es para que cargue cperl-mode en lugar de perl-mode
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))
(setq auto-mode-alist
       (append '(("\\.fetchmailrc$" . fetchmail-mode))
 	        auto-mode-alist))

;; al parecer sirve para abrir adjuntos .eml en emails
;; entiendo que en mu se pulsa o y lo abre...
(add-to-list 'auto-mode-alist '("\\.eml$" . mail-mode))
; lo de markmode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdx\\'" . markdown-mode))

; OSC de openstreetmap
(add-to-list 'auto-mode-alist '("\\.osc\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.osm\\'" . nxml-mode))

(add-to-list 'auto-mode-alist '("\\.java\\'" . java-mode))

(autoload 'sparql-mode "sparql-mode.el"
    "Major mode for editing SPARQL files" t)
(add-to-list 'auto-mode-alist '("\\.sparql$" . sparql-mode))
(add-to-list 'auto-mode-alist '("\\.ql$" . sparql-mode))
(add-to-list 'auto-mode-alist '("\\.qr$" . sparql-mode))
;(add-to-list 'auto-mode-alist '("drill-\\.org$" . anki-editor-mode))

;;; webgeneral
;;; adtención pongo esto por ahora aquí para ver si consigo que
;;; funcione...
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ejs?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hbs?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.pug?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.astro?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . css-mode))
;(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
;;(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;;(add-to-list 'auto-mode-alist '("\\.js\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
;;(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-ts-mode))


(provide 'ism-autoloads)
;;; ism-autoloads.el ends here
