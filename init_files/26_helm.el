;; ---------------------------------------------
;; helm
;; ---------------------------------------------
(require 'helm-config)
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

(require 'helm-etags+)
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


(require 'helm-descbinds)
(global-set-key (kbd "C-S-h") 'helm-descbinds)

(require 'helm-ls-git)
(global-set-key (kbd "C-c C-f") 'helm-ls-git-ls)
