;; ---------------------------------------------
;; Emacs Mac Port setting
;; ---------------------------------------------
(mac-auto-ascii-mode t)

;; ---------------------------------------------
;; inputmethod for macosx
;; ---------------------------------------------
(setq default-input-method "MacOSX")
;; 24.4にしたらエラーになった。
;; カーソルの色
;; (mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" 'title "あ")
;; (mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" 'cursor-color "red")
;; (mac-set-input-method-parameter "com.google.inputmethod.Japanese.Roman" 'cursor-color "cyan"))

;; http://qiita.com/takaxp/items/a86ee2aacb27c7c3a902

(defvar mac-win-last-ime-status 'off) ;; {'off|'on}
(defun mac-win-save-last-ime-status ()
  (setq mac-win-last-ime-status
        (if (string-match "\\.\\(Roman\\|US\\)$" (mac-input-source))
            'off 'on)))

(defun mac-win-restore-ime ()
  (when (and mac-auto-ascii-mode (eq mac-win-last-ime-status 'on))
    (mac-select-input-source
     "com.google.inputmethod.Japanese.base"))) ;; Google IME 以外は要修正

(defun advice:mac-auto-ascii-setup-input-source (&optional _prompt)
  "Extension to store IME status"
  (mac-win-save-last-ime-status))
(advice-add 'mac-auto-ascii-setup-input-source :before
            #'advice:mac-auto-ascii-setup-input-source)

(defun mac-win-restore-ime-target-commands ()
  (when (and mac-auto-ascii-mode
             (eq mac-win-last-ime-status 'on))
    (mapc (lambda (command)
            (when (string-match
                   (format "^%s" command) (format "%s" this-command))
              (mac-select-input-source
               "com.google.inputmethod.Japanese.base"))) ;; Google IME 以外は要修正
          mac-win-target-commands)))
(add-hook 'pre-command-hook 'mac-win-restore-ime-target-commands)

;; M-x でのコマンド選択でもIMEを戻せる．
;; ただし，移動先で q が効かないことがある（要改善）
(add-hook 'minibuffer-setup-hook 'mac-win-save-last-ime-status)
(add-hook 'minibuffer-exit-hook 'mac-win-restore-ime)


;; 自動で ASCII入力から日本語入力に引き戻したい関数（デフォルト設定）
(defvar mac-win-target-commands
  '(find-file save-buffer other-window delete-window split-window))


;; 自動で ASCII入力から日本語入力に引き戻したい関数（追加設定）
;; 指定の関数名でマッチさせるので要注意（ my: を追加すれば，my:a, my:b らも対象になる）

;; バッファリストを見るとき
(add-to-list 'mac-win-target-commands 'helm-buffers-list)
;; ChangeLogに行くとき
(add-to-list 'mac-win-target-commands 'add-change-log-entry-other-window)
;; 個人用の関数を使うとき
(add-to-list 'mac-win-target-commands 'my:)
;; org-mode で締め切りを設定するとき．
(add-to-list 'mac-win-target-commands 'org-deadline)
(add-to-list 'mac-win-target-commands 'org-delete-backward-char)

;; query-replace で変換するとき
(add-to-list 'mac-win-target-commands 'query-replace)

;; (defvar my:cursor-color-ime-on "#FF9300")
;; (defvar my:cursor-color-ime-off "#91C3FF") ;; #FF9300, #999999, #749CCC
;; (defvar my:cursor-type-ime-on '(bar . 2)) ;; box
;; (defvar my:cursor-type-ime-off '(bar . 2))

;; (when (fboundp 'mac-input-source)
;;     (defun my:mac-keyboard-input-source ()
;;       (if (string-match "\\.Roman$" (mac-input-source))
;;           (progn
;;             (setq cursor-type my:cursor-type-ime-off)
;;             (add-to-list 'default-frame-alist
;;                          `(cursor-type . ,my:cursor-type-ime-off))
;;             (set-cursor-color my:cursor-color-ime-off))
;;         (progn
;;           (setq cursor-type my:cursor-type-ime-on)
;;           (add-to-list 'default-frame-alist
;;                        `(cursor-type . ,my:cursor-type-ime-on))
;;           (set-cursor-color my:cursor-color-ime-on)))))

;; (when (and (fboundp 'mac-auto-ascii-mode)
;;            (fboundp 'mac-input-source))
;;       ;; IME ON/OFF でカーソルの種別や色を替える
;;       (add-hook 'mac-selected-keyboard-input-source-change-hook
;;                 'my:mac-keyboard-input-source)
;;       (my:mac-keyboard-input-source))

;; ;; たまにカーソルの色が残ってしてしまう．
;; ;; IME ON で英文字打ったあととに，色が変更されないことがある．禁断の対処方法．
;; (when (fboundp 'mac-input-source)
;;   (run-with-idle-timer 3 t 'my:mac-keyboard-input-source))

;; ;; 変換語指定時にカーソルをオフにする．復帰後のカーソルタイプを指定すると発動．
;; (setq mac-win-ime-cursor-type 'box)



;; ---------------------------------------------
;; 日本語入力(Ubuntu)
;; ---------------------------------------------
;; mozc
;; (when (require 'mozc nil t)
;;   (setq default-input-method "japanese-mozc")
;;   ;; (setq mozc-candidate-style 'echo-area)
;;   (setq mozc-candidate-style 'overlay)
;;   (global-set-key (kbd "C-o") 'toggle-input-method))
;; ---------------------------------------------
;; ibus-el
;; ---------------------------------------------
;; (when (require 'ibus nil t)
;;   (add-hook 'after-init-hook 'ibus-mode-on)
;;   (add-hook 'after-make-frame-functions
;;             (lambda (new-frame)
;;               (select-frame new-frame)
;;               (or ibus-mode (ibus-mode-on))))

;;   ;; Use C-SPC for Set Mark command
;;   ;; Use C-/ for Undo command
;;   (ibus-define-common-key [?\C-\  ?\C-/]  nil)

;;   ;; IBusの状態によってカーソル色を変化させる ("on" "off" "disabled")
;;   (setq ibus-cursor-color '("firebrick" "dark orange" "royal blue"))
;;   (setq ibus-isearch-cursor-type 'hollow)

;;   ;; すべてのバッファで入力状態を共有 (default ではバッファ毎にインプットメソッドの状態を保持)
;;   (setq ibus-mode-local nil)
;;   ;; カーソル位置で予測候補ウィンドウを表示 (default はプリエディット領域の先頭位置に表示)
;;   (setq ibus-prediction-window-position t)
;;   ;; isearch 時はオフに
;;   (ibus-disable-isearch)

;;   ;; Keybindings
;;   (global-set-key (kbd "C-o") 'ibus-toggle)
;;   (global-set-key (kbd "C-<f7>")
;;                   (lambda ()
;;                     (interactive)
;;                     (shell-command-to-string
;;                      "/usr/lib/mozc/mozc_tool --mode=word_register_dialog")))
;;   )
