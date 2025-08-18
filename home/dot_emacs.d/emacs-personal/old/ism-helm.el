(message "Helm-Einstellungen werden geladen...")

(require 'helm)
(require 'helm-config)
(require 'helm-swoop)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(setq helm-split-window-inside-p            t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)

(global-set-key (kbd "M-y") 'helm-show-kill-ring)

;(global-set-key (kbd "C-x b") 'helm-mini)
;; (setq helm-buffers-fuzzy-matching t
;;       helm-recentf-fuzzy-match    t)

(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c h x") 'helm-register)

(setq helm-boring-buffer-regexp-list
      '("\\` " "\\*helm" "\\*helm-mode" "\\*Echo Area" "\\*Minibuf" "\\*GNU"
	"\\*Help" "\\*Ibuffer" "archive$" "\\*Org" "\\*fsm" "\\*Calendar" "\\*Shell" ".newsrc"
	"\\*Compile-log\\*" "\\*-jabber" "bbdb" "\\*magit" "\\*cfw"))

(setq helm-quick-update t) ; lo tengo de Sacha

;; Don't use helm for LaTeX commands, since they usually guess right anyway.
;;(add-to-list 'helm-completing-read-handlers-alist '(TeX-command-master))
;(add-to-list 'helm-completing-read-handlers-alist '(LaTeX-environment))
;(add-to-list 'helm-completing-read-handlers-alist '(TeX-insert-macro))
;;(add-to-list 'helm-completing-read-handlers-alist '(LaTeX-section))
;;(add-to-list 'helm-completing-read-handlers-alist '(TeX-master-file-ask))
;; Don't use helm for adding fields to BBDB, since helm cocks up the address business.
(add-to-list 'helm-completing-read-handlers-alist '(bbdb-insert-field))
(add-to-list 'helm-completing-read-handlers-alist '(bbdb-create))
;; Don't use it for org tags, 'cause other completion is better there.
;(add-to-list 'helm-completing-read-handlers-alist '(org-set-tags-command))
;(add-to-list 'helm-completing-read-handlers-alist '(org-set-tags))
;(add-to-list 'helm-completing-read-handlers-alist '(org-match-sparse-tree))

; lo de helm-descbinds
;(add-to-list 'load-path "~/giteando/helm-descbinds")
;(require 'helm-descbinds)
;(helm-descbinds-mode)

;; (setq helm-wikipedia-suggest-url "https://de.wikipedia.org/w/api.php?action=opensearch&search=")
;; (setq helm-search-suggest-action-wikipedia-url
;;       "https://de.wikipedia.org/wiki/Special:Search?search=%s")
;; (setq helm-wikipedia-summary-url
;;   "http://de.wikipedia.org/w/api.php?action=parse&format=json&prop=text&section=0&page=")

; entiendo que hace que no salga por defecto la palabra
; que está bajo el cursor
(setq helm-swoop-pre-input-function
      (lambda () ""))

;; con esto hacemos que coja la última búsqueda. Creo que
;; con esto es innecesario lo anterio... Tomado de:
;; https://github.com/ShingoFukuyama/helm-swoop
(setq helm-swoop-pre-input-function
      (lambda () (if (boundp 'helm-swoop-pattern)
                     helm-swoop-pattern "")))

;; esto nos permite usarlo con helm-project-find-files
(setq helm-locate-project-list '("/home/igor/geschichte" "/home/igor/programacion"
				 "/home/igor/Documents"))

(provide 'ism-helm)

;;; ism-helm.el ends here
