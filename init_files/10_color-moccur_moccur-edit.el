;; ---------------------------------------------
;;; color-moccur: 検索結果をリストアップ
;; (install-elisp "http://www.emacswiki.org/emacs/download/color-moccur.el")
;; (install-elisp "http://www.emacswiki.org/emacs/download/moccur-edit.el")
;; ---------------------------------------------
(require 'color-moccur)
;; スペース区切りでAND検索
(setq moccur-split-word t)
;; ディレクトリ検索のとき除外するファイル
(add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
(add-to-list 'dmoccur-exclusion-mask "\\.redcar")
(add-to-list 'dmoccur-exclusion-mask "\\.git")
(add-to-list 'dmoccur-exclusion-mask "^#.+#$")

(require 'moccur-edit)
;; migemo 利用できる環境であれば migemo を使う
(when (and (executable-find "cmigemo")
           (require 'migemo nil t))
  (setq moccur-use-migemo t))
