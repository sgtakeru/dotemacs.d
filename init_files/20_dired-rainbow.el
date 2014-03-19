;; ---------------------------------------------
;; dired-rainbow diredのファイル名を拡張子で色付け
;; from package
;; ---------------------------------------------
(require 'dired-rainbow)
(defconst my:dired-media-files-extensions
  '("mp3" "mp4" "MP3" "MP4" "avi" "mpg" "flv" "ogg")
  "Media files.")

(dired-rainbow-define html "#4e9a06" ("htm" "html" "xhtml"))
(dired-rainbow-define media "#ce5c00" my:dired-media-files-extensions)
