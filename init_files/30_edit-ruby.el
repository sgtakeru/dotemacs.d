;; ---------------------------------------------
;; ruby-mode
;; ---------------------------------------------
(require 'inf-ruby)
;; ;; M-. to jump to the definition of a given method and M-, to jump back.
;; (add-hook 'inf-ruby-mode-hook 'zossima-mode)

(require 'ruby-compilation)

(require 'ruby-mode)
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.irbrc\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.pryrc\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.aprc\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rabl$" . ruby-mode))

;; (defun ruby-mode-hook-ruby-elecrtric ()
;;   (ruby-electric-mode t))
;; (add-hook 'ruby-mode-hook 'ruby-mode-hook-ruby-elecrtric)
;; use irb in buffer
(setq ruby-deep-indent-paren-style nil)
(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

;; ---------------------------------------------
;; rubydb
;; (install-elisp "http://svn.ruby-lang.org/repos/ruby/trunk/misc/rubydb3x.el")
;; M-x rubydb ソースコードにもどり
;; C-x SPC でブレークポイン
;; C-cC-s でステップイン
;; ---------------------------------------------
;; (autoload 'rubydb "rubydb3x" "Run rubydb on program FILE in buffer *gud-FILE*.
;; The directory containing FILE becomes the initial working directory
;; and source-file directory for your debugger.")


;; ;; (install-elisp-from-emacswiki "ruby-block.el")
;; (when (require 'ruby-block nil t)
;;   (setq ruby-block-highlight-toggle t)
;;   (defun ruby-mode-hook-ruby-block()
;;     (ruby-block-mode t))
;;   (add-hook 'ruby-mode-hook 'ruby-mode-hook-ruby-block))


;; ---------------------------------------------
;; ruby-tools
;; rubyの文字列内での拡張
;; C-' 文字列を'に変更
;; C-\" 文字列を"に変更
;; C-: 文字列をシンボルへ
;; C-; 文字列内をクリア
;; # 'ruby-tools-interpolate
;; ---------------------------------------------
(require 'ruby-tools)
