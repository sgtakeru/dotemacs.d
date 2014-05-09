;; ---------------------------------------------
;;; org-mode
;; ---------------------------------------------
(require 'org)
(add-to-list 'auto-mode-alist '("\\.txt$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;; (setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-startup-folded "content")
(setq org-display-custom-times "<%Y-%m-%d %H:%M:%S>")
(setq org-time-stamp-custom-formats "<%Y-%m-%d %H:%M:%S>")

; 初期表示はアウトラインで。
;http://superuser.com/questions/357351/org-mode-let-it-open-org-files-unfolded
(setq org-startup-folded (quote content))

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
