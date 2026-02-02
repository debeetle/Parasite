;; early-init.el -*- lexical-binding: t; -*-
(setq gc-cons-threshold (* 1024 1024 128)
	  gc-cons-percentage 1.0)
(add-hook 'emacs-startup-hook (lambda () (setq gc-cons-threshold (* 1024 1024 2)
												 gc-cons-percentage 0.2))) ;; restore after startup
(setq read-process-output-max (* 1024 1024)) ;; 1mb
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(prefer-coding-system 'utf-8)
(setq package-archives '(("gnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
						 ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;; (when (file-exists-p custom-file)
(load custom-file)
(add-to-list 'load-path (expand-file-name "user-lisp" user-emacs-directory))
