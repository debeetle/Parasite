;; (require 'package )
(setq package-archives '(("gnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
						 ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(add-to-list 'custom-theme-load-path "/home/chaos/.config/emacs/themes")
;; (defun my/daemon-theme (frame)
;; (with-selected-frame frame
;; (mapc #'enable-theme custom-enabled-themes)))
;; (add-hook 'after-make-frame-functions #'my/daemon-theme)

(defun my/hanfont-scale ()
  (set-fontset-font t 'han (font-spec :family "STZhongsong"))
  (setq face-font-rescale-alist '(("STZhongsong" . 0.95))))
(add-hook 'server-after-make-frame-hook #'my/hanfont-scale)
(defun my/apply-theme (theme)
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme theme t))

;; For performance
;; (load "server")
;; (unless (server-running-p) (server-start))
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb

(add-hook 'emacs-startup-hook #'(lambda () (setq gc-cons-threshold (* 100 1024 1024)))) ;; restore after startup
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq id-enable-flex-matching nil)
(ido-mode t)
(ido-everywhere nil)
(icomplete-mode t)
(fido-mode t)
(visual-line-mode t)
(blink-cursor-mode 0)
(electric-pair-mode t) ;; auto pair
(column-number-mode t)
(show-paren-mode t)                       ;; Show closing parens by default
(global-auto-revert-mode t)               ;; Auto-update buffer if file has changed on disk

;; (delete-selection-mode t)                 ;; Selected text will be overwritten when you start typing
(setq-default cursor-type 'bar)

(setq-default tab-width 4)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(setq display-line-numbers-current-absolute t)
(add-hook 'pdf-view-mode-hook #'(lambda () (display-line-numbers-mode 0)))
(add-hook 'image-mode-hook #'(lambda () (display-line-numbers-mode 0)))
(setq-default mode-line-format
			  (delete '(vc-mode vc-mode) mode-line-format))
;; (setq display-time-day-and-date 1)
;; (display-time-mode t)

(setq make-backup-files nil) ;关闭文件自动备份
(setq auto-save-visited-file-name t)
(setq auto-save-file-name-transforms
	  '((".*" "/home/chaos/.config/emacs/auto-save/" t)))
(setq inhibit-startup-screen t)           ; Disable startup screen
(setq initial-scratch-message "")
(setq ring-bell-function 'ignore)         ; Disable bell sound
;; (setq linum-format "%4d ")                ; Line number format
(setq-default frame-title-format '("%b")) ; Make window title the buffer name
(fset 'yes-or-no-p 'y-or-n-p)             ; y-or-n-p makes answering questions faster
(add-hook 'before-save-hook
	      'delete-trailing-whitespace)    ; Delete trailing whitespace on save
;; Lockfiles unfortunately cause more pain than benefit
(setq create-lockfiles -1)

;; (setq locale-coding-system 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (set-selection-coding-system 'utf-8)
;; (prefer-coding-system 'utf-8)
(setq completion-auto-help 'always)
(setq completion-auto-select 'second-tab)
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; (setq package-ignore-packages '(tree-sitter tsc))
;; (unless package--initialized (package-initialize))

;; (use-package rime
;; :custom
;; (default-input-method "rime"))

;; (add-hook 'prog-mode-hook #'show-paren-mode) ;高亮另一个括号

(setq backup-inhibited t)
(add-hook 'prog-mode-hook #'hs-minor-mode) ;编程模式下，可以折叠代码块
(setq font-lock-maximum-decoration t)
(setq scroll-margin 5
	  scroll-conservatively 10000)
(transient-mark-mode t)
(setq kill-ring-max 30)

(add-to-list 'default-frame-alist '(font . "Source Code Pro-10:weight=medium"))
;; (set-face-attribute 'default nil :family "Source Code Pro" :height 102 :weight 'medium)

;; (switch-to-buffer "*scratch*")
(require 'ffap)
(ffap-bindings)

(add-to-list 'eglot-server-programs
			 '(html-mode . ("vscode-html-language-server" "--stdio")))
(add-hook 'html-mode-hook #'eglot-ensure)

(add-to-list 'load-path "/usr/share/asymptote")
(autoload 'asy-mode "asy-mode.el" "Asymptote major mode." t)
(autoload 'lasy-mode "asy-mode.el" "hybrid Asymptote/Latex major mode." t)
(autoload 'asy-insinuate-latex "asy-mode.el" "Asymptote insinuate Latex." t)
(add-to-list 'auto-mode-alist '("\\.asy$" . asy-mode))
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))
;; (add-to-list 'auto-mode-alist '("\\.asy\\'" . simpc-mode))
(require 'flypy)
(require 'evil)
(evil-mode 0)
(add-to-list 'auto-mode-alist '("\\.service\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.timer\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.target\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.mount\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.automount\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.slice\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.socket\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.path\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.netdev\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.network\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.link\\'" . conf-unix-mode))



;; (custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
;; )

(use-package eglot-booster
  :after eglot
  :config (eglot-booster-mode))
(setq eglot-booster-io-only t)
(add-to-list 'eglot-server-programs
			 '(asy-mode . ("asy" "-lsp")))
;; (add-hook 'asy-mode-hook 'eglot-ensure)
(use-package prettier-js)
(add-hook 'html-mode-hook 'prettier-js-mode)
(add-hook 'js-mode-hook 'prettier-js-mode)
(setq prettier-js-args '("--print-width" "8192"))
(use-package indent-bars
  :custom
  (indent-bars-no-descend-lists t) ; no extra bars in continued func arg lists
  (indent-bars-treesit-support t)
  (indent-bars-treesit-ignore-blank-lines-types '("module"))
  ;; Add other languages as needed
  (indent-bars-treesit-scope '((python function_definition class_definition for_statement
									   if_statement with_statement while_statement)))
  ;; Note: wrap may not be needed if no-descend-list is enough
  ;;(indent-bars-treesit-wrap '((python argument_list parameters ; for python, as an example
  ;;				      list list_comprehension
  ;;				      dictionary dictionary_comprehension
  ;;				      parenthesized_expression subscript)))
  :hook ((python-base-mode yaml-mode) . indent-bars-mode))
(use-package typst-ts-mode
  :vc (:url "https://codeberg.org/meow_king/typst-ts-mode.git")
  ;; :ensure (:type git :host codeberg :repo "meow_king/typst-ts-mode" :branch "develop")
  :custom
  (typst-ts-watch-options "--open")
  (typst-ts-mode-grammar-location (expand-file-name "tree-sitter/libtree-sitter-typst.so" user-emacs-directory))
  (typst-ts-mode-enable-raw-blocks-highlight t)
  :config
  (keymap-set typst-ts-mode-map "C-c C-c" #'typst-ts-tmenu))

;; (custom-set-variables
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
;;  '(custom-safe-themes
;;    '("9c6aa7eb1bde73ba1142041e628827492bd05678df4d9097cda21b1ebcb8f8b9"
;; 	 "fdd5161b0ff03d8bdc2356d0a99dfecdc8c4824ea937d39ae2cd0aee2abea6c6"
;; 	 default))
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
