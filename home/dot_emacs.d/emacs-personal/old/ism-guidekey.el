(message "GuideKey-Einstellungen werden geladen...")

(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "M-s" "M-s h" "C-c h" "s-p" "C-x C-k"))
(guide-key-mode 1)  ; Enable guide-key-mode
(setq guide-key/idle-delay 0.1)
(setq guide-key/popup-window-position 'bottom)

;; Esto por ahora es una prueba...
;;(setq guide-key/highlight-command-regexp "rectangle")
(setq guide-key/highlight-command-regexp
      '(("rectangle" . font-lock-type-face)
      ("register" . font-lock-keyword-face)
      ("bookmark" . font-lock-warning-face)))

(defun guide-key/my-hook-function-for-org-mode ()
  ;; no sé si realmente hay que poner todas las combinaciones que tengo
  ;; arriba, pero si solo pongo la de C-c C-x el asunto sólo funciona con esa...
  (guide-key/add-local-guide-key-sequence "C-c C-x")
  (guide-key/add-local-highlight-command-regexp "org-"))
(add-hook 'org-mode-hook 'guide-key/my-hook-function-for-org-mode)

(defun guide-key/my-hook-function-for-prog-mode ()
  (guide-key/add-local-guide-key-sequence "C-c r")
  (guide-key/add-local-highlight-command-regexp "rtags-"))
(add-hook 'c-mode-common-hook 'guide-key/my-hook-function-for-prog-mode)

(provide 'ism-guidekey)
