;; Themes
(add-to-list 'custom-theme-load-path (concat dotfiles-dir "themes"))
(add-to-list 'load-path (concat dotfiles-dir "themes"))

(set-face-attribute 'default nil :height 120)
(package-require 'darkokai-theme)
;; (load-theme 'darkokai)
(set-face-attribute 'default nil :font "Inconsolata-14")

(provide 'yoeight-theme)
