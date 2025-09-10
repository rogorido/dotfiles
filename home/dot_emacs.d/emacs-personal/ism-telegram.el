(message "Loading telegram...")

(add-to-list 'load-path "~/giteando/telega.el")
(require 'telega)

(defun ism/--telega-hook ()
    "Hook for telega chat. Cape config for telega. We need emojis! No hl-line!"
  (setq-local global-hl-line-mode nil)
  (setq-local completion-at-point-functions
             '(cape-dict cape-emoji))
  (define-key telega-chat-mode-map (kbd "C-l") 'recenter-top-bottom)
  )

(add-hook 'telega-chat-mode-hook 'ism/--telega-hook)
(add-hook 'telega-root-mode-hook 'hl-line-mode)

;; (setq telega-server-verbosity 1)

;; este símbolo marca que un mensaje ha salido bien pero el original no
;; se distingue mucho del símbolo de que la otra persona lo ha visto,
;; por eso lo cambio...
(setq telega-symbol-checkmark "."
      telega-user-use-avatars nil
      telega-root-show-avatars nil)

(define-key telega-root-mode-map (kbd "m") 'telega-chat-with)
(define-key global-map (kbd "C-c t") telega-prefix-map)

(telega-notifications-mode t)

(require 'ol-telega)

(provide 'ism-telegram)
;;; ism-telegram.el ends here
