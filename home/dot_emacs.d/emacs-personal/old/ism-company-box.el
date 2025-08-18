(message "Icons für company werden geladen...")

;; esto lo tengo de:
;; https://ladicle.com/post/config/
(use-package company-box
  :diminish
  :hook (company-mode . company-box-mode)

  :init
  (setq company-box-icons-alist 'company-box-icons-all-the-icons)

  :config
  (setq company-box-backends-colors nil)
  (setq company-box-show-single-candidate t)
  (setq company-box-max-candidates 50)
  
  (defun company-box-icons--elisp (candidate)
    (when (derived-mode-p 'emacs-lisp-mode)
      (let ((sym (intern candidate)))
        (cond ((fboundp sym) 'Function)
              ((featurep sym) 'Module)
              ((facep sym) 'Color)
              ((boundp sym) 'Variable)
              ((symbolp sym) 'Text)
              (t . nil)))))

  (with-eval-after-load 'all-the-icons
    (declare-function all-the-icons-faicon 'all-the-icons)
    (declare-function all-the-icons-fileicon 'all-the-icons)
    (declare-function all-the-icons-material 'all-the-icons)
    (declare-function all-the-icons-octicon 'all-the-icons)
    (setq company-box-icons-all-the-icons
          `((Unknown . ,(all-the-icons-material "find_in_page" :height 0.7 :v-adjust -0.15))
            (Text . ,(all-the-icons-faicon "book" :height 0.68 :v-adjust -0.15))
            (Method . ,(all-the-icons-faicon "cube" :height 0.7 :v-adjust -0.05 :face 'font-lock-constant-face))
            (Function . ,(all-the-icons-faicon "cube" :height 0.7 :v-adjust -0.05 :face 'font-lock-constant-face))
            (Constructor . ,(all-the-icons-faicon "cube" :height 0.7 :v-adjust -0.05 :face 'font-lock-constant-face))
            (Field . ,(all-the-icons-faicon "tags" :height 0.65 :v-adjust -0.15 :face 'font-lock-warning-face))
            (Variable . ,(all-the-icons-faicon "tag" :height 0.7 :v-adjust -0.05 :face 'font-lock-warning-face))
            (Class . ,(all-the-icons-faicon "clone" :height 0.65 :v-adjust 0.01 :face 'font-lock-constant-face))
            (Interface . ,(all-the-icons-faicon "clone" :height 0.65 :v-adjust 0.01))
            (Module . ,(all-the-icons-octicon "package" :height 0.7 :v-adjust -0.15))
            (Property . ,(all-the-icons-octicon "package" :height 0.7 :v-adjust -0.05 :face 'font-lock-warning-face)) ;; Golang module
            (Unit . ,(all-the-icons-material "settings_system_daydream" :height 0.7 :v-adjust -0.15))
            (Value . ,(all-the-icons-material "format_align_right" :height 0.7 :v-adjust -0.15 :face 'font-lock-constant-face))
            (Enum . ,(all-the-icons-material "storage" :height 0.7 :v-adjust -0.15 :face 'all-the-icons-orange))
            (Keyword . ,(all-the-icons-material "filter_center_focus" :height 0.7 :v-adjust -0.15))
            (Snippet . ,(all-the-icons-faicon "code" :height 0.7 :v-adjust 0.02 :face 'font-lock-variable-name-face))
            (Color . ,(all-the-icons-material "palette" :height 0.7 :v-adjust -0.15))
            (File . ,(all-the-icons-faicon "file-o" :height 0.7 :v-adjust -0.05))
            (Reference . ,(all-the-icons-material "collections_bookmark" :height 0.7 :v-adjust -0.15))
            (Folder . ,(all-the-icons-octicon "file-directory" :height 0.7 :v-adjust -0.05))
            (EnumMember . ,(all-the-icons-material "format_align_right" :height 0.7 :v-adjust -0.15 :face 'all-the-icons-blueb))
            (Constant . ,(all-the-icons-faicon "tag" :height 0.7 :v-adjust -0.05))
            (Struct . ,(all-the-icons-faicon "clone" :height 0.65 :v-adjust 0.01 :face 'font-lock-constant-face))
            (Event . ,(all-the-icons-faicon "bolt" :height 0.7 :v-adjust -0.05 :face 'all-the-icons-orange))
            (Operator . ,(all-the-icons-fileicon "typedoc" :height 0.65 :v-adjust 0.05))
            (TypeParameter . ,(all-the-icons-faicon "hashtag" :height 0.65 :v-adjust 0.07 :face 'font-lock-const-face))
            (Template . ,(all-the-icons-faicon "code" :height 0.7 :v-adjust 0.02 :face 'font-lock-variable-name-face))))
    )
  )


;; esta es otra que he visto por ahí....
 ;; (use-package company-box
 ;;    :defer    t
 ;;    :straight t
 ;;    :after (all-the-icons company)
 ;;    :init
 ;;    (setq company-box-icons-alist 'company-box-icons-all-the-icons)
 ;;    :ghook 'company-mode-hook
 ;;    :config
 ;;    (setq company-box-backends-colors '((company-lsp      . "#e0f9b5")
 ;;                                        (company-elisp    . "#e0f9b5")
 ;;                                        (company-files    . "#ffffc2")
 ;;                                        (company-keywords . "#ffa5a5")
 ;;                                        (company-capf     . "#bfcfff")
 ;;                                        (company-dabbrev  . "#bfcfff")))
 ;;    (setq company-box-icons-unknown (concat (all-the-icons-material "find_in_page") " "))
 ;;    (setq company-box-icons-elisp
 ;;          (list
 ;;           (concat (all-the-icons-faicon "tag") " ")
 ;;           (concat (all-the-icons-faicon "cog") " ")
 ;;           (concat (all-the-icons-faicon "cube") " ")
 ;;           (concat (all-the-icons-material "color_lens") " ")))
 ;;    (setq company-box-icons-yasnippet (concat (all-the-icons-faicon "bookmark") " "))
 ;;    (setq company-box-icons-lsp
 ;;          `((1 .  ,(concat (all-the-icons-faicon   "text-height")    " ")) ;; Text
 ;;            (2 .  ,(concat (all-the-icons-faicon   "tags")           " ")) ;; Method
 ;;            (3 .  ,(concat (all-the-icons-faicon   "tag" )           " ")) ;; Function
 ;;            (4 .  ,(concat (all-the-icons-faicon   "tag" )           " ")) ;; Constructor
 ;;            (5 .  ,(concat (all-the-icons-faicon   "cog" )           " ")) ;; Field
 ;;            (6 .  ,(concat (all-the-icons-faicon   "cog" )           " ")) ;; Variable
 ;;            (7 .  ,(concat (all-the-icons-faicon   "cube")           " ")) ;; Class
 ;;            (8 .  ,(concat (all-the-icons-faicon   "cube")           " ")) ;; Interface
 ;;            (9 .  ,(concat (all-the-icons-faicon   "cube")           " ")) ;; Module
 ;;            (10 . ,(concat (all-the-icons-faicon   "cog" )           " ")) ;; Property
 ;;            (11 . ,(concat (all-the-icons-material "settings_system_daydream") " ")) ;; Unit
 ;;            (12 . ,(concat (all-the-icons-faicon   "cog" )           " ")) ;; Value
 ;;            (13 . ,(concat (all-the-icons-material "storage")        " ")) ;; Enum
 ;;            (14 . ,(concat (all-the-icons-material "closed_caption") " ")) ;; Keyword
 ;;            (15 . ,(concat (all-the-icons-faicon   "bookmark")       " ")) ;; Snippet
 ;;            (16 . ,(concat (all-the-icons-material "color_lens")     " ")) ;; Color
 ;;            (17 . ,(concat (all-the-icons-faicon   "file-text-o")    " ")) ;; File
 ;;            (18 . ,(concat (all-the-icons-material "refresh")        " ")) ;; Reference
 ;;            (19 . ,(concat (all-the-icons-faicon   "folder-open")    " ")) ;; Folder
 ;;            (20 . ,(concat (all-the-icons-material "closed_caption") " ")) ;; EnumMember
 ;;            (21 . ,(concat (all-the-icons-faicon   "square")         " ")) ;; Constant
 ;;            (22 . ,(concat (all-the-icons-faicon   "cube")           " ")) ;; Struct
 ;;            (23 . ,(concat (all-the-icons-faicon   "calendar")       " ")) ;; Event
 ;;            (24 . ,(concat (all-the-icons-faicon   "square-o")       " ")) ;; Operator
 ;;            (25 . ,(concat (all-the-icons-faicon   "arrows")         " "))) ;; TypeParameter
 ;;          ))


;; esto es otra configuración que tenía
;; ;; With use-package:
;; (use-package company-box
;;   :hook (company-mode . company-box-mode))

;; (setq company-box-icons-unknown 'fa_question_circle)

;; (setq company-box-icons-elisp
;;    '((fa_tag :face font-lock-function-name-face) ;; Function
;;      (fa_cog :face font-lock-variable-name-face) ;; Variable
;;      (fa_cube :face font-lock-constant-face) ;; Feature
;;      (md_color_lens :face font-lock-doc-face))) ;; Face

;; (setq company-box-icons-yasnippet 'fa_bookmark)

;; (setq company-box-icons-lsp
;;       '((1 . fa_text_height) ;; Text
;;         (2 . (fa_tags :face font-lock-function-name-face)) ;; Method
;;         (3 . (fa_tag :face font-lock-function-name-face)) ;; Function
;;         (4 . (fa_tag :face font-lock-function-name-face)) ;; Constructor
;;         (5 . (fa_cog :foreground "#FF9800")) ;; Field
;;         (6 . (fa_cog :foreground "#FF9800")) ;; Variable
;;         (7 . (fa_cube :foreground "#7C4DFF")) ;; Class
;;         (8 . (fa_cube :foreground "#7C4DFF")) ;; Interface
;;         (9 . (fa_cube :foreground "#7C4DFF")) ;; Module
;;         (10 . (fa_cog :foreground "#FF9800")) ;; Property
;;         (11 . md_settings_system_daydream) ;; Unit
;;         (12 . (fa_cog :foreground "#FF9800")) ;; Value
;;         (13 . (md_storage :face font-lock-type-face)) ;; Enum
;;         (14 . (md_closed_caption :foreground "#009688")) ;; Keyword
;;         (15 . md_closed_caption) ;; Snippet
;;         (16 . (md_color_lens :face font-lock-doc-face)) ;; Color
;;         (17 . fa_file_text_o) ;; File
;;         (18 . md_refresh) ;; Reference
;;         (19 . fa_folder_open) ;; Folder
;;         (20 . (md_closed_caption :foreground "#009688")) ;; EnumMember
;;         (21 . (fa_square :face font-lock-constant-face)) ;; Constant
;;         (22 . (fa_cube :face font-lock-type-face)) ;; Struct
;;         (23 . fa_calendar) ;; Event
;;         (24 . fa_square_o) ;; Operator
;;         (25 . fa_arrows)) ;; TypeParameter
;;       )

(provide 'ism-company-box)

;;; ism-company-box.el ends here
