;; ---------------------------------------------
;; popup-select-window
;; from http://www.emacswiki.org/emacs/popup-select-window.el
;; ---------------------------------------------
(require 'popup)
(require 'popup-select-window)
(setq popup-select-window-popup-windows 3)  ;; バッファが3位上はポップアップする(デフォルトの設定)
(setq popup-select-window-window-highlight-face '(:foreground "white" :background "Brown"))
