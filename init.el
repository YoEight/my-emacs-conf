;; Initialize the package system.
(package-initialize)

;; Skip the default splash screen.
(setq inhibit-startup-message t)

;; Path to .emacs.d. Can also handle symlink.
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) (file-chase-links load-file-name))))

;; Yo Eight Emacs' libraries packages.
(add-to-list 'load-path (concat dotfiles-dir "yoeight"))

;; Setup modules.
(add-to-list 'load-path (concat dotfiles-dir "setup"))

;; Load the Yo Eight's Emacs fundamentals.
(require 'yoeight-lib)
(require 'yoeight-package)
(require 'yoeight-ui)
(require 'yoeight-theme)

;; Language configuration.
(load-file (concat dotfiles-dir "setup/yoeight-helm.el"))
(load-file (concat dotfiles-dir "setup/yoeight-flycheck.el"))
(load-file (concat dotfiles-dir "setup/yoeight-haskell.el"))
(load-file (concat dotfiles-dir "setup/yoeight-project.el"))

;; restclient
(use-package restclient)

;; Functions (load all files in defuns-dir)
(setq defuns-dir (concat dotfiles-dir "defuns"))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))

;; Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

;; Specific Mac OS X configuration.
(defconst *is-a-mac* (eq system-type 'darwin))
(when *is-a-mac*
  (setq default-input-method "MacOSX")
  (setq mac-command-modifier 'meta
        mac-option-modifier nil
        mac-allow-anti-aliasing t
        mac-command-key-is-meta t)
  (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
  (setq exec-path (append exec-path '("/usr/local/bin"))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (restclient helm-projectile projectile intero flycheck-color-mode-line flycheck swiper-helm helm-swoop helm-ag helm nyan-mode hlinum f use-package paradox))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
