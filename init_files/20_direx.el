;; ---------------------------------------------
;; direx
;; use(popwin)
;; from melpa
;; ---------------------------------------------
(require 'direx)
(setq direx:leaf-icon "  "
      direx:open-icon "\&#9662; "
      direx:closed-icon "&#9654; ")
(push '(direx:direx-mode :position left :width 25 :dedicated t)
      popwin:special-display-config)
