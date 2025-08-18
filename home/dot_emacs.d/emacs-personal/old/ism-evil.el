; (message "Evil wird geladen...")

;(add-to-list 'load-path "~/giteando/evil")
(require 'evil)
; ATENCIÓN: lo arranco al final del todo!

; modos que se inician con emacs
(defun set-mode-to-default-emacs (mode)
  (evil-set-initial-state mode 'emacs))

(defun set-mode-to-default-normal (mode)
  (evil-set-initial-state mode 'normal))

(mapcar 'set-mode-to-default-emacs
        '(dired
          occur-mode
          term-mode
          org-mode
          fundamental-mode
          eshell
          Info-mode
          erc-mode
          help-mode
          ess-mode
	  woman-mode
 	  ; todo lo que sea git y magit
	  global-git-commit-mode
          git-rebase-mode
          jabber-chat-mode 
          log-view-mode
	  ; mu4e
	  message-mode
	  mu4e-compose-mode
          mu4e-main-mode
          mu4e-headers-mode
          mu4e-view-mode
	  undo-tree-visualizer-mode
	  inferior-ess-mode 
	  ess-help-mode
	  wikimedia-mode
	  calculator-mode
	  jabber-roster-mode
	  grep-mode
	  dired-mode
	  apropos-mode
	  calendar-mode
	  image-mode
	  sql-interactive-mode
	  sauron-mode
 	  sunshine-mode
	  cfw:details-mode
 	  diff-mode))

; modos que se inician como vim
(mapcar 'set-mode-to-default-normal
        '(lisp-mode
          sh-mode
	  lua-mode
          ))

;; General command-type stuff

(define-key evil-normal-state-map ",w" 'save-buffer) ; save
(define-key evil-normal-state-map ",s" 'save-buffer) ; (I can't make up my mind on w vs. s)
(define-key evil-normal-state-map ",d" 'kill-this-buffer)
;(define-key evil-normal-state-map ",a" 'my-anything) ; emacs anything
(define-key evil-normal-state-map ",o" 'org-agenda)  ; access org agenda buffer
(define-key evil-normal-state-map ",b" 'ido-switch-buffer)  ; access org agenda buffer

;; (evil-define-key 'normal org-mode-map "L" 'org-shiftright)
;; (evil-define-key 'normal org-mode-map "H" 'org-shiftleft)
;; (evil-define-key 'normal org-mode-map "K" 'org-shiftup)
;; (evil-define-key 'normal org-mode-map "J" 'org-shiftdown)
;(evil-define-key 'normal org-mode-map (kbd "M-l") 'org-metaright)
;(evil-define-key 'normal org-mode-map (kbd "M-h") 'org-metaleft)
;(evil-define-key 'normal org-mode-map (kbd "M-k") 'org-metaup)
;(evil-define-key 'normal org-mode-map (kbd "M-j") 'org-metadown)
;(evil-define-key 'normal org-mode-map (kbd "M-L") 'org-shiftmetaright)
;(evil-define-key 'normal org-mode-map (kbd "M-H") 'org-shiftmetaleft)
;(evil-define-key 'normal org-mode-map (kbd "M-K") 'org-shiftmetaup)
;(evil-define-key 'normal org-mode-map (kbd "M-J") 'org-shiftmetadown)
;(evil-define-key 'normal org-mode-map "t" 'org-todo) ; mark a TODO item as DONE

;;; key chords for simultaneous key presses for common commands

;(require 'key-chord) ; for mapping simultaneous key presses
;; http://www.emacswiki.org/emacs/key-chord.el
;(key-chord-mode 1)
;(key-chord-define-global "jk"  'evil-normal-state) ; super ESC
;(key-chord-define-global "JK"  'evil-emacs-state)

;(setq evil-emacs-state-cursor '("sky blue" box))
;(setq evil-normal-state-cursor '("orange" box))
;(setq evil-visual-state-cursor '("khaki2" box))
;(setq evil-insert-state-cursor '("red" bar))
;(setq evil-replace-state-cursor '("red" bar))
;(setq evil-operator-state-cursor '("red" hollow))

; se puede habilitar con turn-on-evil-mode
;(evil-mode 1)

(provide 'ism-evil)
