(add-to-list 'custom-theme-load-path "/home/trunk/.config/emacs/themes")
(load-theme 'dracula t)

;; For performance
;(load "server")
;(unless (server-running-p) (server-start))
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb

(add-hook 'after-init-hook #'(lambda ()
                               ;; restore after startup
                               (setq gc-cons-threshold 800000)))
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(electric-pair-mode t) ;自动补全括号
(column-number-mode t) ;显示列号
(global-display-line-numbers-mode 1)
(require 'display-line-numbers)
(defun display-line-numbers--turn-on ()
  "Turn on `display-line-numbers-mode'."
  (unless (or (minibufferp) (eq major-mode 'pdf-view-mode))
    (display-line-numbers-mode)))
(global-auto-revert-mode t) ;另一程序修改了文件时，及时刷新 Buffer
(delete-selection-mode t) ;选中文本后输入文本会替换文本
(display-time)
(setq make-backup-files -1) ;关闭文件自动备份
(setq inhibit-startup-screen t)           ; Disable startup screen
(setq initial-scratch-message "")         ; Make *scratch* buffer blank
(setq ring-bell-function 'ignore)         ; Disable bell sound
(setq linum-format "%4d ")                ; Line number format
(setq-default frame-title-format '("%b")) ; Make window title the buffer name
(fset 'yes-or-no-p 'y-or-n-p)             ; y-or-n-p makes answering questions faster
(show-paren-mode t)                       ; Show closing parens by default
(delete-selection-mode t)                 ; Selected text will be overwritten when you start typing
(global-auto-revert-mode t)               ; Auto-update buffer if file has changed on disk
(add-hook 'before-save-hook
	  'delete-trailing-whitespace)    ; Delete trailing whitespace on save
;;; Lockfiles unfortunately cause more pain than benefit
(setq create-lockfiles -1)
;; (desktop-save-mode 1)
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(require 'package )
(setq package-enable-at-startup -1)
(setq package-archives '(("gnu" . "https://mirrors.bfsu.edu.cn/elpa/gnu/")
			 ("melpa" . "https://mirrors.bfsu.edu.cn/elpa/melpa/")))
(unless package--initialized (package-initialize))

;;; Setup use-package
;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package))
;; (eval-when-compile
;;   (require 'use-package))
;; (setq use-package-always-ensure t)

(switch-to-buffer "*scratch*")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(current-language-environment "UTF-8")
 '(debug-on-error t)
 '(default-major-mode 'text-mode t)
 '(display-line-numbers-type 'relative)
 '(enable-recursive-minibuffers t)
 '(minibuffer-depth-indicate-mode t)
 '(package-selected-packages
   '(auctex tree-sitter flymake-lua flymake-css flymake-yaml flymake-shell flymake-ruff corfu))
 '(select-enable-clipboard t))

;; (add-hook 'prog-mode-hook #'show-paren-mode) ;高亮另一个括号

(setq backup-inhibited t)
(add-hook 'prog-mode-hook #'hs-minor-mode) ;编程模式下，可以折叠代码块

(global-set-key (kbd "C-;") 'comment-line)
(setq font-lock-maxium-decoration t)
(setq scroll-margin 5
      scroll-conservatively 10000)
(transient-mark-mode t)
(setq kill-ring-max 30)
(setq default-frame-alist '((font . "Operator Mono-12:weight=Medium:slant=Normal")))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;(provide 'init)
;;(add-to-list 'load-path "~/.config/emacs/site-lisp/emacs-application-framework/")
;;(require 'eaf)
;;(require 'eaf-browser)
;;(require 'eaf-pdf-viewer)
;(let ((params (frame-parameters)))
