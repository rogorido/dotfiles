(message "Loading my dired settings...")

;; esto es de:
;; https://github.com/Fuco1/dired-hacks
(require 'dired-filter)
;(require 'dired-rainbow)
;(require 'dired-ranger)
;;(require 'dired-hacks-utils)

(setq dired-recursive-copies 'always
      dired-recursive-deletes 'top
      dired-dwim-target t
      dired-omit-files (concat dired-omit-files "\\|\\.out$\\|\\.log$\\|\\.aux$\\|\\.nav$\\|\\.fls$\\|^\\..+$")
      ;; dired-actual-switches "-la"
      dired-listing-switches "-lah --group-directories-first"
      ls-lisp-ignore-case t)

; con esto es posible abrir directorios en dired
; con a sin que abra un nuevo puto frame...
;(put 'dired-find-alternate-file 'disabled nil)
;(toggle-dired-find-file-reuse-dir 1)

(setq delete-by-moving-to-trash t
      trash-directory "~/.Trash/emacs")

;; iluminar la línea de dired
;; con ( se quitan/ponen los detalles
;; e para editar 
(add-hook 'dired-mode-hook
          (lambda ()
	    (hl-line-mode 1)
	    (dired-hide-details-mode)
	    (define-key dired-mode-map "e" 'wdired-change-to-wdired-mode)
            (dired-omit-mode)))

;; use C-c C-m C-a to add attachments
(require 'gnus-dired)
(add-hook 'dired-mode-hook #'turn-on-gnus-dired-mode)

;; pulsando ! usa estas aplicaciones para abrir estas extensiones
(setq dired-guess-shell-alist-user
        '(("\\.xls\\'" "soffice ? ;&")
          ("\\.ods\\'" "soffice ? ;&")
          ("\\.odt\\'" "soffice ? ;&")
          ("\\.doc\\'" "soffice ? ;&")
          ("\\.docx\\'" "soffice ? ;&")
	  ("\\.avi\\'" "mpv ? ;&")
	  ("\\.mp4\\'" "mpv ? ;&")
	  ("\\.mkv\\'" "mpv ? ;&")
	  ("\\.wmv\\'" "mpv ? ;&")
	  ("\\.webm\\'" "mpv ? ;&")
	  ("\\.ogv\\'" "mpv ? ;&")
	  ("\\.mpg\\'" "mpv ? ;&")
	  ("\\.mp3\\'" "mpv ? ;&")
	  ("\\.ogg\\'" "mpv ? ;&")
	  ("\\.zip\\'" "7z x ? ;&")
	  ("\\.rar\\'" "7z x ? ;&")
	  ("\\.7z\\'" "7z x ? ;&")
	  ("\\.tar.gz\\'" "tar xvf ? ;&")
	  ("\\.tar.bz\\'" "tar xvf ? ;&")
	  ("\\.epub\\'" "foliate ? ;&")
	  ("\\.pdf\\'" "zathura ? ;&")
	  ("\\.pdf\\'" "atril ? ;&")))

(eval-after-load 'wdired
  '(setq wdired-allow-to-change-permissions t
         wdired-confirm-overwrite t
	 wdired-use-interactive-rename t))

(define-key dired-mode-map (kbd "<tab>") 'dired-subtree-toggle)

(provide 'ism-dired)
;;; ism-dired.el ends here
