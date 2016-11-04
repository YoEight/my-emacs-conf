;; helm

(use-package helm
  :config
  (require 'helm-config)
  (require 'helm)
  ;;(setq helm-ff-transformer-show-only-basename nil
  ;;      ;;helm-adaptive-history-file             ers-helm-adaptive-history-file
  ;;      helm-boring-file-regexp-list           '("\\.git$" "\\.svn$" "\\.elc$")
  ;;      helm-yank-symbol-first                 t
  ;;      helm-buffers-fuzzy-matching            t
  ;;      helm-ff-auto-update-initial-value      t
  ;;      helm-input-idle-delay                  0.1
  ;;      helm-idle-delay                        0.1)
  ;;
  ;;:init (progn
  ;;      (require 'helm-config)
  ;;      (helm-mode t)
  ;;      ;;(helm-adaptative-mode t)
  ;;
        (use-package helm-ag
          :ensure    helm-ag
          :bind      ("C-c a" . helm-ag))
  ;;
  ;;      (use-package helm-descbinds
  ;;        :ensure    helm-descbinds
  ;;        :bind      ("C-h b"   . helm-descbinds))
  ;;
  ;;      (add-hook 'eshell-mode-hook
  ;;                #'(lambda ()
  ;;                    (bind-key "M-p" 'helm-eshell-history eshell-mode-map)))
  ;;
        (use-package helm-swoop
          :ensure    helm-swoop
          :bind      (("C-x c s" . helm-swoop) ;;("C-x c s" . helm-swoop)
		      ))


  ;; ag
  (use-package helm-ag
    :ensure    helm-ag
    :bind      ("C-c a" . helm-ag))

  ;; swoop
  (use-package helm-swoop
    :ensure    helm-swoop
    :bind      (("C-c o" . helm-swoop) ;;("C-x c s" . helm-swoop)
                      ("C-c M-o" . helm-multi-swoop)))

  ;; Activate Helm.
  (helm-mode 1)
  (with-eval-after-load "yoeight-project"
    (use-package helm-projectile
      ;; A binding for using Helm to pick files using Projectile,
      ;; and override the normal grep with a Projectile based grep.
      :bind (("C-c C-f" . helm-projectile-find-file-dwim)
             ("C-x C-g" . helm-projectile-grep))))
  ;; Tell Helm to resize the selector as needed.
  (helm-autoresize-mode 1)
  ;; Make Helm look nice.
  (setq-default helm-display-header-line nil
                helm-autoresize-min-height 10
                helm-autoresize-max-height 35
                helm-split-window-in-side-p t

                helm-M-x-fuzzy-match t
                helm-buffers-fuzzy-matching t
                helm-recentf-fuzzy-match t
                helm-apropos-fuzzy-match t)
  (set-face-attribute 'helm-source-header nil :height 0.75)

  ;; custum style
  (set-face-attribute 'helm-selection nil
                      :background "orange"
                      :foreground "black")

  ;; Replace common selectors with Helm versions.
  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x C-g" . helm-do-grep)
         ;;("C-x b" . helm-buffers-list) ;; use ido-virtual-buffers
	       ("C-x b"   . helm-mini) ;; uses recentf
         ;;("C-x c g" . helm-google-suggest)
         ("C-t"     . helm-imenu)
	       ("C-c h o" . helm-occur)
         ("M-y"     . helm-show-kill-ring))
         ;;("C-x r l" . helm-bookmarks)
         ;;("C-x C-m" . helm-M-x)
         ;;("C-h a"   . helm-apropos)
         ;;("C-x p" .   helm-top)
         ;;("C-x C-b" . helm-buffers-list)
      	 ("C-x b"   . helm-mini) ;; uses recentf
         ("C-t" . helm-imenu)
      	 ("C-h a"   . helm-apropos)
         ("C-x p"   .   helm-top)
      	 ;;("C-c h o" . helm-occur)
         ("M-y"     . helm-show-kill-ring))
         ;;("C-x b" . helm-buffers-list) ;; use ido-virtual-buffers
         ;;("C-x c g" . helm-google-suggest)


;; Enrich isearch with Helm using the `C-S-s' binding.
;; swiper-helm behaves subtly different from isearch, so let's not
;; override the default binding.
(use-package swiper-helm
  :bind (("C-S-s" . swiper-helm)))

;; Bind C-c C-e to open a Helm selection of the files in your .emacs.d.
;; We get the whole list of files and filter it through `git check-ignore'
;; to get rid of transient files.
(defun yoeight-helm/gitignore (root files success error)
  (let ((default-directory root))
    (let ((proc (start-process "gitignore" (generate-new-buffer-name "*gitignore*")
                               "git" "check-ignore" "--stdin"))
          (s (lambda (proc event)
               (if (equal "finished\n" event)
                   (funcall success
                            (with-current-buffer (process-buffer proc)
                              (s-split "\n" (s-trim (buffer-string)))))
                 (funcall error event))
               (kill-buffer (process-buffer proc))
               (delete-process proc))))
      (set-process-sentinel proc s)
      (process-send-string proc (concat (s-join "\n" files) "\n"))
      (process-send-eof proc))))

(defun yoeight-helm/files-in-repo (path success error)
  (let ((files (f-files path nil t)))
    (yoeight-helm/gitignore path files
                         (lambda (ignored)
                           (funcall success (-difference files ignored)))
                         error)))

(defun yoeight-helm/find-files-in-emacs-d ()
  (interactive)
  (yoeight-helm/files-in-repo
   dotfiles-dir
   (lambda (files)
     (let ((relfiles (-filter
                      (lambda (f) (not (f-descendant-of? f ".git")))
                      (-map (lambda (f) (f-relative f dotfiles-dir)) files))))
       (find-file
        (concat dotfiles-dir
                (helm :sources (helm-build-sync-source ".emacs.d" :candidates relfiles)
                      :ff-transformer-show-only-basename helm-ff-transformer-show-only-basename
                      :buffer "*helm emacs.d*")))))
   (lambda (err) (warn "yoeight-helm/find-files-in-emacs-d: %s" err))))

(global-set-key (kbd "C-c C-e") 'yoeight-helm/find-files-in-emacs-d)



(provide 'yoeight-helm)
