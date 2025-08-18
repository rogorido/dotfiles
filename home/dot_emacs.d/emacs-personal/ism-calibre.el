(message "Loading calibre settings...")

(use-package calibredb
  :defer t
  :config
  (setq calibredb-root-dir "~/calibre")
  (setq calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir))
  (setq calibredb-id-width 6)
  ;; no lo recomienda con bds muy grandes
  (setq calibredb-format-all-the-icons nil)
  )

(setq calibredb-virtual-library-alist '(
                                        ("Edad moderna" . "edad moderna")
                                        ("Edad moderna-cristianismo" . "edad moderna cristianismo")
                                        ("Georeligión" . "georeligión")
                                        ("Edad Moderna - Georeligión" . "georeligión edad moderna")
      ))

(provide 'ism-calibre)
;;; ism-calibre.el ends here
