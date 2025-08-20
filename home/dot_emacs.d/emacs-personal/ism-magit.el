(message "Loading magit configs...")

(use-package magit
  :ensure t
  :defer t
  :bind (("C-x g" . magit-status)
         ("C-x C-g" . magit-dispatch)
         ("C-c f" . magit-file-dispatch))
  :init
  (setq magit-auto-revert-mode nil)
  ;; not clear!?
  (setq magit-view-git-manual-method 'man)
  ;; atención: sorprendentemete la info que aparece en la modeline (Git-master)
  ;; realmente no la controla magit [??] y por tanto no parece que la actualice bien
  ;; Parece ser que hay esta solución, que puede tener consecuencias de performance
  (setq auto-revert-check-vc-info t)
  ;;:hook (after-init .  (setq magit-define-global-key-bindings 'recommended))

    (setq magit-repository-directories
          '(("~/geschichte/web/code/apis" . 1)
            ("~/geschichte/web/webprojects/publicsites" . 1)))
  :config
    ;; https://github.com/magit/magit/discussions/5063#discussioncomment-7809087
  (let ((h 'magit-status-sections-hook))
    (remove-hook h 'magit-insert-unpushed-to-upstream-or-recent)
    (add-hook h 'magit-insert-unpushed-to-upstream 100)
    (add-hook h 'magit-insert-recent-commits 100))

  ;; y por eso lo que se puede hacer es deshabilitarla completamente
  ;; (setq vc-handled-backends nil)

  ;; Show icons for files in the Magit status and other buffers.
  (with-eval-after-load 'magit
    (setq magit-format-file-function #'magit-format-file-all-the-icons))
  )

(use-package forge
  :after magit
  :config
  (defun my/disable-auto-fill-enable-visual-line ()
    "Disable `auto-fill-mode` and enable `visual-line-mode`."
    (auto-fill-mode -1)
    (visual-line-mode 1))

  (add-hook 'forge-post-mode-hook #'my/disable-auto-fill-enable-visual-line))

;;
;; TODO: I have to change the keybindings!
;;
;; (use-package blamer
;;   :after magit
;;   :bind (("C-c g i" . blamer-show-commit-info)
;;          ("C-c g b" . blamer-show-posframe-commit-info))
;;   :defer 20
;;   :custom
;;   (blamer-idle-time                 0.3)
;;   (blamer-min-offset                4)
;;   (blamer-max-commit-message-length 100)
;;   (blamer-datetime-formatter        "[%s]")
;;   (blamer-commit-formatter          " ● %s")
;;   :custom-face
;;   (blamer-face ((t :foreground "#7aa2cf"
;;                     :background nil
;;                     :height 1
;;                     :italic nil))))


;;(use-package magit-todos
;;  :after magit
;;  :config (magit-todos-mode 1))

(provide 'ism-magit)
;;; ism-magit.el ends here
