(require 'yoeight-package)

;; Install Flycheck.
(use-package flycheck
  :config
  ;; Start it automatically for all modes except ELisp mode,
  ;; where the linter is just designed to make you mad.
  (add-hook 'find-file-hook
            (lambda ()
              (when (not (equal 'emacs-lisp-mode major-mode))
                (flycheck-mode)))))

;; Jump between current errors with M-n and M-p.
(global-set-key (kbd "M-n") 'next-error)
(global-set-key (kbd "M-p") 'previous-error)

;; Turn the modeline red when Flycheck has errors.
(use-package flycheck-color-mode-line
  :config
  ;; Configure the theme.
  (with-eval-after-load "flycheck"
    (setq flycheck-highlighting-mode 'symbols)
    (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)))


;;(add-hook
;; '4lick/dark-hook
;; (lambda ()
;;   (with-eval-after-load "flycheck"
;;     (set-face-background 'flycheck-error "#660000")
;;     (set-face-foreground 'flycheck-error nil)
;;     (set-face-background 'flycheck-warning "#331800")
;;     (set-face-foreground 'flycheck-warning nil)
;;     (require 'flycheck-color-mode-line)
;;     (set-face-background 'flycheck-color-mode-line-error-face "#440000")
;;     (set-face-background 'flycheck-color-mode-line-warning-face "#553300")
;;     (set-face-background 'flycheck-color-mode-line-info-face nil)
;;     (set-face-foreground 'flycheck-color-mode-line-error-face "#ffffff")
;;     (set-face-foreground 'flycheck-color-mode-line-warning-face "#ffffff")
;;     (set-face-foreground 'flycheck-color-mode-line-info-face nil))))

;;(add-hook
;; '4lick/light-hook
;; (lambda ()
;;   (with-eval-after-load "flycheck"
;;     (set-face-background 'flycheck-error "#ff8888")
;;     (set-face-foreground 'flycheck-error nil)
;;     (set-face-background 'flycheck-warning "#ffcc88")
;;     (set-face-foreground 'flycheck-warning nil)
;;     (require 'flycheck-color-mode-line)
;;     (set-face-background 'flycheck-color-mode-line-error-face "#ff0000")
;;     (set-face-foreground 'flycheck-color-mode-line-error-face "#ffffff")
;;     (set-face-background 'flycheck-color-mode-line-warning-face "#886600")
;;     (set-face-foreground 'flycheck-color-mode-line-warning-face "#ffffff")
;;     (set-face-background 'flycheck-color-mode-line-info-face nil)
;;     (set-face-foreground 'flycheck-color-mode-line-info-face nil))))



(provide 'yoeight-flycheck)
