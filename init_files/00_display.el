;; ---------------------------------------------
;; 画面の表示設定
;; ---------------------------------------------

;; ツールバー削除
(tool-bar-mode -1)

;; blink-cursor
(blink-cursor-mode t)
(setq-default cursor-type '(hbar . 2))

;; hl-line-mode
(defface my-hl-line-face
  ;;  背景が dark ならば 背景を黒に.
  '((((class color) (background dark))
     (:background "#000050" t))
    ;; 背景が light ならば背景色を緑に
    (((class color) (background light))
     ;; (:background "LightGoldenrodYellow" t))
     (:background "#FEF4F4" t))
    (t (:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)
(global-hl-line-mode 1)


;; カッコを強調
(setq show-paren-delay 0)
(show-paren-mode 1)
(setq show-paren-style 'expression)                    ; カッコ内の色も変更
(set-face-background 'show-paren-match-face nil)       ; カッコ内のフェイス
(set-face-underline-p 'show-paren-match-face "gold3") ; カッコ内のフェイス


;; do not show dialog box
(setq use-dialog-box nil)


;; 行番号の表示
(global-linum-mode)

;; メニューバーにファイルをパスを表示
(setq frame-title-format
      (format "%%f -emacs@%s" (system-name)))


;; 透過設定
;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
(set-frame-parameter (selected-frame) 'alpha '(95 80))
(add-to-list 'default-frame-alist '(alpha 95 80))

(defun toggle-transparency ()
  (interactive)
  (if (/=
       (cadr (frame-parameter nil 'alpha))
       100)
      (set-frame-parameter nil 'alpha '(100 100))
    (set-frame-parameter nil 'alpha '(90 50))))

;; Set transparency of emacs
(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))

;; fullscreen
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                  'fullboth)))))


;; ---------------------------------------------
;; 折り返し表示ON/OFF
;; ---------------------------------------------
(defun toggle-truncate-lines ()
  "折り返し表示をトグル動作します."
  (interactive)
  (if truncate-lines
      (setq truncate-lines nil)
    (setq truncate-lines t))
  (recenter))


;; ---------------------------------------------
;; バッファ名を見やすく
;; ---------------------------------------------
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")


;; ---------------------------------------------
;; モードライン
;; ---------------------------------------------

;; カーソルがある関数名をモードラインに表示
(which-function-mode 1)

;; モードラインに時間
;; (display-time)

;; モードラインに行ナンバー
(line-number-mode t)
(column-number-mode t)

;; region選択時に強調表示
(transient-mark-mode t)
