;; Prevent white flash at startup and disable splash screen
(set-background-color "#282c34")
(setq inhibit-splash-screen t)

;; Package management sources
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org" . "http://orgmode.org/elpa/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Use use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (projectile helm use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Setup theme and remove frame decoration
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t))
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
;;(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq initial-frame-alist '((fullscreen . maximized)))

;; Symbol-completion, auto-pair
(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files)
	 ("C-x f" . helm-recentf)
	 ("C-SPC" . helm-dabbrev)
	 ("M-y" . helm-show-kill-ring)
	 ("C-x b" . helm-buffers-list))
  :bind (:map helm-map
	      ("M-i" . helm-previous-line)
	      ("M-k" . helm-next-line)
	      ("M-I" . helm-previous-page)
	      ("M-K" . helm-next-page)
	      ("M-h" . helm-beginning-of-buffer)
	      ("M-H" . helm-end-of-buffer))
  :config
  (helm-mode 1))
(electric-pair-mode)

;; Projectile
;; (use-package projectile
;;   :ensure t
;;   :config
;;   (projectile-mode 1))

;; Centralize autosave files
(setq backup-directory-alist
      `((".*" . ,(concat user-emacs-directory "backups"))))
(setq auto-save-file-name-transforms
      `((".*" ,(concat user-emacs-directory "backups"))))

;; Quick edit user init file
(defun dlk/find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file user-init-file))

;; Keyboard mapping
(global-set-key (kbd "C-c f i") #'dlk/find-user-init-file)
