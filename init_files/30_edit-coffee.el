;;--------------------------------------------------------------------------
;; coffee-mode
;; install from melpa
;;--------------------------------------------------------------------------
(when (require 'coffee-mode nil t)
  (setq coffee-tab-width 2)
  (setq coffee-indent-tabs-mode t)
  (add-to-list 'auto-mode-alist '("\\.hamlc$" . coffee-mode))
)
