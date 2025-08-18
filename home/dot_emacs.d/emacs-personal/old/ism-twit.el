(message "Twitter-Einstellungen werden geladen...")

(add-to-list 'load-path "~/giteando/twittering-mode")
(require 'twittering-mode)

(setq twittering-use-master-password t
      twittering-icon-mode nil 
      twittering-timer-interval 300
      ;; esto muestra cuántas llamadas a la API nos quedan 
      twittering-display-remaining t)

(defun ism/--flyspell-for-twitter ()
  "Activa el diccionario de inglés y flyspell para twitter."
  (interactive)
  (flyspell-mode 1)
  (ispell-change-dictionary "english")
  )

(defun ism/--disable-hl-line-mode-in-twitter ()
    "Deshabilitar el hl-line-mode en twitter"
  (setq-local global-hl-line-mode nil)
  )

(add-hook 'twittering-edit-mode-hook 'ism/--flyspell-for-twitter)
(add-hook 'twittering-mode-hook 'ism/--disable-hl-line-mode-in-twitter)

(provide 'ism-twit)
;;; ism-twit.el ends here
