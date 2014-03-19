;; ---------------------------------------------
;; フォントを設定する
;; フォント名一覧表示 *scratch* で、(prin1 (font-family-list))
;; "Ricty Discord"
;; ---------------------------------------------
(create-fontset-from-ascii-font "Ricty-18:weight=normal:slant=normal" nil "ricty")
(set-fontset-font "fontset-ricty"
                  'unicode
                  (font-spec :family "Ricty" :size 18)
                  nil
                  'append)
(add-to-list 'default-frame-alist '(font . "fontset-ricty"))

;; (set-face-attribute 'default nil
;;                    :family "Ricty Discord"
;;                    :height 110)
;; (set-fonsetset-font nil 'japanese-jisx0208 (font-spec :family "Ricty Discord"))
;; (when (eq window-system 'w32)
;;   (set-face-attribute 'default nil
;;                       :family "Consolas"
;;                       :height 110)
;;   (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Meiryo")))
