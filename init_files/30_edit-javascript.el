;; ---------------------------------------------
;; js
;; ---------------------------------------------
;; (require 'javascript-mode)
;; (setq javascript-indent-level 2)
;; (setq javascript-expr-indent-offset 2)

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js2-mode-hook
          '(lambda ()
             (setq js2-basic-offset 2)))
