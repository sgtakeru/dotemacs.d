;; auto-complete-mode:
(require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
(define-key ac-mode-map (kbd "C-,") 'auto-complete)
(ac-config-default)
