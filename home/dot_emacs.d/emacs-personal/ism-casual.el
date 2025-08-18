(message "Loading causal settings...")

(use-package casual
  :ensure t
  :bind (:map calc-mode-map ("C-o" . 'casual-calc-tmenu)))

(require 'casual-dired) ; optional if using autoloaded menu
(keymap-set dired-mode-map "C-o" #'casual-dired-tmenu)
(keymap-set dired-mode-map "s" #'casual-dired-sort-by-tmenu) ; optional
;; (keymap-set dired-mode-map "/" #'casual-dired-search-replace-tmenu) ; optional

(require 'casual-agenda) ; optional if using autoloaded menu
(keymap-set org-agenda-mode-map "C-o" #'casual-agenda-tmenu)

(require 'casual-isearch) ; optional if using autoloaded menu
(keymap-set isearch-mode-map "C-o" #'casual-isearch-tmenu)

(require 'casual-ibuffer) ; optional if using autoloaded menu
(keymap-set ibuffer-mode-map "C-o" #'casual-ibuffer-tmenu)
(keymap-set ibuffer-mode-map "F" #'casual-ibuffer-filter-tmenu)
(keymap-set ibuffer-mode-map "s" #'casual-ibuffer-sortby-tmenu)

(require 'casual-bookmarks) ; optional if using autoloaded menu
(keymap-set bookmark-bmenu-mode-map "C-o" #'casual-bookmarks-tmenu)
;; Use these keybindings to configure bookmark list to be consistent
;; with keybindings used by Casual Bookmarks.
(keymap-set bookmark-bmenu-mode-map "J" #'bookmark-jump)

(require 'casual-info) ; optional if using autoloaded menu
(keymap-set Info-mode-map "C-o" #'casual-info-tmenu)


(provide 'ism-casual)
;;; ism-casual.el ends here
