(message "Origami-Einstellungen werden geladen...")

;; https://github.com/gregsexton/origami.el
(require 'origami)

(define-key origami-mode-map (kbd "C-c o t") 'origami-toggle-node)
(define-key origami-mode-map (kbd "C-c o r") 'origami-reset)
(define-key origami-mode-map (kbd "C-c o T") 'origami-toggle-all-nodes)
(define-key origami-mode-map (kbd "C-c o s") 'origami-show-only-node)

(provide 'ism-origami)
