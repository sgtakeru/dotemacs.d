;; ---------------------------------------------
;; Default key bindings
;; ---------------------------------------------

;; C-hは前を削除
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)

;; ヘルプ表示
(global-set-key (kbd "C-x ?") 'help)

(global-set-key (kbd "C-m") 'newline-and-indent)

 ;; Change Font size
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)


 ;; Use regex searches by default.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; Jump to a definition in the current file. (Protip: this is awesome.)
(global-set-key (kbd "C-x C-i") 'imenu)

 ;; Window switching. (C-x o goes to the next window)
;; (windmove-default-keybindings) ;; shift+ion
(global-set-key (kbd "C-x O") (lambda () (interactive) (other-window -1))) ;; back one
(global-set-key (kbd "C-x C-o") (lambda () (interactive) (other-window 2))) ;; forward two
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

;; magit
(global-set-key (kbd "C-c g") 'magit-status)
;; rspec-mode
;; C-c , t / toggle spec <-> target
;; (global-set-key (kbd "C-o") 'mac-input-method-mode)


;; 00_display.el  透過設定
(global-set-key (kbd "C-c t") 'toggle-transparency)
(global-set-key (kbd "C-c C-t") 'transparency)
(global-set-key (kbd "C-<f11>") 'toggle-fullscreen)


;; 01_input-method.el  入力切替
;; (global-set-key (kbd "C-j") 'toggle-input-method)

;; 00_utils.el
(global-set-key "\C-w" 'kill-region-or-backward-kill-word)

;; 10_expand-region
(global-set-key (kbd "C-@") 'er/expand-region)     ;; 拡大
(global-set-key (kbd "C-M-@") 'er/contract-region) ;; 縮小

;; 10_color-moccur_moccur-edit.el
;; グローバルマップにoccur-by-moccurを割り当て
(global-set-key (kbd "M-o") 'occur-by-moccur)


;; 10_undo-tree.el
(global-set-key (kbd "C-M-/") 'undo-tree-visualize)  ;; default C-x u

;; 20_anzu.el
(global-set-key (kbd "M-%") 'anzu-query-replace-regexp)
(global-set-key (kbd "C-M-%") 'anzu-query-replace)
(global-set-key (kbd "C-c r") 'anzu-query-replace-at-cursor-thing)

;; 20_deft.el
(global-set-key (kbd "<f9>") 'deft)

;; 20_direx.el
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)

;; 20_git-gutter.el
(global-set-key (kbd "C-x g") 'git-gutter+-mode) ; Turn on/off in the current buffer
(global-set-key (kbd "C-x G") 'global-git-gutter+-mode) ; Turn on/off globally

;; 20_popup-select-window.el
(global-set-key (kbd "C-x o") 'popup-select-window)

;; 25_org-tree-slide.el
(global-set-key (kbd "<f8>") 'org-tree-slide-mode)
(global-set-key (kbd "S-<f8>") 'org-tree-slide-skip-done-toggle)

;; 25_org.el
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)



;; 20150108 http://www.muskmelon.jp/?page_id=410キー（Mac標準に準拠）
(setq mac-command-key-is-meta nil)
(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'super)
