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
