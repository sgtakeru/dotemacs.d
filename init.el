(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;; download el-get
(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;; packages
;; (require 'package)
;; (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;; (package-initialize)

;; ;; 指定したディレクトリを再帰的にload-pathに追加する関数
;; (defun add-to-load-path (&rest paths)
;;   (let (path)
;;     (dolist (path paths paths)
;;       (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
;;         (add-to-list 'load-path default-directory)
;;         (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
;;             (normal-top-level-add-subdirs-to-load-path))))))

;; ---------------------------------------------
;; external lisps
;; ---------------------------------------------
(el-get-bundle apel)
(el-get-bundle moccur-edit)
(el-get-bundle emacswiki:popup-select-window)
(el-get-bundle helm-etags-plus)
(el-get-bundle org-tree-slide)
(el-get-bundle mozc)
(el-get-bundle color-theme)
(el-get-bundle color-theme-almost-monokai)
(el-get-bundle init-loader)

(el-get-bundle ac-dabbrev)
(el-get-bundle ac-helm)
(el-get-bundle ac-ja)
(el-get-bundle ag)
(el-get-bundle anzu)
(el-get-bundle auto-complete)
(el-get-bundle cask)
(el-get-bundle coffee-mode)
(el-get-bundle color-moccur)
(el-get-bundle css-mode)
(el-get-bundle csv-mode)
(el-get-bundle dash)
(el-get-bundle deft)
(el-get-bundle diff-hl)
(el-get-bundle dired-hacks-utils)
(el-get-bundle dired-rainbow)
(el-get-bundle direx)
(el-get-bundle dockerfile-mode)
(el-get-bundle epl)
(el-get-bundle expand-region)
(el-get-bundle f)
(el-get-bundle findr)
(el-get-bundle elpa:foreign-regexp)
(el-get-bundle fringe-helper)
(el-get-bundle furl)
(el-get-bundle fuzzy)
(el-get-bundle gh)
(el-get-bundle gist)
(el-get-bundle git-gutter)
(el-get-bundle git-gutter+)
(el-get-bundle gitignore-mode)
(el-get-bundle haml-mode)
(el-get-bundle helm)
(el-get-bundle helm-ag)
(el-get-bundle helm-ag-r)
(el-get-bundle helm-c-moccur)
(el-get-bundle helm-c-yasnippet)
(el-get-bundle helm-cmd-t)
(el-get-bundle helm-descbinds)
(el-get-bundle helm-dired-recent-dirs)
(el-get-bundle helm-gist)
(el-get-bundle helm-git)
(el-get-bundle helm-git-grep)
(el-get-bundle helm-gtags)
(el-get-bundle helm-helm-commands)
(el-get-bundle helm-ls-git)
(el-get-bundle helm-migemo)
(el-get-bundle helm-rails)
(el-get-bundle helm-rb)
(el-get-bundle helm-rubygems-local)
(el-get-bundle helm-themes)
(el-get-bundle highlight-indentation)
(el-get-bundle hl-line+)
(el-get-bundle icomplete+)
(el-get-bundle inf-ruby)
(el-get-bundle inflections)
(el-get-bundle init-loader)
(el-get-bundle elpa:javascript)
(el-get-bundle js2-mode)
(el-get-bundle js3-mode)
(el-get-bundle json-mode)
(el-get-bundle json-reformat)
(el-get-bundle jump)
(el-get-bundle key-combo)
(el-get-bundle lineno)
(el-get-bundle logito)
(el-get-bundle magit)
(el-get-bundle markdown-mode)
(el-get-bundle markdown-mode+)
(el-get-bundle marmalade)
(el-get-bundle migemo)
(el-get-bundle mode-compile)
(el-get-bundle multiple-cursors)
(el-get-bundle nginx-mode)
(el-get-bundle org)
(el-get-bundle org-jekyll)
(el-get-bundle org-journal)
(el-get-bundle package-build)
(el-get-bundle pallet)
(el-get-bundle pcache)
(el-get-bundle php-completion)
(el-get-bundle php-mode)
(el-get-bundle pkg-info)
(el-get-bundle popup)
(el-get-bundle popwin)
(el-get-bundle puppet-mode)
(el-get-bundle puppetfile-mode)
;; (el-get-bundle python-mode)
(el-get-bundle rainbow-delimiters)
(el-get-bundle rainbow-mode)
(el-get-bundle recentf-ext)
;; ;; (el-get-bundle rinari)
(el-get-bundle robe)
(el-get-bundle rsense)
(el-get-bundle rspec-mode)
(el-get-bundle ruby-block)
(el-get-bundle ruby-compilation)
(el-get-bundle ruby-electric)
(el-get-bundle ruby-end)
(el-get-bundle ruby-hash-syntax)
(el-get-bundle ruby-interpolation)
(el-get-bundle ruby-test-mode)
(el-get-bundle ruby-tools)
(el-get-bundle s)
(el-get-bundle sass-mode)
(el-get-bundle scss-mode)
(el-get-bundle sequential-command)
(el-get-bundle shut-up)
(el-get-bundle simple-httpd)
(el-get-bundle smartrep)
(el-get-bundle ssh-config-mode)
(el-get-bundle undo-tree)
(el-get-bundle w3m)
(el-get-bundle web-mode)
(el-get-bundle yaml-mode)
(el-get-bundle yari)
(el-get-bundle yasnippet)
(el-get-bundle elscreen)
(el-get-bundle graphviz-dot-mode)
(el-get-bundle sequential-command-config)


;; ---------------------------------------------
;; init-loader
;; 00-09 基本的な設定など
;; 10-29 必須ぽい拡張やユーティリティみたいなやつの設定
;; 30-39 言語別設定
;; 99    最後にやりたいやつ
;; ---------------------------------------------
(init-loader-load "~/.emacs.d/init_files")
