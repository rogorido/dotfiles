(message "Loading ESS...")

;; Must be specified before loading ESS.
;; al parecer esto está deprecado
;;(setq ess-smart-S-assign-key ";")  ;if ";" needed, press ";" key twice

;; In ESS when I am evaluating chunks of code in a .R file using C-c
;; C-j or C-c C-r (to send the line or region to a running R
;; process), how can I get the R buffer to scroll down
;; automatically, such that after evaluating a region the cursor is
;; at the bottom, at the prompt?
;; http://www.kieranhealy.org/blog/archives/2009/10/12/make-shift-enter-do-a-lot-in-ess/

;; (add-hook 'ess-mode-hook
;;           '(lambda()
;;              (setq comint-scroll-to-bottom-on-input t)
;;              (setq comint-scroll-to-bottom-on-output t)
;;              (setq comint-move-point-for-output t)))

(use-package ess
  :defer t
;  :init (require 'ess-site)
  :config

  ;; https://stackoverflow.com/questions/25404278/how-to-change-smart-assign-key-to-binding-in-ess
  (define-key ess-mode-map (kbd ";") 'ess-insert-assign)
  (define-key inferior-ess-mode-map (kbd ";") 'ess-insert-assign)

  ;; esto quita el pesado buffer *ESS*
  (setq ess-write-to-dribble nil)
  ;;(ess-disable-smart-S-assign)

  ;; esto al parecer sirve para que no indente los comentarios de esa
  ;; forma tan rara; el asunto es que sino lo ponemos así con un hook
  ;; cada vez que abre un script carga el style y ese style carga el
  ;; default value de esta variable. Ver la ayuda de la variable
  ;; ess-style-alist
  (defun mihook-quitar-fancy ()
    (setq ess-indent-with-fancy-comments nil))
  (add-hook 'ess-mode-hook #'mihook-quitar-fancy)

  ;; los ficheros Rout, Rt, etc. los uso como transcripts de R
  (add-to-list 'auto-mode-alist '("\\.[Rr]out" . R-transcript-mode))
  (add-to-list 'auto-mode-alist '("\\.[Rr]t" . R-transcript-mode))

  ;; (setq inferior-ess-own-frame t)

  (setq ess-use-flymake nil)

  ;; configuramos lo que marca sintácticamente en los scripts
  (setq ess-R-font-lock-keywords
	'((ess-R-fl-keyword:modifiers . t)
	  (ess-R-fl-keyword:fun-defs . t)
	  (ess-R-fl-keyword:keywords . t)
	  (ess-R-fl-keyword:assign-ops . t)
	  (ess-R-fl-keyword:constants . t)
	  (ess-fl-keyword:fun-calls . t)
	  (ess-fl-keyword:numbers)
	  (ess-fl-keyword:operators)
	  (ess-fl-keyword:delimiters . t)
	  (ess-fl-keyword:=)
	  (ess-R-fl-keyword:F&T)
	  (ess-R-fl-keyword:%op%)))

  ;; configuramos lo que marca sintácticamente en el buffer *R*
  (setq inferior-R-font-lock-keywords
	'((ess-S-fl-keyword:prompt   . t) ;; comint does that, but misses some prompts
    ;; (ess-S-fl-keyword:input-line) ;; comint boguously highlights input with text props, no use for this
	  (ess-R-fl-keyword:messages  . t)
	  (ess-R-fl-keyword:modifiers . t)
	  (ess-R-fl-keyword:fun-defs  . t)
	  (ess-R-fl-keyword:keywords  . t)
	  (ess-R-fl-keyword:assign-ops	. t)
	  (ess-R-fl-keyword:constants . t)
	  (ess-fl-keyword:matrix-labels	. t)
	  (ess-fl-keyword:fun-calls . t)
	  (ess-fl-keyword:numbers)
	  (ess-fl-keyword:operators . t)
	  (ess-fl-keyword:delimiters . t)
	  (ess-fl-keyword:=)
	  (ess-R-fl-keyword:F&T)))

  ;; quito el modo Abbrev de la consola de R porque creo
  ;; que intefiere un poco
  ;; importante es lo de ansi-color. Con emacs 28.1 me muestra tibbles
  ;; con unos colores raros que no se pueden leer. He encontrado la solución aquí
  ;; https://stat.ethz.ch/pipermail/ess-help/2022-July/013098.html
  (defun my-ess-hook ()
    (setq-local ansi-color-for-comint-mode 'filter)
    (abbrev-mode -1))
  (add-hook 'inferior-ess-mode-hook 'my-ess-hook)

  )

(provide 'ism-ess)
;;; ism-ess.el ends here
