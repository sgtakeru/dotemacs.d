;; ---------------------------------------------
;; 拾ってきたり作った関数を置くところ
;; ---------------------------------------------





;; ---------------------------------------------
;; C-x bでバッファのチラミ
;; [[http://www.bookshelf.jp/soft/meadow_28.html#SEC371][Meadow/Emacs memo: バッファリストとバッファの切り替え]]
;; ---------------------------------------------
(defadvice iswitchb-exhibit
  (after
   iswitchb-exhibit-with-display-buffer
   activate)
  "選択している buffer を window に表示してみる。"
  (when (and
         (eq iswitchb-method iswitchb-default-method)
         iswitchb-matches)
    (select-window
     (get-buffer-window (cadr (buffer-list))))
    (let ((iswitchb-method 'samewindow))
      (iswitchb-visit-buffer
       (get-buffer (car iswitchb-matches))))
    (select-window (minibuffer-window))))


;; ---------------------------------------------
;; git grep
;; nori3
;; ---------------------------------------------
;; 現在のバッファ位置から上方の指定したファイルを見つける
(defun find-file-upward (name &optional dir)
  (setq dir (file-name-as-directory (or dir default-directory)))
  (cond
   ((string= dir (directory-file-name dir))
    nil)
   ((file-exists-p (expand-file-name name dir))
    (expand-file-name name dir))
   (t
    (find-file-upward name (expand-file-name ".." dir)))))

;; gitで管理しているディレクトリのルートから git grep する
(defun git-grep-root ()
  (interactive)
  (let (
        (git-dir (concat (find-file-upward ".git") "/../"))
        (cmd "git --no-pager grep -n --no-color ")
        (origin-default-directory default-directory)
        )
    (setq default-directory git-dir)
    (setq cmd
          (read-string "run git root grep (like this) : " cmd))
    (compilation-start cmd 'grep-mode
                       `(lambda (name)
                          (format "*git-root-grep@%s*" ,git-dir)))
    (setq default-directory origin-default-directory)))


(defun git-grep-current ()
  (interactive)
  (let ((grep-find-command "git --no-pager grep -n --no-color "))
    (call-interactively 'grep-find)))


;; リージョンが活性化していればリージョン削除
;; 非活性であれば、直前の単語を削除
(defun kill-region-or-backward-kill-word ()
  (interactive)
  (if (region-active-p)
      (kill-region (point) (mark))
    (backward-kill-word 1)))
