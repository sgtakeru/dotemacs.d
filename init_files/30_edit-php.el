;; ---------------------------------------------
;; php-mode // elpa
;; ---------------------------------------------
(require 'php-mode)
  ;; 拡張子 .ctp も php-mode で開く
  (add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
  (add-to-list 'auto-mode-alist '("\\.ctp$" . php-mode))
