;; recentf
;; 最近開いたファイルの保存数を増やす
(setq recentf-max-saved-items 5000)
(setq recentf-auto-cleanup '15 )
(setq recentf-exclude '("/TAGS$" "/var/tmp/" "/auto-install/" ".recentf" "/elpa/" "\\.ido.last"))
(run-with-idle-timer 30 t 'recentf-save-list)

;; resentf-ext.el
(when (require 'recentf-ext nil t))
(defadvice recentf-open-files (after recentf-set-overlay-directory-adv activate)
  (set-buffer "*Open Recent*")
  (save-excursion
    (while (re-search-forward "\\(^  \\[[0-9]\\] \\|^  \\)\\(.*/\\)$" nil t nil)
      (overlay-put (make-overlay (match-beginning 2) (match-end 2))
                   'face `((:foreground ,"#F1266F"))))))
