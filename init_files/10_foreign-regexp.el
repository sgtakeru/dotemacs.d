;; ---------------------------------------------
;; foreign-regrexp emacsで普通の正規表現
;;
;; ---------------------------------------------
(require 'foreign-regexp)
(custom-set-variables
 '(foreign-regexp/regexp-type 'ruby) ;; Choose by your preference.
 '(reb-re-syntax 'foreign-regexp)) ;; Tell re-builder to use foreign regexp.
