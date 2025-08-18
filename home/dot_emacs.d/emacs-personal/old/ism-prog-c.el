(message "Programmiereinstellungen für C und C++ werden geladen...")

(setq-default c-basic-offset 4)

;; con esto parece que se consigue que se fontifiquen también
;; algunas cosas más modernas de C++
;; https://github.com/ludwigpacifici/modern-cpp-font-lock
;(use-package modern-cpp-font-lock
;  :ensure t)

(defun ism/--cargar-rtags ()
  (interactive)
  (require 'rtags)
  (rtags-start-process-unless-running)
  (define-key c-mode-base-map (kbd "M-.") 'rtags-find-symbol-at-point)
  (define-key c-mode-base-map (kbd "M-,") 'rtags-location-stack-back)
  (define-key c-mode-base-map (kbd "C-c r <right>") 'rtags-next-diag)
  (define-key c-mode-base-map (kbd "C-c r <left>") 'rtags-previous-diag)
  ;; company completion setup
  (setq rtags-autostart-diagnostics t)
  (rtags-diagnostics)
  (setq rtags-completions-enabled t)
  (setq rtags-display-result-backend 'helm) ;; esto lo he añadido yo... 
 ; (setq rtags-display-result-backend 'ivy) ;; esto lo he añadido yo... 

  (rtags-enable-standard-keybindings)
  ;; use rtags flycheck mode -- clang warnings shown inline
  (require 'flycheck-rtags)
  (flycheck-select-checker 'rtags)
  ;; RTags creates more accurate overlays.
  (setq-local flycheck-highlighting-mode nil)
  (setq-local flycheck-check-syntax-automatically nil)
  ;(cmake-ide-setup) ; esto no me funciona
)

;; Spell check comments in c++ and c common
;(add-hook 'c++-mode-hook  'flyspell-prog-mode)
;(add-hook 'c-mode-common-hook 'flyspell-prog-mode)

(require 'git-gutter)
(add-hook 'c-mode-common-hook 'git-gutter-mode)
(add-hook 'c++-mode-hook 'git-gutter-mode)

(add-hook 'c-mode-common-hook 'display-line-numbers-mode)
(add-hook 'c++-mode-hook 'origami-mode)

(require 'lsp-origami)
(add-hook 'origami-mode-hook #'lsp-origami-mode)

(add-hook 'c++-mode-hook #'ism/--cargar-rtags)

(add-hook 'c++-mode-hook 
          (lambda ()
            (set (make-local-variable 'company-backends) '(company-cmake))
            (add-to-list 'company-backends 'company-capf)
                                        ;              (add-to-list 'company-backends 'company-keywords)
            (add-to-list 'company-backends '(company-rtags company-keywords :separate))
            (set (make-local-variable 'company-idle-delay) 0)
            (set (make-local-variable 'company-minimum-prefix-length) 2)
            ;; esto activa un montón de combinaciones con C-c r [esto está arriba no?]
            ;; (rtags-enable-standard-keybindings)
            ))

(provide 'ism-prog-c)
;;; ism-prog-c.el ends here
