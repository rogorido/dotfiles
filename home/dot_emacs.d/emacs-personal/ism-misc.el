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

(provide 'ism-misc)
;;; ism-misc.el ends here
