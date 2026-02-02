;;; init.el --Emacs config -*- lexical-binding: t -*-
;; (require 'package )

;; For performance
(setq mouse-select-window nil)
(setq select-active-regions nil)
(setq mouse-drag-copy-region nil)
(setq id-enable-flex-matching nil)
(setq indent-tabs-mode t)
(ido-mode t)
(ido-everywhere nil)
(icomplete-mode t)
(setq icomplete-compute-delay 0.01)
(fido-mode t)
(visual-line-mode t)
(blink-cursor-mode 0)
(electric-pair-mode t)
(column-number-mode t)
(show-paren-mode t)                       ;; Show closing parens by default
(global-auto-revert-mode t)               ;; Auto-update buffer if file has changed on disk
(delete-selection-mode t)                 ;; Selected text will be overwritten when you start typing
(setq-default cursor-type 'bar)
(setq-default tab-width 4)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(setq display-line-numbers-current-absolute t)
(add-hook 'pdf-view-mode-hook #'(lambda () (display-line-numbers-mode 0)))
(require 'image)
(add-hook 'image-mode-hook #'(lambda () (display-line-numbers-mode 0)))
(setq-default mode-line-format (delete '(vc-mode vc-mode) mode-line-format))
;; (setq display-time-day-and-date 1)
;; (display-time-mode t)

(setq make-backup-files nil) ;关闭文件自动备份
(setq auto-save-visited-file-name t)
(setq auto-save-file-name-transforms '((".*" "/home/chaos/.config/emacs/auto-save/" t)))
(setq inhibit-startup-screen t)           ; Disable startup screen
;; (setq initial-scratch-message "")
(setq ring-bell-function 'ignore)         ; Disable bell sound
;; (setq linum-format "%4d ")                ; Line number format
;; (setq-default frame-title-format '("%b")) ; Make window title the buffer name
(setq read-answer-short t)
;; (fset 'yes-or-no-p 'y-or-n-p)             ; y-or-n-p makes answering questions faster
(add-hook 'before-save-hook 'delete-trailing-whitespace)    ; Delete trailing whitespace on save
;; Lockfiles unfortunately cause more pain than benefit
(setq create-lockfiles -1)

;; (setq locale-coding-system 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (set-selection-coding-system 'utf-8)
(setq completion-auto-help 'always)
(setq completion-auto-select 'second-tab)
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; (use-package rime
;; :custom
;; (default-input-method "rime"))

(setq backup-inhibited t)
(add-hook 'prog-mode-hook #'hs-minor-mode) ;编程模式下，可以折叠代码块
(setq font-lock-maximum-decoration t)
(setq scroll-margin 5
	  scroll-conservatively 10000)
(transient-mark-mode t)
(setq kill-ring-max 30)
(setq enable-recursive-minibuffers t)
(setq which-func-update-delay 1.0)
(setq idle-update-delay which-func-update-delay)
(setq vc-make-backup-files nil)
(setq vc-git-diff-switches '("--histogram"))

(setq window-resize-pixelwise nil)
(setq-default word-wrap t)
(setq-default cursor-in-non-selected-windows nil)

(add-to-list 'custom-theme-load-path "/home/chaos/.config/emacs/themes")
;; (defun my/daemon-theme (frame)
;; (with-selected-frame frame
;; (mapc #'enable-theme custom-enabled-themes)))
;; (add-hook 'after-make-frame-functions #'my/daemon-theme)
(add-to-list 'default-frame-alist '(font . "Source Code Pro-10:weight=medium"))
;; (set-face-attribute 'default nil :family "Source Code Pro" :height 102 :weight 'medium)
(defun my/hanfont-scale ()
  (set-fontset-font t 'han (font-spec :family "STZhongsong"))
  (setq face-font-rescale-alist '(("STZhongsong" . 0.95))))
(add-hook 'server-after-make-frame-hook #'my/hanfont-scale)
(defun my/apply-theme (theme)
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme theme t))
(my/apply-theme 'dracula)

(require 'ffap)
(ffap-bindings)

;; (custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
;; )

(use-package eglot
  :hook
  ((html-mode . eglot-ensure)
   (simpc-mode . eglot-ensure)
   (python-mode . eglot-ensure)
   (asy-mode . eglot-ensure)
   )
  :config
  ;; (add-to-list 'eglot-server-programs
  ;; '(html-mode . ("vscode-html-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs
			   '(asy-mode . ("asy" "-lsp")))
  (add-to-list 'eglot-server-programs
			   '(simpc-mode . ("clangd")))
  (setq eglot-events-buffer-size 0)
  (setq eglot-autoshutdown t)
  (setq jsonrpc-event-hook nil)
  :bind ("C-c f" . eglot-format)
  )

(use-package eglot-booster
  :ensure nil
  :after eglot
  :config
  (eglot-booster-mode)
  (setq eglot-booster-io-only t))

(use-package tree-sitter
  :ensure t
  )

(use-package corfu
  :ensure t
  :custom
  (corfu-quit-no-match 'separator)
  (corfu-auto t)
  (corfu-auto-delay 0.4)
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode)
  :config
  ;; (defun orderless-fast-dispatch (word index total)
  ;; (and (= index 0) (= total 1) (length< word 4)
  ;; (cons 'orderless-literal-prefix word)))

  ;; (orderless-define-completion-style orderless-fast
  ;; (orderless-style-dispatchers '(orderless-fast-dispatch))
  ;; (orderless-matching-styles '(orderless-literal orderless-regexp)))
  ;; :hook (corfu-mode . (lambda ()
  ;; (setq-local completion-styles '(orderless-fast basic)
  ;; )))
  )

(use-package evil
  :ensure t
  :config
  (setq evil-toggle-key "")
  :bind
  ("C-c e" . evil-mode)
  )

(use-package rainbow-delimiters
  :ensure t
  ;; :hook
  ;; (prog-mode . #'rainbow-delimiters-mode)
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  )

(use-package indent-guide
  :ensure t
  :bind
  ("C-c i" . indent-guide-global-mode)
  )

(use-package flypy
  :ensure nil
  )

(use-package simpc-mode
  :ensure nil
  :mode ("\\.[hc]\\(pp\\)?\\'" . simpc-mode)
  ;; :config
  ;; (autoload 'simpc-mode "~/.config/emacs/user-lisp/simpc-mode.el" t)
  )

(use-package typst-ts-mode
  :vc (:url "https://codeberg.org/meow_king/typst-ts-mode.git")
  ;; :ensure (:type git :host codeberg :repo "meow_king/typst-ts-mode" :branch "develop")
  :custom
  (typst-ts-watch-options "--open")
  (typst-ts-mode-grammar-location (expand-file-name "tree-sitter/libtree-sitter-typst.so" user-emacs-directory))
  (typst-ts-mode-enable-raw-blocks-highlight t)
  :config
  (keymap-set typst-ts-mode-map "C-c C-c" #'typst-ts-tmenu)
  )

(use-package asy-mode
  :ensure nil
  :load-path "/usr/share/asymptote"
  :mode ("\\.asy$" . asy-mode)
  :config
  (autoload 'asy-mode "asy-mode.el" "Asymptote major mode." t)
  (autoload 'lasy-mode "asy-mode.el" "hybrid Asymptote/Latex major mode." t)
  (autoload 'asy-insinuate-latex "asy-mode.el" "Asymptote insinuate Latex." t)
  :hook (asy-mode . (lambda ()
					  (add-hook 'after-save-hook
								(lambda ()
								  (let ((rendersvg (concat "asy -render 2 -f svg " (shell-quote-argument buffer-file-name))))
									(shell-command rendersvg)))
								nil t)))
  )

;; (use-package recentf
;; :init
;; (recentf-mode 1)
;; :config
;; (add-hook 'after-make-frame-functions
;; (lambda (frame)
;; (with-selected-frame frame
;; (when (not (buffer-file-name))
;; (recentf-open-files)))))
;; )

(use-package prettier-js
  :ensure t
  :config
  (setq prettier-js-args '("--print-width" "8192"))
  :hook
  ((html-mode-hook js-mode) . prettier-js-mode)
  )

(use-package conf-mode
  :mode (
		 ("\\.service\\'" . conf-unix-mode)
		 ("\\.timer\\'" . conf-unix-mode)
		 ("\\.target\\'" . conf-unix-mode)
		 ("\\.mount\\'" . conf-unix-mode)
		 ("\\.automount\\'" . conf-unix-mode)
		 ("\\.slice\\'" . conf-unix-mode)
		 ("\\.socket\\'" . conf-unix-mode)
		 ("\\.path\\'" . conf-unix-mode)
		 ("\\.netdev\\'" . conf-unix-mode)
		 ("\\.network\\'" . conf-unix-mode)
		 ("\\.link\\'" . conf-unix-mode)
		 ;; ("\\.[hc]\\(pp\\)?\\'" . simpc-mode)
		 ;; ("\\.asy$" . asy-mode)
		 )
  )

;; (custom-set-variables
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.

;; '(package-selected-packages
;; '(corfu eglot-booster evil expand-region flymake-eslint flymake-ruff
;; flymake-shellcheck indent-bars pdf-tools prettier-js
;; tree-sitter typst-ts-mode))
;; '(package-vc-selected-packages
;; '((eglot-booster :vc-backend Git :url
;; "https://github.com/jdtsmith/eglot-booster"))))
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
(global-set-key (kbd "<C-wheel-up>") 'ignore)
(global-set-key (kbd "<C-wheel-down>") 'ignore)
(global-set-key (kbd "C-;") 'comment-line)
;; (global-unset-key [double-mouse-1])
;; (global-unset-key [triple-mouse-1])
