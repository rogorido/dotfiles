(message "Loading ibuffer...")

(require 'ibuffer)
; ordena por major-mode, alfabético, etc. 
(setq ibuffer-default-sorting-mode 'alphabetical)

(setq ibuffer-saved-filter-groups
  (quote (("default"      
            ("Latex"
	     (or 
              (mode . latex-mode)
	      (mode . bibtex-mode)
	      ))
            ("Org" (mode . org-mode))
            ("Markdown" (mode . markdown-mode))
            ("Elisp" (mode . emacs-lisp-mode))
            ("IRC"  
	     (or 
	      (mode . erc-mode)
	      (mode . rcirc-mode)))
	    ("Magit" (name . "\*magit"))
	    ("Shell" (mode . sh-mode))
	    ("SQL" (mode . sql-mode))
	    ("Python" (mode . python-mode))
	    ("PDF" (mode . pdf-view-mode))
            ("Mail"
              (or 
               (mode . message-mode)
               (mode . mail-mode)
               ))
            ("Directorios"
             (mode . dired-mode))
            ("epub"
             (mode . nov-mode))
            ("Perl"
               (mode . cperl-mode))
            ("Terminales"
               (mode . term-mode))
	    ("Help" 
	     (or (name . "\*Help\*")
		 (name . "\*Apropos\*")
		 (name . "\*info\*")))
            ("R"
	     (or 
	      (mode . iess-mode)
               (mode . ess-mode)))
	    ("CPP"
	     (or
	      (mode . c++-mode)
	      (mode . c-mode)))
            ("HTML"
	     (or
	      (mode . typescript-mode)
              (mode . mhtml-mode)
              (mode . html-mode)
              (mode . css-mode)
              (mode . scss-mode)
              (mode . web-mode)
              (mode . rjsx-mode)
              (mode . php-mode)
              (mode . vue-mode)
              (mode . json-mode)))
            ("EMMS"
	     (or 
               (name . "EMMS")
	       (name . "Browsing")
	       (name . "Lyrics")))
 ))))

(add-hook 'ibuffer-mode-hook
  (lambda ()
    (ibuffer-auto-mode 1) ; mantiene actualizada la lista
    (ibuffer-switch-to-saved-filter-groups "default")))

; con esto no muestra buffers vacíos
(setq ibuffer-show-empty-filter-groups nil)

; con esto no da la paliza al borrar buffers 
; que no han sido modificados
(setq ibuffer-expert t)

(require 'ibuf-ext) ; al parecer es necesario para lo siguiente
(setq ibuffer-never-show-predicates
      (list "\\*Completions\\*" "\\*GNU Emacs\\*"
	    "\\*Messages\\*" "\\*scratch\\*" "\\*Compile-Log\\*"
	    "\\*ESS\\*" "\\*anything" ".bbdb" "\\*Help\\*"
	    "\\*Org Agenda\\*" "Calendar" "\\*fsm-debug\\*"
	    "\\*-jabber-roster-\\*" "\\*toc\\*" "\\*grep\\*"
	    "\\*Org Clock\\*" "\\*Backtrace\\*" ".newsrc-dribble"
	    "bbdb" "\\*[hH]elm" "\\*Paradox Report\\*" "\\*Packages\\**"
	    ))

; con esto resalta la línea en la que estamos
(add-hook 'ibuffer-mode-hook (lambda ()
     (hl-line-mode 1)))

;; Use human readable Size column instead of original one
(define-ibuffer-column size-h
  (:name "Size" :inline t)
  (cond
   ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
   ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
   (t (format "%8d" (buffer-size)))))

;; Modify the default ibuffer-formats
(setq ibuffer-formats
      '((mark modified read-only " "
	      (name 18 18 :left :elide)
	      " "
	      (size-h 9 -1 :right)
	      " "
	      (mode 16 16 :left :elide)
	      " "
	      filename-and-process)))

(provide 'ism-ibuffer)
;;; ism-ibuffer.el ends here
