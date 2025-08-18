(message "pabbrev wird geladen...")

(load "pabbrev")
(require 'pabbrev)
(global-pabbrev-mode)
; lo deshabilita en buffers que son read-only
; porque al parecer no funciona en ese tipo de buffer
(setq pabbrev-read-only-error nil)

; para que no esté dando la paliza...
(pabbrev-shut-up)

; esto no entiendo del todo para qué es 
; pero tal vez haga que vaya más rápido...
(setq pabbrev-scavenge-on-large-move nil)

(provide 'ism-pabbrev)
