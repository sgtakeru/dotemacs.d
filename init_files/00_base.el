;; ---------------------------------------------
;; Emacsの動作制御
;; ---------------------------------------------

;; 言語設定
;; (set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)


;; 起動画面を非表示
(setq inhibit-startup-screen t)

;; 最後に改行を追加
(setq require-final-newline t)
(setq mode-require-final-newline t)

;; 行末の空白を表示
(setq-default show-trailing-whitespace t)

;; 保存時にファイル内の行末空白を削除
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; use server-mode
(require 'server)
(unless (server-running-p)
  (server-start))

;; yes-no -> y-p
(fset 'yes-or-no-p 'y-or-n-p)

;; 25MB以上は警告表示
(setq large-file-warning-threshold (* 25 1024 1024))

;; タブはスペースで
(setq-default indent-tabs-mode nil)

;; GCサイズを変更
(setq gc-cons-threshold (* 30 gc-cons-threshold))

;; ログ容量
(setq message-log-max 5000)
(setq enable-recursive-minibuffers t)

;; kill-lineで行末も削除
(setq kill-whole-line 1)

;; 履歴数
(setq history-length 10000)
(setq history-delete-duplicates t)
(setq echo-keystrokes 0.1)

;; ミニバッファの履歴保存
(savehist-mode 1)

;; カーソル場所を保存
(require 'saveplace)
(setq-default save-place t)

;; 終了時に確認
(defadvice save-buffers-kill-emacs
  (before safe-save-buffers-kill-emacs activate)
  "safe-save-buffers-kill-emacs"
  (unless (y-or-n-p "Really exit emacs? ")
    (keyboard-quit)))

;; backup
(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backups"))
            backup-directory-alist))

;; カーソル位置からパスを開く
(ffap-bindings)


;; クリップボードとキルリングを同期させる
(cond (window-system
       (setq x-select-enable-clipboard t)))


;; ミニバッファキャンセル時に入力内容を保存
;; http://d.hatena.ne.jp/rubikitch/20091216/minibuffer
(defadvice abort-recursive-edit (before minibuffer-save activate)
  (when (eq (selected-window) (active-minibuffer-window))
    (add-to-history minibuffer-history-variable (minibuffer-contents))))


;; minibufferにbuffer表示 -> helmを使ってるので使用してない
;; (iswitchb-mode 1)
;; (setq read-buffer-function 'iswitchb-read-buffer)
;; (setq iswitchb-regexp nil)
;; (setq iswitchb-prompt-newbuffer nil)


;; ido
;; (ido-mode 1)
;; (ido-everywhere 1)
