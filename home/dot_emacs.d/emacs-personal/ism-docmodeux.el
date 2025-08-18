;;; cc-doc-mode-ux.el --- Documentation Mode UX Modifications by cchoi

;; sacado de
;; https://github.com/kickingvegas/cclisp/tree/3d0cb6aec717e6a9ec8197d78a20142806165e80
;; con algunos cambios que me gustan más...

;;; Commentary:
;; UX modifications for different Emacs documentation modes.
;; Covers Info, Help, Man, and Shortdoc.

;;; Code:
(require 'info)
(require 'help)
(require 'shortdoc)
(require 'man)
(require 'hl-line)

(defun cc/docview-backward-paragraph ()
  "Move point backward paragraph such that the first line is highlighted.

This function is intended to be used with `hl-line-mode'."
  (interactive)
  (backward-paragraph 2)
  (forward-line))

(defun cc/docview-forward-paragraph ()
  "Move point forward paragraph such that the first line is highlighted.

This function is intended to be used with `hl-line-mode'."
  (interactive)
  (forward-paragraph)
  (forward-line))

;; Info
(add-hook 'Info-mode-hook
          (lambda ()
            ;; Use web-browser history navigation bindings
            (define-key Info-mode-map (kbd "M-[") 'Info-history-back)
            (define-key Info-mode-map (kbd "M-]") 'Info-history-forward)
            ;; Bind p and n to paragraph navigation
            (define-key Info-mode-map (kbd "p") 'cc/docview-backward-paragraph)
            (define-key Info-mode-map (kbd "n") 'cc/docview-forward-paragraph)
            ;; Bind <f1> to help
            ;; (define-key Info-mode-map (kbd "<f1>") 'Info-help)
            ;; Bind M-j, M-k to scrolling up/down line
            (define-key Info-mode-map (kbd "j") 'scroll-up-line)
            (define-key Info-mode-map (kbd "k") 'scroll-down-line)
            ;; Bind h and l to navigate to previous and next nodes
            ;; Bind j and k to navigate to next and previous references
            (define-key Info-mode-map (kbd "M-h") 'Info-prev)
            (define-key Info-mode-map (kbd "M-j") 'Info-next-reference)
            (define-key Info-mode-map (kbd "M-k") 'Info-prev-reference)
            (define-key Info-mode-map (kbd "M-l") 'Info-next)
            ;; Bind / to search
            (define-key Info-mode-map (kbd "/") 'Info-search)
            ;; Set Bookmark
            (define-key Info-mode-map (kbd "B") 'bookmark-set)))

(add-hook 'Info-mode-hook 'hl-line-mode)

;; Help
(add-hook 'help-mode-hook
          (lambda ()
            ;; Use web-browser history navigation bindings
            (define-key help-mode-map (kbd "M-[") 'help-go-back)
            (define-key help-mode-map (kbd "M-]") 'help-go-forward)
            ;; Bind p and n to paragraph navigation
            (define-key help-mode-map (kbd "p") 'cc/docview-backward-paragraph)
            (define-key help-mode-map (kbd "n") 'cc/docview-forward-paragraph)
            ;; Bind <f1> to help
            (define-key help-mode-map (kbd "<f1>") 'describe-mode)
            ;; Bind M-j, M-k to scrolling up/down line
            (define-key help-mode-map (kbd "j") 'scroll-up-line)
            (define-key help-mode-map (kbd "k") 'scroll-down-line)
            ;; Bind j and k to navigate to forward and backward buttons
            (define-key help-mode-map (kbd "M-j") 'forward-button)
            (define-key help-mode-map (kbd "M-k") 'backward-button)))

(add-hook 'help-mode-hook 'hl-line-mode)

;; Shortdoc
(add-hook 'shortdoc-mode-hook
          (lambda ()
            ;; Bind <f1> to help
            (define-key shortdoc-mode-map (kbd "<f1>") 'describe-mode)
            ;; Bind M-j, M-k to scrolling up/down line
            (define-key shortdoc-mode-map (kbd "M-j") 'scroll-up-line)
            (define-key shortdoc-mode-map (kbd "M-k") 'scroll-down-line)
            ;; Bind h and l to navigate to previous and next sections
            ;; Bind j and k to navigate to next and previous
            (define-key shortdoc-mode-map (kbd "h") 'shortdoc-previous-section)
            (define-key shortdoc-mode-map (kbd "j") 'shortdoc-next)
            (define-key shortdoc-mode-map (kbd "k") 'shortdoc-previous)
            (define-key shortdoc-mode-map (kbd "l") 'shortdoc-next-section)))

(add-hook 'shortdoc-mode-hook 'hl-line-mode)

;; Man
(add-hook 'Man-mode-hook
          (lambda ()
            ;; Bind <f1> to help
            (define-key Man-mode-map (kbd "<f1>") 'describe-mode)
            ;; Bind M-j, M-k to scrolling up/down line
            (define-key Man-mode-map (kbd "j") 'scroll-up-line)
            (define-key Man-mode-map (kbd "k") 'scroll-down-line)
            ;; Bind j and k to navigate forward and backward paragraphs
            (define-key Man-mode-map (kbd "M-j") 'cc/docview-forward-paragraph)
            (define-key Man-mode-map (kbd "M-k") 'cc/docview-backward-paragraph)
            ;; Bind K to kill buffer to replace override of default k above
            (define-key Man-mode-map (kbd "K") 'Man-kill)))

(add-hook 'Man-mode-hook 'hl-line-mode)

(provide 'cc-doc-mode-ux)
;;; cc-doc-mode-ux.el ends here
