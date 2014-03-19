;; ---------------------------------------------
;; highlight-indentation
;; install from melpa
;; ---------------------------------------------
(require 'highlight-indentation)
;; (set-face-background 'highlight-indentation-face "#e3e3d3")
;; (set-face-background 'highlight-indentation-current-column-face "#c3b3b3")
(add-hook 'coffee-mode-hook 'highlight-indentation-current-column-mode)
(add-hook 'scss-mode-hook 'highlight-indentation-current-column-mode)
(add-hook 'ruby-mode-hook 'highlight-indentation-current-column-mode)
(add-hook 'html-mode-hook 'highlight-indentation-current-column-mode)
