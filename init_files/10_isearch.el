;; ---------------------------------------------
;; EX isearch
;;[[http://stackoverflow.com/questions/4471835/emacs-dired-mode-and-isearch][Emacs dired mode and Isearch - Stack Overflow]]
;; 大体の挙動は問題ない。しかし、C-sで検索中にC-aを押下で、その時の
;; カーソルにあるファイルを開いてしまう。
;; ---------------------------------------------
;; (add-hook 'isearch-mode-end-hook
;;           (lambda ()
;;             (when (and (eq major-mode 'dired-mode)
;;                        (eq last-input-event ?\r)
;;                        (not isearch-mode-end-hook-quit))
;;               (dired-find-file))))
