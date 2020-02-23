;;; init.el --- David Kern's Emacs configuration

;; Copyright (c) 2020
;; Author: David Kern
;; Keywords:

;; This file is not part of GNU Emacs.

;;; Commentary:

;; This is my personal Emacs configuration.  If you find something useful here,
;; I'm glad.  If you see something I can do better, I'd love to know.

;;; License:

;; Licensed under either of:
;;  * Apache License, Version 2.0 (http://www.apache.org/licenses/LICENSE-2.0)
;;  * MIT License (http://opensource.org/licenses/MIT)
;; at your option.
;;

;;; Contribution:

;; Unless you explicitly state otherwise, any contribution intentionally submitted
;; for inclusion in the work by you, as defined in the Apache-2.0 license, shall be
;; dual licensed as above, without any additional terms or conditions.

;;; Code:

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
 '(package-selected-packages
   (quote
    (magit neotree flycheck-rust toml-mode lsp-ui lsp-mode company flycheck cargo rust-mode projectile helm use-package))))
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
(setq initial-frame-alist '((fullscreen . maximized)))

;; Helm
(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files)
	 ("C-x f" . helm-recentf)
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

;; Auto-pair
(electric-pair-mode)

;; Projectile
(use-package projectile
  :ensure t
  :bind ("C-c p" . projectile-command-map)
  :config
  (projectile-mode 1))

;; Neotree
(use-package neotree
  :ensure t
  :bind ("<f8>" . neotree-toggle)
  :config
  (setq neo-smart-open t)
  (setq projectile-switch-project-action 'neotree-projectile-action)
  (setq neo-theme 'ascii))

;; Magit
(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

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

(global-set-key (kbd "C-c f i") #'dlk/find-user-init-file)

;; Flycheck - syntax checking
(use-package flycheck
  :ensure t
  :hook (prog-mode . flycheck-mode))

;; Company - complete anything
(use-package company
  :ensure t
  :hook (prog-mode . company-mode)
  :config
  (setq company-tooltip-align-annotations t)
  (setq company-minimum-prefix-length 1))

;; Language Server Protocol
(use-package lsp-mode
  :ensure t
  :commands lsp
  :config (require 'lsp-clients))

(use-package lsp-ui
  :ensure t)

;; Rust
(use-package toml-mode
  :ensure t)

(use-package rust-mode
  :ensure t
  :hook (rust-mode . lsp))

(use-package cargo
  :ensure t
  :hook (rust-mode . cargo-minor-mode))

(use-package flycheck-rust
  :ensure t
  :config (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

;;; init.el ends here

