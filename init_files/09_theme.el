;; ---------------------------------------------
;; 色設定
;; ---------------------------------------------

;; terminal上では利用しない
(when window-system
  (require 'color-theme)
  (color-theme-initialize)
  (color-theme-almost-monokai))
  ;; (color-theme-monokai))
  ;; (load-theme 'monokai t)
