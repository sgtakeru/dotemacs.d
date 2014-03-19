;; ---------------------------------------------
;; wdired:
;; ---------------------------------------------
(require 'wdired)
;; r でリネーム C-cc で確定
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; コピー(移動)先を、他方のウィンドウにする
(setq dired-dwim-target t)
;; ディレクトリを再帰的にコピーする
(setq dired-recursive-copies 'always)
