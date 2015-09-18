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


(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

;; packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(eval-when-compile (require 'cl))

;; 指定したディレクトリを再帰的にload-pathに追加する関数
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))
;; ---------------------------------------------
;; load-path を再帰的に追加
;; ---------------------------------------------
(add-to-load-path "elisp")

;; ---------------------------------------------
;; init-loader
;; 00-09 基本的な設定など
;; 10-29 必須ぽい拡張やユーティリティみたいなやつの設定
;; 30-39 言語別設定
;; 99    最後にやりたいやつ
;; ---------------------------------------------
(require 'init-loader)
(init-loader-load "~/.emacs.d/init_files")


;; auto-install
;; (install-elisp "http://www.emacswiki.org/emacs/download/auto-install.el")
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;; EmacsWikiの頁を補完候補に
  ;; (auto-install-update-emacswiki-package-name t)  ;; hungup when startup
  (auto-install-compatibility-setup)
  (setq ediff-window-setup-function 'ediff-setup-windws-plain))
