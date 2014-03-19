;; ---------------------------------------------
;; moz
;; ---------------------------------------------
(when (require 'moz nil t)
  (autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)
  (moz-minor-mode t)

  (defun moz-send-message (moz-command)
    (comint-send-string
     (inferior-moz-process)
     (concat moz-repl-name ".pushenv('printPrompt', 'inputMode'); "
             moz-repl-name ".setenv('inputMode', 'line'); "
             moz-repl-name ".setenv('printPrompt', false); undefined; "))
    (comint-send-string
     (inferior-moz-process)
     (concat moz-command
             moz-repl-name ".popenv('inputMode', 'printPrompt'); undefined;\n")))

  (defun moz-scrolldown ()
    (interactive)
    (moz-send-message "goDoCommand('cmd_scrollLineDown');\n")) ; 下スクロール
  (global-set-key (kbd "C-M-n") 'moz-scrolldown)

  (defun moz-scrollup ()
    (interactive)
    (moz-send-message "goDoCommand('cmd_scrollLineUp');\n")) ; 上スクロール
  (global-set-key (kbd "C-M-p") 'moz-scrollup)

  (defun moz-reload ()
    (interactive)
    (moz-send-message "BrowserReload();\n")) ; reload
  (global-set-key (kbd "C-M-'") 'moz-reload)



  ;; http://blogs.openaether.org/?p=236
  (defun jk/moz-get (attr)
    (comint-send-string (inferior-moz-process) attr)
    ;; try to give the repl a chance to respond
    (sleep-for 0 100))
  (defun jk/moz-get-current-url ()
    (interactive)
    (jk/moz-get "repl._workContext.content.location.href"))

  (defun jk/moz-get-current-title ()
    (interactive)
    (jk/moz-get "repl._workContext.content.document.title"))
  (defun jk/moz-get-current (moz-fun)
    (funcall moz-fun)
    ;; doesn't work if repl takes too long to output string
    (save-excursion
      (set-buffer (process-buffer (inferior-moz-process)))
      (goto-char (point-max))
      (previous-line)
      (setq jk/moz-current (buffer-substring-no-properties
                            (+ (point-at-bol) (length moz-repl-name) 3)
                            (- (point-at-eol) 1))))
    (message "%s" jk/moz-current)
    jk/moz-current
    )
  (defun jk/moz-url ()
    (interactive)
    (jk/moz-get-current 'jk/moz-get-current-url)
    )

  (defun jk/moz-title ()
    (interactive)
    (jk/moz-get-current 'jk/moz-get-current-title)
    )
  )
