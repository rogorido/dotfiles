(message "Loading ediff configs...")

(use-package ediff
  :init
  (setq
   ;; Always split nicely for wide screens
   ediff-split-window-function 'split-window-horizontally
   ;; Side by side comparison is easier than vertical split
   ediff-window-setup-function 'ediff-setup-windows-plain
   )
  (defun ediff-copy-both-to-C ()
    (interactive)
    (ediff-copy-diff
     ediff-current-difference nil 'C nil
     (concat
      (ediff-get-region-contents
       ediff-current-difference 'A ediff-control-buffer)
      (ediff-get-region-contents
       ediff-current-difference 'B ediff-control-buffer))))
  (defun add-d-to-ediff-mode-map ()
    (define-key ediff-mode-map "d" 'ediff-copy-both-to-C))
  (add-hook 'ediff-keymap-setup-hook 'add-d-to-ediff-mode-map))

;; see
;; https://github.com/dakrone/eos/blob/118412d321ee84285aa27c70e90c3cddf1967975/eos-git.org#L153
(defhydra eos/hydra-smerge
  (:color red :hint nil
          :pre (smerge-mode 1))
  "
^Move^   ^Keep^   ^Diff^    ^Pair^
------------------------------------------------------
_n_ext   _b_ase   _R_efine  _<_: base-mine
_p_rev   _m_ine   _E_diff   _=_: mine-other
^ ^      _o_ther  _C_ombine _>_: base-other
^ ^      _a_ll    _r_esolve
_q_uit   _RET_: current
"
  ("RET" smerge-keep-current)
  ("C" smerge-combine-with-next)
  ("E" smerge-ediff)
  ("R" smerge-refine)
  ("a" smerge-keep-all)
  ("b" smerge-keep-base)
  ("m" smerge-keep-upper) ;; was smerge-keep-mine
  ("n" smerge-next)
  ("o" smerge-keep-lower) ;; was smerge-keep-other
  ("p" smerge-prev)
  ("r" smerge-resolve)
  ("<" smerge-diff-base-upper) ;; was smerge-diff-base-mine
  ("=" smerge-diff-upper-lower) ;; was smerge-diff-mine-other
  (">" smerge-diff-base-lower) ;; was smerge-diff-base-other
  ("q" nil :color blue))


(provide 'ism-ediff)
;;; ism-ediff.el ends here
