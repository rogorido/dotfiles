(message "Loading other settings...")

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


;; Other packages
(add-to-list 'load-path "~/giteando/emacs-request/")
(add-to-list 'load-path "~/giteando/anki-editor/")
;(setq request-log-level 'debug)
;(setq request-log-level 'error)

;; esto parece que deeshabilita completamente lo de vc-mode
;; (setq vc-handled-backends nil)

;(require 'keychain-environment)
(keychain-refresh-environment)
(defalias 'cargar-keychain 'keychain-refresh-environment)


(provide 'ism-misc)
;;; ism-misc.el ends here
