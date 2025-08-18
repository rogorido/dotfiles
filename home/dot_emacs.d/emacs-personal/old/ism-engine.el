(message "Engines werden geladen...")

;; de aquí
;; https://github.com/hrs/engine-mode

(require 'engine-mode)
(engine-mode t)

;; (defengine duckduckgo
;;   "https://duckduckgo.com/?q=%s"
;;   :keybinding "d")

(defengine google
  "http://www.google.com/search?ie=utf-8&oe=utf-8&q=%s"
  :keybinding "g")

(defengine wikipedia
  "http://www.wikipedia.org/search-redirect.php?language=en&go=Go&search=%s"
  :keybinding "w"
  :docstring "Searchin' the wikis.")

(defengine wiktionary
  "https://www.wikipedia.org/search-redirect.php?family=wiktionary&language=en&go=Go&search=%s")

(defengine wordreference
  "http://www.wordreference.com/es/translation.asp?tranword=%s"
  :keybinding "W")

(defengine wordreference-sinonimos
  "http://www.wordreference.com/sinonimos/%s"
  :keybinding "S")

(defengine dictleo-de-eng
  "https://dict.leo.org/german-english/%s"
  :keybinding "d")

(defengine collocations
  "http://www.freecollocation.com/search?word=%s"
  :keybinding "c")

(defengine synonyms  ;; english 
  "https://en.oxforddictionaries.com/thesaurus/%s"
  :keybinding "s")

(defengine qt
  "http://doc.qt.io/qt-5/%s.html"
  ;;  "http://doc.qt.io/qt-5/search-results.html?q=%s"
  :keybinding "q"
  ;; nos obliga a ponerlo en minúscula
  ;; en teoría debería fucniona esto pero me da un error
  ;;:term-transformation-hook 'downcase)
  :term-transformation-hook (lambda (term) (downcase term))
  )

(provide 'ism-engine)
;;; ism-engine.el ends here
