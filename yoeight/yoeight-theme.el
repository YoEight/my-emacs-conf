;; Themes
(add-to-list 'custom-theme-load-path (concat dotfiles-dir "themes"))
(add-to-list 'load-path (concat dotfiles-dir "themes"))

(set-face-attribute 'default nil :height 120)
(load-theme 'github t)
(set-face-attribute 'default nil :font "Go Mono-13")

(provide 'yoeight-theme)
