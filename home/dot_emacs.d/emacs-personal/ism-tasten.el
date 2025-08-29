(message "Loading own keybindings...")

(global-set-key [f1] 'delete-other-windows)
(global-set-key [f2] 'split-window-vertically)
(global-set-key [f3] 'split-window-horizontally)
(global-set-key [f4] 'kill-buffer)
(global-set-key [f5] 'ism/toggle-two-split-window)
;;(global-set-key [f5] 'dired-jump)
;;(global-set-key [f6] 'privat)
(global-set-key [f6] 'enlarge-window)
(global-set-key [C-f6] 'shrink-window)
(global-set-key [f7] 'enlarge-window-horizontally)
(global-set-key [C-f7] 'shrink-window-horizontally)

;;(global-set-key "\M-0" 'treemacs-select-window)

(global-set-key [(control +)] 'text-scale-increase)
(global-set-key [(control -)] 'text-scale-decrease)
;; (global-set-key [(super r)] 'ism/ir-a-r)
(global-set-key [(super i)] 'ism/ir-a-ibuffer)
(global-set-key [(super u)] 'notmuch)
(global-set-key [(super l)] 'flyspell-correct-at-point) ; también es C-;
(global-set-key [(super .)] 'hydra-dashboard/body)
(global-set-key (kbd "s-ç") 'calc)
(global-set-key (kbd "s-0") 'consult-buffer)

(global-set-key (kbd "s-'") 'ism/ir-a-agenda)
(global-set-key (kbd "s-º") 'ism/ir-a-telegram-root)

;;(global-set-key (kbd "C-c C-SPC") 'erc-track-switch-buffer)
;;(global-set-key (kbd "C-c C-b") 'erc-switch-to-buffer)

(global-set-key (kbd "M-º") 'save-buffer)
;; M-1 etc. es para los tabs

(global-set-key "\M-\S-k" 'ism/borrar-frase)

(global-set-key (kbd "<f9> <f9>") 'org-agenda)
(global-set-key (kbd "<f9> b") 'bbdb)
(global-set-key (kbd "<f9> c") 'calendar)
(global-set-key (kbd "<f9> d") 'ism/org-agenda-heute)
(global-set-key (kbd "<f9> e") 'ism/org-capture-e)  ;email persönlich
(global-set-key (kbd "<f9> r") 'org-capture)
(global-set-key (kbd "<f9> s") 'org-narrow-to-subtree)
(global-set-key (kbd "<f9> t") 'ism/org-capture-todo)
(global-set-key (kbd "<f9> w") 'widen)

; primero deshabilitamos f10...
;; (global-unset-key (kbd "<f10>"))
;; (global-set-key (kbd "<f10> os") (lambda () (interactive) (find-file "~/Documents/sprachen/espanol.txt")))
;; (global-set-key (kbd "<f10> od") (lambda () (interactive) (find-file "~/Documents/sprachen/deutsch.txt")))
;; (global-set-key (kbd "<f10> oe") (lambda () (interactive) (find-file "~/Documents/sprachen/esperanto.txt")))
;; (global-set-key (kbd "<f10> ck") 'keychain-refresh-environment)

; deshabilitar C-z porque realmente para qué sirve...
(global-unset-key "\C-z")
(global-set-key (kbd "C-z") 'undo-tree-visualize)

; para el popup-kill-ring
;(global-set-key "\M-y" 'popup-kill-ring)

;; ...never switch to overwrite mode, not even accidentally
(global-set-key [insert]
  (function
   (lambda () (interactive)
     (message "Lo siento, el modo de sobreescritura lo he deshabilitado"))))

(define-key dired-mode-map "-" 'dired-up-directory)

(eval-after-load "org" '(define-key org-mode-map (kbd "C-c ñ")
			  'org-sort))

(eval-after-load "org-agenda" '(define-key org-agenda-mode-map "\M-+"
			  'org-agenda-date-later))
(eval-after-load "org-agenda" '(define-key org-agenda-mode-map "\M--"
			  'org-agenda-date-earlier))

; prefer dired over dumping dir list to buffer
(global-set-key "\C-x\C-d" 'dired)

;(global-set-key (kbd "C-c e") 'rgr/ido-erc-buffer)
(global-set-key "\C-cd" 'duplicate-dwim)

;(global-set-key "\C-cy" 'browse-kill-ring)

(global-set-key (kbd "C-x C-b") 'treemacs)

;; defined in functions from
;; https://stackoverflow.com/questions/9688748/emacs-comment-uncomment-current-line
;; esto creo que ya está con comment-dwim: NO, no exactamente! 
(global-set-key "\M-;" 'st/comment-or-uncomment-region-or-line)
;; (global-set-key "\M-;" 'comment-dwim) 

;; lo tengo definido en otro sitio...
;;(global-set-key (kbd "M-o") 'ace-window)
;;(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

;; EMMS
;; en emms tenemos las teclas de EMMS (con C-c e)

;; expreg package
(define-key global-map (kbd "C-M-SPC") 'er/expand-region)

(provide 'ism-tasten)
;;; ism-tasten.el ends here
