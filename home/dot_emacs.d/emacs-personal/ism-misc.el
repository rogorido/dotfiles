(message "Loading other settings...")

;; NOTE: here are a lot of configs which I test, I am not convinced of,
;; I do not know where to put them...

; con esto se logra que no meta en el trash algunos ficheros temporales
(setq system-trash-exclude-matches '("#[^/]+#$" ".*~$" "\\.emacs\\.desktop.*" "#.+"))
(setq system-trash-exclude-paths '("/tmp"))

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; make buffer names easily identifiable
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

;; con esto se consigue que no salga una ventana para lo de la
;; contraseña.
(setq epg-pinentry-mode 'loopback)

;; Dar permisos de ejecución al fichero si es un script
(setq after-save-hook
      (quote (executable-make-buffer-file-executable-if-script-p)))

;; Cosas de man:
;(setq Man-notify-method 'pushy)
;; con esto se consigue que la anchura sea esta
(setenv "MANWIDTH" "72")

(setq olivetti-body-width 72)

(use-package nov
  :config
  (setq nov-text-width 80)
  ;;(setq nov-text-width t)
  ;;(setq visual-fill-column-center-text t)
  ;;(add-hook 'nov-mode-hook 'visual-line-mode)
  ;;(add-hook 'nov-mode-hook 'visual-fill-column-mode)

  (defun my/nov-font-setup ()
    (face-remap-add-relative 'variable-pitch :family "Gentium Plus"
                             :height 1.2))
  (add-hook 'nov-mode-hook 'my/nov-font-setup)
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  )

;; Chezmoi for managing dotfiles
;; https://www.chezmoi.io/
;; https://github.com/tuh8888/chezmoi.el
(add-to-list 'load-path "~/giteando/chezmoi.el")
(add-to-list 'load-path "~/giteando/chezmoi.el/extensions")
(use-package chezmoi)
(require 'chezmoi-dired)
(require 'chezmoi-magit)

(add-to-list 'load-path "~/giteando/emacs-eat")
(use-package eat
  :config
  (setq eat-kill-buffer-on-exit t))

(use-package csv-mode
  :ensure t
         ;; Hook order matters:
  :hook ((csv-mode . csv-align-mode)            ;; Show the CSV in a tabular format
         ;; (csv-mode . csv-highlight)             ;; Add colours to columns for clearer reading
         (csv-mode . csv-guess-set-separator))) ;; Guess how to parse the CSV automatically

(use-package ssh-config-mode
  :ensure t
  :mode (("/\\.ssh/config\\(\\.d/.*\\.conf\\)?\\'" . ssh-config-mode)
         ("/sshd?_config\\(\\.d/.*\\.conf\\)?\\'" . ssh-config-mode)
         ("/known_hosts\\'"       . ssh-known-hosts-mode)
         ("/authorized_keys2?\\'" . ssh-authorized-keys-mode))
  :hook (((ssh-config-mode ssh-known-hosts-mode ssh-authorized-keys-mode) . turn-on-font-lock)))

(use-package ace-window
  :bind
  (("C-x o" . ace-window)
   ("H-o"   . ace-window))
  :init (ace-window-display-mode 1)
  :custom-face (aw-mode-line-face ((t (:inherit (bold mode-line-emphasis)))))
  :config (setq aw-swap-invert t)
  (setq aw-keys '(?q ?w ?e ?r ?t ?y ?u ?i ?p))
  (setq aw-dispatch-alist
        '((?k aw-delete-window "Delete Window")
          (?x aw-swap-window "Swap Windows")
          (?c aw-copy-window "Copy Window")
          (?j aw-switch-buffer-in-window "Select Buffer")
          (?o aw-flip-window)
          (?b aw-switch-buffer-other-window "Switch Buffer Other Window")
          (?c aw-split-window-fair "Split Fair Window")
          (?s aw-split-window-vert "Split Vert Window")
          (?v aw-split-window-horz "Split Horz Window")
          (?o delete-other-windows "Delete Other Windows")
          (?? aw-show-dispatch-help))))

;; Other packages
(add-to-list 'load-path "~/giteando/emacs-request/")
(add-to-list 'load-path "~/giteando/anki-editor/")
(add-to-list 'load-path "~/giteando/expand-region.el/")
;;(setq request-log-level 'debug)
;;(setq request-log-level 'error)
(require 'expand-region)

;; esto parece que deeshabilita completamente lo de vc-mode
;; (setq vc-handled-backends nil)

;(require 'keychain-environment)
(keychain-refresh-environment)
(defalias 'cargar-keychain 'keychain-refresh-environment)

; lo de recentfiles
(require 'recentf)
(setq recentf-max-saved-items 100
      recentf-exclude '("/tmp/" "/ssh:"))
(recentf-mode +1)

; Para que marque las regiones
(setq transient-mark-mode t)

; con esto se consigue que los buffer de ayuda etc se
; abran abajo y no al lado...
(setq split-height-threshold 0)
(setq split-width-threshold nil)

(eval-after-load 'gnus
  '(load-library "gnus-toggle-topics")
  )

;; also tabs are evil
(setq-default indent-tabs-mode nil)

;; necesitamos esto porque si no no encuentra el typescript-language-server
(setq exec-path (append exec-path '("~/.npm-global/bin")))
(setq exec-path (append exec-path '("~/.local/bin")))
(setq exec-path (append exec-path '("~/perl5/bin/" "~/perl5/lib/")))

(when (executable-find "rg")
  (setq grep-program "rg"))

(when (executable-find "fd")
  (setq find-program "fd"))

;; me molesta que "n" abra el buffer donde está el "error" con rg...
;; intercambiamos las teclas 
(require 'rg)
(define-key rg-mode-map (kbd "n") 'compilation-next-error)
(define-key rg-mode-map (kbd "p") 'compilation-previous-error)
(define-key rg-mode-map (kbd "M-n") 'next-error-no-select)
(define-key rg-mode-map (kbd "M-p") 'previous-error-no-select)

;; hace que no salga una window al abrir por ejemplo un vídeo con !
;; en dired
;; tomado de aquí:
;; https://emacs.stackexchange.com/questions/5553/async-shell-process-buffer-always-clobbers-window-arrangement
(add-to-list 'display-buffer-alist
             (cons "\\*Async Shell Command\\*.*" (cons #'display-buffer-no-window nil)))

(setq recenter-positions '(0.50 0.07 0.93)) ;default: '(middle top bottom)
;; First C-l  -> 0.50: Put point vertically at the middle of the window
;; Second C-l -> 0.07: Put point close to the top of the window. If
;;                     (window-height) returns 70, that's roughly 4 lines.
;; Third C-l  -> 0.93: Put point close to the bottom of the window ~ 3 lines.
;; With the default values of `recenter-positions' and `scroll-margin' (0),
;; the "top" position is the first line of the window, and the "bottom"
;; position is the last line. Above settings provides a margin of 3 or 4 lines
;; for my default window size for the "top" and "bottom" iterations.

(setq mastodon-instance-url "https://fedihum.org"
      mastodon-active-user "rogorido")

(use-package mastodon
  :ensure t
  :config
  (mastodon-discover))

(add-hook 'prog-mode-hook #'hl-line-mode)
(set-face-background hl-line-face "gray23")

;; con esto conseguimos emojis!
;; NOTE: atención esto es un lío del carajo... no sé si está cargando
;; esto de alguna forma porque si pongo el curso sobre esto: 🏵️ y hago
;; describe-char me sale que usa Noto pero si le digo que me describa la
;; fuente no... Pero si busco en nerd-fonts me dice que ese signo no
;; existe... Es decir, que lo está tomando de la otra...
(setf use-default-font-for-symbols nil)
(set-fontset-font t 'unicode "Noto Color Emoji" nil 'append)

(all-the-icons-completion-mode)

(use-package all-the-icons-ibuffer
  :after all-the-icons
  :ensure t
  :hook (ibuffer-mode . all-the-icons-ibuffer-mode))

(add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup)
(add-hook 'dired-mode-hook #'all-the-icons-dired-mode)

;; abre en mode view-mode todos los ficheros que no sean editables
(setq view-read-only t)

(add-hook 'package-menu-mode-hook 'hl-line-mode)
(add-hook 'markdown-mode-hook  'turn-on-flyspell)

(use-package kind-icon
  :ensure t
  :after corfu
  ;:custom
  ; (kind-icon-blend-background t)
  ; (kind-icon-default-face 'corfu-default) ; only needed with blend-background
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))


;; esto es muy importante!
;; https://github.com/emacs-lsp/lsp-mode/issues/4454
;; si no, me abre los ficheros js con vue-semantic-server!
;; Is this necessary?
(setq lsp-volar-take-over-mode nil)

;; https://gist.github.com/lateau/5260613
(defun dont-kill-emacs()
  "Disable C-x C-c binding execute kill-emacs."
  (interactive)
  (error (substitute-command-keys "To exit emacs: \\[kill-emacs]")))
(global-set-key (kbd "C-x C-c") 'dont-kill-emacs)
;; esto también es posible pero pongo lo otro para que me advierta de cómo cerrar!
;;(global-unset-key (kbd "C-x C-c"))

;; gnutls.c: [1] Note that the security level of the Diffie-Hellman key exchange has been lowered to 256 bits and this may allow decryption of the session data
;; https://bbs.archlinux.org/viewtopic.php?id72158
;; TODO: delete?
;;(setq gnutls-min-prime-bits 4096)

(which-key-mode 1)

(provide 'ism-misc)
;;; ism-misc.el ends here
