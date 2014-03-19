;; ---------------------------------------------
;; popupwin
;; from melpa
;; ---------------------------------------------
(require 'popwin)
(popwin-mode 1)
(setq popwin:close-popup-window-timer-interval 0.05)
(push '("\*helm" :regexp t :height 0.3) popwin:special-display-config)
(push '(dired-mode :position top)  popwin:special-display-config)
(push '("\*ag" :regexp t :height 0.5) popwin:special-display-config)
(push '("\*magit" :regexp t :height 0.5) popwin:special-display-config)
(push '("COMMIT_EDITMSG" :position right :width 0.5) popwin:special-display-config)
(push '("20[0-9]\{6\}" :regexp t :height 0.5) popwin:special-display-config)
