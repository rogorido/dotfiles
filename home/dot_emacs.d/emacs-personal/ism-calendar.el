(message "Loading calendar settings...")

(setq calendar-week-start-day 1
          calendar-day-name-array ["Sonntag" "Montag" "Dienstag" "Mittwoch"
                                   "Donnerstag" "Freitag" "Samstag"]
          calendar-month-name-array ["Januar" "Februar" "März" "April" "Mai"
                                     "Juni" "Juli" "August" "September"
                                     "Oktober" "November" "Dezember"])

(add-hook 'calendar-load-hook
              (lambda ()
                (calendar-set-date-style 'european)))

(setq
  calendar-mark-holidays-flag        t
  all-christian-calendar-holidays   t        ;; show christian
;  all-islamic-calendar-holidays     nil      ;; don't show islamic
;  all-hebrew-calendar-holidays      nil      ;; don't show hebrew
  display-time-24hr-format          t        ;; use 24h format
  display-time-day-and-date         nil      ;; don't display time
;  display-time-format               nil      ;;
;  display-time-use-mail-icon        nil      ;; don't show mail icon
  calendar-latitude                 41.65   
  calendar-longitude                -4.72   
  calendar-location-name "Valladolid"
)
; ver abajo porque tengo unas funciones para lo del sunrise/sunset

(setq   holiday-general-holidays nil   ; get rid of too U.S.-centric holidays
        holiday-hebrew-holidays nil    ; get rid of religious holidays
        holiday-islamic-holidays nil   ; get rid of religious holidays
        holiday-oriental-holidays nil  ; get rid of Oriental holidays
        holiday-bahai-holidays nil)     ; get rid of Baha'i holidays

; añado esto de:
; http://www.et.bs.ehu.es/~etpmohej/.emacs_win

(setq calendar-time-display-form
      '(24-hours ":" minutes (and time-zone (concat " (" time-zone ")"))))
(setq calendar-date-display-form
      '((if dayname (concat dayname ", ")) day " " monthname " " year))

(setq solar-n-hemi-seasons
      '("Frühlingsanfang" "Sommeranfang" "Herbstanfang" "Winteranfang"))

(setq holiday-general-holidays
      '((holiday-fixed 1 1 "Neujahr")
        (holiday-fixed 4 23 "Día de CyL")
        (holiday-fixed 5 1 "1. Mai")
        (holiday-fixed 5 13 "San Pedro Regalado")
        (holiday-fixed 10 12 "Hispanidad")
        (holiday-fixed 12 6 "Constitución")
        (holiday-fixed 12 8 "Inmaculada")))

;; Feiertage für Bayern, weitere auskommentiert
(setq holiday-christian-holidays
      '((holiday-float 12 0 -4 "1. Advent" 24)
        (holiday-float 12 0 -3 "2. Advent" 24)
        (holiday-float 12 0 -2 "3. Advent" 24)
        (holiday-float 12 0 -1 "4. Advent" 24)
        (holiday-fixed 12 25 "1. Weihnachtstag")
        (holiday-fixed 12 26 "2. Weihnachtstag")
        (holiday-fixed 1 6 "Heilige Drei Könige")
        (holiday-easter-etc -48 "Rosenmontag")
        ;; (holiday-easter-etc -3 "Gründonnerstag")
        (holiday-easter-etc  -2 "Karfreitag")
        (holiday-easter-etc   0 "Ostersonntag")
        (holiday-easter-etc  +1 "Ostermontag")
        (holiday-easter-etc +39 "Christi Himmelfahrt")
        (holiday-easter-etc +49 "Pfingstsonntag")
        (holiday-easter-etc +50 "Pfingstmontag")
        (holiday-easter-etc +60 "Fronleichnam")
        (holiday-fixed 8 15 "Mariae Himmelfahrt")
        (holiday-fixed 11 1 "Allerheiligen")
        ;; (holiday-float 11 3 1 "Buss- und Bettag" 16)
        (holiday-float 11 0 1 "Totensonntag" 20)))


(provide 'ism-calendar)
;;; ism-calendar.el ends here
