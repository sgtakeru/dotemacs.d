;; packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)


;; ---------------------------------------------
;; OS判定
;; ---------------------------------------------
;; (defvar os-type nil)

;; (cond ((string-match "apple-darwin" system-configuration) ;; Mac
;;        (setq os-type 'mac))
;;       ((string-match "linux" system-configuration)        ;; Linux
;;        (setq os-type 'linux))
;;       ((string-match "freebsd" system-configuration)      ;; FreeBSD
;;        (setq os-type 'bsd))
;;       ((string-match "mingw" system-configuration)        ;; Windows
;;        (setq os-type 'win)))

;; (defun mac? ()
;;   (eq os-type 'mac))

;; (defun linux? ()
;;   (eq os-type 'linux))

;; (defun bsd? ()
;;   (eq os-type 'freebsd))

;; (defun win? ()
;;   (eq os-type 'win))
;; -----------------

;; おまじない
(require 'cl)


;; ---------------------------------------------
;; load-path を追加する関数を定義
;; ---------------------------------------------
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; elispとconfディレクトリをサブディレクトリごとload-pathに追加
(add-to-load-path "elisp")

;; ---------------------------------------------
;; emacsにPATHを引き継ぐ  http://qiita.com/catatsuy/items/3dda714f4c60c435bb25
;; ---------------------------------------------
(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)


;; auto-install
;; (install-elisp "http://www.emacswiki.org/emacs/download/auto-install.el")
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;; EmacsWikiの頁を補完候補に
  ;; (auto-install-update-emacswiki-package-name t)  ;; hungup when startup
  (auto-install-compatibility-setup)
  (setq ediff-window-setup-function 'ediff-setup-windws-plain))

;; use server-mode
(require 'server)
(unless (server-running-p)
  (server-start))


;; ---------------------------------------------
;; Emacsの動作制御
;; ---------------------------------------------

;; 起動画面を非表示
(setq inhibit-startup-screen t)
;; ツールバー削除
(when window-system
  (tool-bar-mode -1))

;; blink-cursor
(blink-cursor-mode t)
(setq-default cursor-type '(hbar . 2))


;; 最後に改行を追加
(setq require-final-newline t)

;; 行末の空白を表示
(setq-default show-trailing-whitespace t)

;; 保存時にファイル内の行末空白を削除
(add-hook 'before-save-hook 'delete-trailing-whitespace)

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

(savehist-mode 1)

(setq-default save-place t)
(require 'saveplace)

;; カッコを強調
(setq show-paren-delay 0)
(show-paren-mode 1)
(setq show-paren-style 'expression)                    ; カッコ内の色も変更
(set-face-background 'show-paren-match-face nil)       ; カッコ内のフェイス
(set-face-underline-p 'show-paren-match-face "gold3") ; カッコ内のフェイス

;; モードラインに時間
;; (display-time)

;; モードラインに行ナンバー
(line-number-mode 1)
(column-number-mode 1)

(transient-mark-mode 1)

;; GCサイズを変更
(setq gc-cons-threshold (* 30 gc-cons-threshold))

;; ログ容量
(setq message-log-max 10000)
(setq enable-recursive-minibuffers t)

;; kill-lineで行末も削除
(setq kill-whole-line 1)

;; 履歴数
(setq history-length 10000)
(setq history-delete-duplicates t)
(setq echo-keystrokes 0.1)


(defadvice abort-recursive-edit (before minibuffer-save activate)
  (when (eq (selected-window) (active-minibuffer-window))
    (add-to-history minibuffer-history-variable (minibuffer-contents))))

;; 25MB以上は警告表示
(setq large-file-warning-threshold (* 25 1024 1024))

;; yes-no -> y-p
(defalias 'yes-or-no-p 'y-or-n-p)

;; do not show dialog box
(setq use-dialog-box nil)

;; カーソルがある関数名をモードラインに表示
(which-function-mode 1)


;; バッファ切り替え
(iswitchb-mode 1)
(setq read-buffer-function 'iswitchb-read-buffer)
(setq iswitchb-regexp nil)
(setq iswitchb-prompt-newbuffer nil)

;; ido
;; (ido-mode 1)
;; (ido-everywhere 1)

;; 行番号の表示
(global-linum-mode)

;; タブはスペースで
(setq-default indent-tabs-mode nil)

;; メニューバーにファイルをパスを表示
(setq frame-title-format
      (format "%%f -emacs@%s" (system-name)))


;; backup
(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backups"))
            backup-directory-alist))


;; リージョンが活性化していればリージョン削除
;; 非活性であれば、直前の単語を削除

(defun kill-region-or-backward-kill-word ()
  (interactive)
  (if (region-active-p)
      (kill-region (point) (mark))
    (backward-kill-word 1)))

(global-set-key "\C-w" 'kill-region-or-backward-kill-word)


;; Default key bindings
;; C-hは前を削除
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
;; ヘルプ表示
(global-set-key (kbd "C-x ?") 'help)

(global-set-key (kbd "C-m") 'newline-and-indent)

 ;; Change Font size
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)


 ;; Use regex searches by default.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; Jump to a definition in the current file. (Protip: this is awesome.)
(global-set-key (kbd "C-x C-i") 'imenu)

 ;; Window switching. (C-x o goes to the next window)
;; (windmove-default-keybindings) ;; shift+ion
(global-set-key (kbd "C-x O") (lambda () (interactive) (other-window -1))) ;; back one
(global-set-key (kbd "C-x C-o") (lambda () (interactive) (other-window 2))) ;; forward two
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

;; magit
(global-set-key (kbd "C-c g") 'magit-status)


;; rspec-mode
;; C-c , t / toggle spec <-> target


;; (global-set-key (kbd "C-o") 'mac-input-method-mode)


;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
(set-frame-parameter (selected-frame) 'alpha '(95 80))
(add-to-list 'default-frame-alist '(alpha 95 80))

(eval-when-compile (require 'cl))
(defun toggle-transparency ()
  (interactive)
  (if (/=
       (cadr (frame-parameter nil 'alpha))
       100)
      (set-frame-parameter nil 'alpha '(100 100))
    (set-frame-parameter nil 'alpha '(90 50))))
(global-set-key (kbd "C-c t") 'toggle-transparency)

;; Set transparency of emacs
(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))
(global-set-key (kbd "C-c C-t") 'transparency)


;; 終了時に確認
(defadvice save-buffers-kill-emacs
  (before safe-save-buffers-kill-emacs activate)
  "safe-save-buffers-kill-emacs"
  (unless (y-or-n-p "Really exit emacs? ")
    (keyboard-quit)))


;; fullscreen
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                  'fullboth)))))
(global-set-key (kbd "<f11>") 'toggle-fullscreen)

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




;; カーソル位置からパスを開く
(ffap-bindings)


;; クリップボードとキルリングを同期させる
(cond (window-system
       (setq x-select-enable-clipboard t)))


;; ---------------------------------------------
;; Emacsの動作制御 ここまで
;; ---------------------------------------------



;; ---------------------------------------------
;; undo-tree: Undo の分岐を視覚化する
;; from melpa
;; ---------------------------------------------
(when (require 'undo-tree nil t)
  (global-undo-tree-mode t)
  (global-set-key (kbd "C-M-/") 'undo-tree-visualize)  ;; default C-x u
  )


(when (require 'sequential-command-config nil t)
  (sequential-command-setup-keys))


;; ---------------------------------------------
;; バッファ名を見やすく
;; ---------------------------------------------
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")


;; ---------------------------------------------
;; popup-select-window
;; from http://www.emacswiki.org/emacs/popup-select-window.el
;; ---------------------------------------------
(require 'popup)
(when (require 'popup-select-window nil t)
  (global-set-key (kbd "C-x o") 'popup-select-window)
  (setq popup-select-window-popup-windows 3)  ;; バッファが3位上はポップアップする(デフォルトの設定)
  (setq popup-select-window-window-highlight-face '(:foreground "white" :background "Brown"))
  )

;; ---------------------------------------------
;; anzu.el
;; http://qiita.com/syohex/items/56cf3b7f7d9943f7a7ba
;; ---------------------------------------------
(when (require 'anzu nil t)
  (global-anzu-mode 1)
  (setq anzu-mode-lighter "")
  (setq anzu-deactivate-region t)
  (setq anzu-search-threshold 300)
  (setq anzu-replace-to-string-separator " -> ")
  (global-set-key (kbd "M-%") 'anzu-query-replace-regexp)
  (global-set-key (kbd "C-M-%") 'anzu-query-replace)
  (global-set-key (kbd "C-c r") 'anzu-query-replace-at-cursor-thing)
  )




;; ---------------------------------------------
;; popupwin
;; from melpa
;; ---------------------------------------------
(when (require 'popwin nil t)
  (popwin-mode 1)
  (setq popwin:close-popup-window-timer-interval 0.05)
  (push '("\*helm" :regexp t :height 0.3) popwin:special-display-config)
  (push '(dired-mode :position top)  popwin:special-display-config)
  (push '("\*ag" :regexp t :height 0.5) popwin:special-display-config)
  (push '("\*magit" :regexp t :height 0.5) popwin:special-display-config)
  (push '("COMMIT_EDITMSG" :position right :width 0.5) popwin:special-display-config)
  (push '("20[0-9]\{6\}" :regexp t :height 0.5) popwin:special-display-config)
  )


;; ---------------------------------------------
;; direx
;; use(popwin)
;; from melpa
;; ---------------------------------------------
(when (require 'direx nil t)
  (setq direx:leaf-icon "  "
        direx:open-icon "\&#9662; "
        direx:closed-icon "&#9654; ")
  (push '(direx:direx-mode :position left :width 25 :dedicated t)
        popwin:special-display-config)
  (global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)
  )


;; recentf
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

;; ---------------------------------------------
;; wdired:
;; ---------------------------------------------
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; diredを2つのウィンドウで開いている時に、デフォルトの移動orコピー先をもう一方のdiredで開いているディレクトリにする
(setq dired-dwim-target t)
;; ディレクトリを再帰的にコピーする
(setq dired-recursive-copies 'always)

;; (add-hook 'dired-load-hook
;;           '(lambda ()
;;              (load-library "ls-lisp")
;;              (setq ls-lisp-dirs-first t)
;;              (setq dired-listing-switches "-AFl")
;;              (setq find-ls-option '("-exec ls -AFGl {} \\;" . "-AFGl"))
;;              (setq grep-find-command "find . -type f -print0 | xargs -0 -e grep -ns ")
;;              (require 'wdired)
;;              (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
;;              ))



;; 言語設定
;; (set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)


;;; auto-complete-mode:
(when (require 'auto-complete-config nil t)
  ;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "C-,") 'auto-complete)
  (ac-config-default))



;; ---------------------------------------------
;; inputmethod for macosx
;; ---------------------------------------------
(global-set-key (kbd "C-M-o") 'toggle-input-method)
(setq default-input-method "MacOSX")
;; カーソルの色
(mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" `cursor-color "red")
(mac-set-input-method-parameter "com.google.inputmethod.Japanese.Roman" `cursor-color "cyan")

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


;;; 色設定
(when window-system
  (require 'color-theme nil t)
  (color-theme-initialize)
  (color-theme-almost-monokai))
  ;; (color-theme-monokai))
  ;; (load-theme 'monokai t)




;; ---------------------------------------------
;; deft
;; http://jblevins.org/projects/deft/
;; ---------------------------------------------
(when (require 'deft nil 'noerror)
   (setq
      deft-extension "org"
      deft-directory "~/Dropbox/FreeFolders/org/notes/"
      deft-text-mode 'org-mode)
   (global-set-key (kbd "<f9>") 'deft))

;; ---------------------------------------------
;;; org-mode
;; ---------------------------------------------
(when (require 'org nil t)
  (add-to-list 'auto-mode-alist '("\\.txt$" . org-mode))
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
  ;; (setq org-default-notes-file (concat org-directory "/notes.org"))

  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c c") 'org-capture)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c b") 'org-iswitchb)
  (setq org-directory "~/Dropbox/FreeFolders/org/")
  (setq org-default-notes-file (concat org-directory "agenda.org"))
  (setq org-agenda-files (list org-directory))
  ;; (setq org-agenda-files '("00-gtd.org" "00-gtd.org_archive"))
  (setq org-capture-templates
        '(("t" "Task" entry
           (file+headline "~/Dropbox/FreeFolders/org/00-gtd.org" "TASK")
           "** TODO %?\n   %i\n   %a\n   %t")
          ("n" "Notes" entry
           (file+headline "~/Dropbox/FreeFolders/org/00-notes.org" "Notes")
           "** %?\n   %i\n   %a\n   %t")
          ("j" "Journal" entry
           (file+datetree "~/Dropbox/FreeFolders/org/00-journal.org")
           "* %?\n %U\n %i\n %a")
          ("f" "Firefox" entry
           (file+datetree "~/Dropbox/FreeFolders/org/00-firefox.org")
           "* %?\n %(concat (jk/moz-url))\n Entered on %U\n")
          ("w" "Weblog" entry
           (file+headline "~/Dropbox/FreeFolders/org/blog.org" "Drafts")
               "* %?\n%[~/Dropbox/FreeFolders/org/tmpl/blogtmpl.txt]") ))
  )

(when (require 'org-journal nil t)
  (setq org-journal-dir "~/Dropbox/FreeFolders/org/journal/")
  (setq org-journal-file-format "%Y%m%d.org")
  (setq org-agenda-file-regexp "\\`[^.].*\\.org'\\|[0-9]+")
)


;; ---------------------------------------------
;; org-tree-slide
;; org-modeでプレゼン
;; ---------------------------------------------
(when (require 'org-tree-slide nil t)

  (defun org-tree-slide-my-profile ()
    "Set variables for presentation use.
    `org-tree-slide-header'            => nil
    `org-tree-slide-slide-in-effect'   => nil
    `org-tree-slide-heading-emphasis'  => nil
    `org-tree-slide-cursor-init'       => t
    `org-tree-slide-modeline-display'  => 'outside
    `org-tree-slide-skip-done'         => nil
    "
    (interactive)
    (setq org-tree-slide-header nil)
    (setq org-tree-slide-slide-in-effect nil)
    (setq org-tree-slide-heading-emphasis nil)
    (setq org-tree-slide-cursor-init t)
    (setq org-tree-slide-modeline-display 'outside)
    (setq org-tree-slide-skip-done nil)
    (message "my profile: ON"))
  (global-set-key (kbd "<f8>") 'org-tree-slide-mode)
  (global-set-key (kbd "S-<f8>") 'org-tree-slide-skip-done-toggle)
  (define-key org-tree-slide-mode-map (kbd "<f5>")
    'org-tree-slide-move-previous-tree)
  (define-key org-tree-slide-mode-map (kbd "<f6>")
    'org-tree-slide-move-next-tree)
  (define-key org-tree-slide-mode-map (kbd "<f7>")
    'org-tree-slide-content)
  ;; Reset the default setting
  (define-key org-tree-slide-mode-map (kbd "<left>")  'backward-char)
  (define-key org-tree-slide-mode-map (kbd "<right>") 'forward-char)
  (setq org-tree-slide-skip-outline-level 4)
  (org-tree-slide-narrowing-control-profile)
  (setq org-tree-slide-skip-done nil)
  (org-tree-slide-my-profile))



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



;;; Elscreen: Manage window like aGNU Screen.
(load "elscreen" "ElScreen" t)
(when (require 'elscreen nil t)
  (if window-system
      (define-key elscreen-map (kbd "C-z") 'iconify-or-deiconify-frame)
    (define-key elscreen-map (kbd "C-z") 'suspend-emacs))
  (elscreen-start)


  ;; Elscreenのタブは表示しない
  (elscreen-toggle-display-tab)

  ;; モードラインに現在のスクリーン番号と全数を表示
  (defun elscreen-mode-line-update ()
    (when (elscreen-screen-modified-p 'elscreen-mode-line-update)
      (setq elscreen-mode-line-string
            (format "el:[%d/%d]" (elscreen-get-current-screen) (elscreen-get-number-of-screens) ))
      (force-mode-line-update)))
  )


(defvar elscreen-my-title-maps '()) ; タイトルの変換をする

(defun my-elscreen-truncate-screen-name (screen-name truncate-length &optional padding)
  (let ((truncate-length (max truncate-length 4)))
    (cond
     ((> (string-width screen-name) truncate-length)
      (concat (truncate-string-to-width screen-name truncate-length nil) "~"))
     (padding
      (truncate-string-to-width screen-name truncate-length nil ?\ ))
     (t
      screen-name))))

(defun get-alist (key alist)
  (cdr (assoc key alist)))

(defun elscreen-frame-title-update ()
  (when (elscreen-screen-modified-p 'elscreen-frame-title-update)
    (let*
        ((screen-list (sort (elscreen-get-screen-list) '<))
         (screen-to-name-alist (elscreen-get-screen-to-name-alist))
         (tab-width (elscreen-tab-width))
         (title (mapconcat
		   (lambda (screen)
		     (format
              "%s"
              (let ((label
                     (elscreen-tab-escape-%
                      (my-elscreen-truncate-screen-name
                       (reduce (lambda (x f) (funcall f x)) elscreen-my-title-maps
                               :initial-value (get-alist screen screen-to-name-alist))
                       tab-width t))))
                (if (eq screen (elscreen-get-current-screen))
                    (concat "【" label "】") label))))
		   screen-list " ")))
      (if (fboundp 'set-frame-name)
	  (set-frame-name title)
	(setq frame-title-format title)))))

(eval-after-load "elscreen"
  '(add-hook 'elscreen-screen-update-hook 'elscreen-frame-title-update))
;; ---- elscreen-screen-update-hook

;; elscreen-my-title-maps の使い方例

(defun skype--elscreen-title-name-map (x)
 (if (string-match "Skype\\(Chat\\|Message\\):\\[\\(.*\\)\\]$" x)
     (let* ((title (match-string 2 x))
            (buf (get-buffer x))
            (missed (if buf (skype--chat-missed-p
                             (buffer-local-value 'skype-chat-handle buf))
                      nil)))
       (concat (if missed "★" "☆") title))
   x))
(add-to-list 'elscreen-my-title-maps 'skype--elscreen-title-name-map)



;; ---------------------------------------------
;; key-combo // elpa
;; ---------------------------------------------
;; (when (require 'key-combo nil t)
;;   (key-combo-load-default)
;;   )



;; ---------------------------------------------
;;; color-moccur: 検索結果をリストアップ
;; (install-elisp "http://www.emacswiki.org/emacs/download/color-moccur.el")
;; (install-elisp "http://www.emacswiki.org/emacs/download/moccur-edit.el")
;; ---------------------------------------------
(when (require 'color-moccur nil t)
  ;; グローバルマップにoccur-by-moccurを割り当て
  (global-set-key (kbd "M-o") 'occur-by-moccur)
  ;; スペース区切りでAND検索
  (setq moccur-split-word t)
  ;; ディレクトリ検索のとき除外するファイル
  (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "\\.redcar")
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$")
  (require 'moccur-edit nil t)
  ;; migemo 利用できる環境であれば migemo を使う
  (when (and (executable-find "cmigemo")
             (require 'migemo nil t))
    (setq moccur-use-migemo t)))

;; ---------------------------------------------
;; yaml-mode
;; ---------------------------------------------
(when (require 'yaml-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode)))

;; ---------------------------------------------
;; ruby-mode
;; ---------------------------------------------
(when (require 'inf-ruby nil t)
  ;; ;; M-. to jump to the definition of a given method and M-, to jump back.
  ;; (add-hook 'inf-ruby-mode-hook 'zossima-mode)
  )
(when (require 'ruby-compilation nil t))

(when (require 'ruby-mode nil t)
  (add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.irbrc\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.pryrc\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.aprc\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rabl$" . ruby-mode))

  ;; (defun ruby-mode-hook-ruby-elecrtric ()
  ;;   (ruby-electric-mode t))
  ;; (add-hook 'ruby-mode-hook 'ruby-mode-hook-ruby-elecrtric)
  ;; use irb in buffer
  (setq ruby-deep-indent-paren-style nil)
  (defadvice ruby-indent-line (after unindent-closing-paren activate)
    (let ((column (current-column))
          indent offset)
      (save-excursion
        (back-to-indentation)
        (let ((state (syntax-ppss)))
          (setq offset (- column (current-column)))
          (when (and (eq (char-after) ?\))
                     (not (zerop (car state))))
            (goto-char (cadr state))
            (setq indent (current-indentation)))))
      (when indent
        (indent-line-to indent)
        (when (> offset 0) (forward-char offset)))))
  )
;; ---------------------------------------------
;; rubydb
;; (install-elisp "http://svn.ruby-lang.org/repos/ruby/trunk/misc/rubydb3x.el")
;; M-x rubydb ソースコードにもどり
;; C-x SPC でブレークポイン
;; C-cC-s でステップイン
;; ---------------------------------------------
;; (autoload 'rubydb "rubydb3x" "Run rubydb on program FILE in buffer *gud-FILE*.
;; The directory containing FILE becomes the initial working directory
;; and source-file directory for your debugger.")


;; ;; (install-elisp-from-emacswiki "ruby-block.el")
;; (when (require 'ruby-block nil t)
;;   (setq ruby-block-highlight-toggle t)
;;   (defun ruby-mode-hook-ruby-block()
;;     (ruby-block-mode t))
;;   (add-hook 'ruby-mode-hook 'ruby-mode-hook-ruby-block))


;; ---------------------------------------------
;; ruby-tools
;; rubyの文字列内での拡張
;; C-' 文字列を'に変更
;; C-\" 文字列を"に変更
;; C-: 文字列をシンボルへ
;; C-; 文字列内をクリア
;; # 'ruby-tools-interpolate
;; ---------------------------------------------
(when (require 'ruby-tools nil t))



;; ---------------------------------------------
;; php-mode // elpa
;; ---------------------------------------------
(when (require 'php-mode nil t)
  ;; 拡張子 .ctp も php-mode で開く
  (add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
  (add-to-list 'auto-mode-alist '("\\.ctp$" . php-mode)))

;; ---------------------------------------------
;; css-mode // elpa
;; ---------------------------------------------
(when (require 'css-mode nil t)
  (setq css-indent-level 2)
  (setq css-indent-offset 2)
  (setq-default indent-tabs-mode nil)
  (setq cssm-newline-before-closing-bracket t))

;; ---------------------------------------------
;; js
;; ---------------------------------------------
(when (require 'javascript-mode nil t)
  (setq javascript-indent-level 2)
  (setq javascript-expr-indent-offset 2))

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js2-mode-hook
          '(lambda ()
             (setq js2-basic-offset 2)))

;; ---------------------------------------------
;; moz
;; ---------------------------------------------
(when (require 'moz nil t)
  (autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)
  (moz-minor-mode t)

  (defun moz-send-message (moz-command)
    (comint-send-string
     (inferior-moz-process)
     (concat moz-repl-name ".pushenv('printPrompt', 'inputMode'); "
             moz-repl-name ".setenv('inputMode', 'line'); "
             moz-repl-name ".setenv('printPrompt', false); undefined; "))
    (comint-send-string
     (inferior-moz-process)
     (concat moz-command
             moz-repl-name ".popenv('inputMode', 'printPrompt'); undefined;\n")))

  (defun moz-scrolldown ()
    (interactive)
    (moz-send-message "goDoCommand('cmd_scrollLineDown');\n")) ; 下スクロール
  (global-set-key (kbd "C-M-n") 'moz-scrolldown)

  (defun moz-scrollup ()
    (interactive)
    (moz-send-message "goDoCommand('cmd_scrollLineUp');\n")) ; 上スクロール
  (global-set-key (kbd "C-M-p") 'moz-scrollup)

  (defun moz-reload ()
    (interactive)
    (moz-send-message "BrowserReload();\n")) ; reload
  (global-set-key (kbd "C-M-'") 'moz-reload)



  ;; http://blogs.openaether.org/?p=236
  (defun jk/moz-get (attr)
    (comint-send-string (inferior-moz-process) attr)
    ;; try to give the repl a chance to respond
    (sleep-for 0 100))
  (defun jk/moz-get-current-url ()
    (interactive)
    (jk/moz-get "repl._workContext.content.location.href"))

  (defun jk/moz-get-current-title ()
    (interactive)
    (jk/moz-get "repl._workContext.content.document.title"))
  (defun jk/moz-get-current (moz-fun)
    (funcall moz-fun)
    ;; doesn't work if repl takes too long to output string
    (save-excursion
      (set-buffer (process-buffer (inferior-moz-process)))
      (goto-char (point-max))
      (previous-line)
      (setq jk/moz-current (buffer-substring-no-properties
                            (+ (point-at-bol) (length moz-repl-name) 3)
                            (- (point-at-eol) 1))))
    (message "%s" jk/moz-current)
    jk/moz-current
    )
  (defun jk/moz-url ()
    (interactive)
    (jk/moz-get-current 'jk/moz-get-current-url)
    )

  (defun jk/moz-title ()
    (interactive)
    (jk/moz-get-current 'jk/moz-get-current-title)
    )
  )


;; ---------------------------------------------
;; helm
;; ---------------------------------------------
(require 'helm-config)
(when (require 'helm-config nil t)
  (setq helm-buffer-max-length      50
        helm-input-idle-delay       0.3
        helm-idle-delay             0.3
        helm-candidate-number-limit 200
        helm-ff-transformer-show-only-basename nil
        helm-ls-git-show-abs-or-relative 'relative)

  (global-set-key (kbd "C-c h") 'helm-mini)
  (global-set-key (kbd "C-x C-r") 'helm-recentf)
  (global-set-key (kbd "M-r") 'helm-resume)
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)
  (global-set-key (kbd "C-x b") 'helm-buffers-list)
  (global-set-key (kbd "M-x")   'helm-M-x)
  ;; (helm-mode 0)
  (when (require 'helm-etags+ nil t)
    (add-hook 'helm-gtags-mode-hook
              '(lambda ()
                 (local-set-key (kbd "M-t") 'helm-gtags-find-tag)
                 (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
                 (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
                 (local-set-key (kbd "C-t") 'helm-gtags-pop-stack)))
    (global-set-key (kbd "\M-.") 'helm-etags+-select-one-key)
    ;;list all visited tags
    ;; (global-set-key (kbd "\M-*") 'helm-etags+-history)
    ;;go back directly
    ;; (global-set-key (kbd "\M-,") 'helm-etags+-history-go-back)
    ;;go forward directly
    ;; (global-set-key (kbd "\M-/") 'helm-etags+-history-go-forward)
    )
  (when (require 'helm-descbinds nil t)
    (global-set-key (kbd "C-S-h") 'helm-descbinds))

  (when (require 'helm-ls-git nil t)
    (global-set-key (kbd "C-c C-f") 'helm-ls-git-ls))
  )
;; ---------------------------------------------
;; 鬼軍曹
;; ---------------------------------------------
;; (require 'drill-instructor)
;; (setq drill-instructor-global t)
;; (put 'scroll-left 'disabled nil)



;; ;;--------------------------------------------------------------------------
;; ;; csharp-mode
;; ;; (install-elisp-from-emacswiki "csharp-mode.el")
;; ;;--------------------------------------------------------------------------
;; (when (require 'csharp-mode nil t)
;;   ;; Cモード共通フック
;;   (add-hook 'csharp-mode-hook
;;             '(lambda()
;;                (setq comment-column 40)
;;                (setq c-basic-offset 4)
;;                (font-lock-add-magic-number)
;;                ;; オフセットの調整
;;                (c-set-offset 'substatement-open 0)
;;                (c-set-offset 'case-label '+)
;;                (c-set-offset 'arglist-intro '+)
;;                (c-set-offset 'arglist-close 0)
;;              )
;;             ))

;; ---------------------------------------------
;; highlight-indentation
;; install from melpa
;; ---------------------------------------------
(when (require 'highlight-indentation nil t)
  ;; (set-face-background 'highlight-indentation-face "#e3e3d3")
  ;; (set-face-background 'highlight-indentation-current-column-face "#c3b3b3")
  (add-hook 'coffee-mode-hook 'highlight-indentation-current-column-mode)
  (add-hook 'scss-mode-hook 'highlight-indentation-current-column-mode)
  (add-hook 'ruby-mode-hook 'highlight-indentation-current-column-mode)
  (add-hook 'html-mode-hook 'highlight-indentation-current-column-mode)
  )

;;--------------------------------------------------------------------------
;; coffee-mode
;; install from melpa
;;--------------------------------------------------------------------------
(when (require 'coffee-mode nil t)
  (setq coffee-tab-width 2)
  (setq coffee-indent-tabs-mode t)
  (add-to-list 'auto-mode-alist '("\\.hamlc$" . coffee-mode))
)

;; ---------------------------------------------
;; EX isearch
;;[[http://stackoverflow.com/questions/4471835/emacs-dired-mode-and-isearch][Emacs dired mode and Isearch - Stack Overflow]]
;; 大体の挙動は問題ない。しかし、C-sで検索中にC-aを押下で、その時の
;; カーソルにあるファイルを開いてしまう。
;; ---------------------------------------------
;; (add-hook 'isearch-mode-end-hook
;;           (lambda ()
;;             (when (and (eq major-mode 'dired-mode)
;;                        (eq last-input-event ?\r)
;;                        (not isearch-mode-end-hook-quit))
;;               (dired-find-file))))




;; ---------------------------------------------
;; [[http://www.clear-code.com/blog/2012/4/3.html][Emacs上でカラフルにdiffを表示する - ククログ(2012-04-03)]]
;; ---------------------------------------------
;; diffの表示方法を変更
(defun diff-mode-setup-faces ()
  ;; 追加された行は緑で表示
  (set-face-attribute 'diff-added nil
                      :foreground "white" :background "dark green")
  ;; 削除された行は赤で表示
  (set-face-attribute 'diff-removed nil
                      :foreground "white" :background "dark red")
  ;; 文字単位での変更箇所は色を反転して強調
  (set-face-attribute 'diff-refine-change nil
                      :foreground nil :background nil
                      :weight 'bold :inverse-video t))
(add-hook 'diff-mode-hook 'diff-mode-setup-faces)

;; diffを表示したらすぐに文字単位での強調表示も行う
(defun diff-mode-refine-automatically ()
  (diff-auto-refine-mode t))
(add-hook 'diff-mode-hook 'diff-mode-refine-automatically)

;; diff関連の設定
(defun magit-setup-diff ()
  ;; diffを表示しているときに文字単位での変更箇所も強調表示する
  ;; 'allではなくtにすると現在選択中のhunkのみ強調表示する
  (setq magit-diff-refine-hunk 'all)
  ;; diff用のfaceを設定する
  (diff-mode-setup-faces)
  ;; diffの表示設定が上書きされてしまうのでハイライトを無効にする
  (set-face-attribute 'magit-item-highlight nil :inherit nil))
(add-hook 'magit-mode-hook 'magit-setup-diff)



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

;; expand region
;; 単語、式をいい感じに選択してくれる
(when (require 'expand-region nil t)
  (global-set-key (kbd "C-@") 'er/expand-region)     ;; 拡大
  (global-set-key (kbd "C-M-@") 'er/contract-region) ;; 縮小
  )



;; ---------------------------------------------
;; foreign-regrexp emacsで普通の正規表現
;;
;; ---------------------------------------------
(when (require 'foreign-regexp nil t)
  (custom-set-variables
   '(foreign-regexp/regexp-type 'ruby) ;; Choose by your preference.
   '(reb-re-syntax 'foreign-regexp)) ;; Tell re-builder to use foreign regexp.
  )

(global-git-gutter+-mode t)

(global-set-key (kbd "C-x g") 'git-gutter+-mode) ; Turn on/off in the current buffer
(global-set-key (kbd "C-x G") 'global-git-gutter+-mode) ; Turn on/off globally

(eval-after-load 'git-gutter+
  '(progn
     ;;; Jump between hunks
     (define-key git-gutter+-mode-map (kbd "C-x n") 'git-gutter+-next-hunk)
     (define-key git-gutter+-mode-map (kbd "C-x p") 'git-gutter+-previous-hunk)

     ;;; Act on hunks
     (define-key git-gutter+-mode-map (kbd "C-x v =") 'git-gutter+-show-hunk)
     (define-key git-gutter+-mode-map (kbd "C-x r") 'git-gutter+-revert-hunks)
     ;; Stage hunk at point.
     ;; If region is active, stage all hunk lines within the region.
     (define-key git-gutter+-mode-map (kbd "C-x t") 'git-gutter+-stage-hunks)
     (define-key git-gutter+-mode-map (kbd "C-x c") 'git-gutter+-commit)
     (define-key git-gutter+-mode-map (kbd "C-x C") 'git-gutter+-stage-and-commit)
     ;; (setq git-gutter:window-width 2)
     ;; (setq git-gutter:modified-sign "☁")
     ;; (setq git-gutter:added-sign "☀")
     ;; (setq git-gutter:deleted-sign "☂")
     ))


;; ---------------------------------------------
;; dired-rainbow diredのファイル名を拡張子で色付け
;; from package
;; ---------------------------------------------
(when (require 'dired-rainbow nil t)
  (defconst my-dired-media-files-extensions
    '("mp3" "mp4" "MP3" "MP4" "avi" "mpg" "flv" "ogg")
    "Media files.")

  (dired-rainbow-define html "#4e9a06" ("htm" "html" "xhtml"))
  (dired-rainbow-define media "#ce5c00" my-dired-media-files-extensions)
  )

;; ---------------------------------------------
;; rainbow-delimiters 対応するカッコをカラフルに
;; from package
;; ---------------------------------------------
(when (require 'rainbow-delimiters nil t)
  (global-rainbow-delimiters-mode)
  )

;; ---------------------------------------------
;; rainbow-mode コード内のカラーコードの背景に対応する色を付ける
;; from package
;; ---------------------------------------------
(when (require 'rainbow-mode nil t)
  (add-hook 'emacs-lisp-mode-hook 'rainbow-mode)
  (add-hook 'lisp-mode-hook 'rainbow-mode)
  (add-hook 'css-mode-hook 'rainbow-mode)
  (add-hook 'scss-mode-hook 'rainbow-mode)
  (add-hook 'php-mode-hook 'rainbow-mode)
  (add-hook 'html-mode-hook 'rainbow-mode)
  )
