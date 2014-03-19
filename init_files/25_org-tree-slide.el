;; ---------------------------------------------
;; org-tree-slide
;; org-modeでプレゼン
;; ---------------------------------------------
(require 'org-tree-slide)

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
(define-key org-tree-slide-mode-map (kbd "<f5>") 'org-tree-slide-move-previous-tree)
(define-key org-tree-slide-mode-map (kbd "<f6>") 'org-tree-slide-move-next-tree)
(define-key org-tree-slide-mode-map (kbd "<f7>") 'org-tree-slide-content)
;; Reset the default setting
(define-key org-tree-slide-mode-map (kbd "<left>")  'backward-char)
(define-key org-tree-slide-mode-map (kbd "<right>") 'forward-char)
(setq org-tree-slide-skip-outline-level 4)
(org-tree-slide-narrowing-control-profile)
(setq org-tree-slide-skip-done nil)
(org-tree-slide-my-profile)
