;;;;;;;;;;;;;;;;;;;;;;;
;;; UI usability tweaks
;;;;;;;;;;;;;;;;;;;;;;;

;;; UI Theme
(add-to-list 'custom-theme-load-path "~/emacs/emacs-color-theme-solarized/")
(load-theme 'solarized-dark t)

;;; Always do syntax highlightning
(global-font-lock-mode 1)

;;; Display column index
(column-number-mode t)

;;; Highlight parens
(setq show-paren-delay 0
      show-paren-style 'parenthesis)
(show-paren-mode 1)

;;; Initial scratch message begone
(setq initial-scratch-message nil)

;;; Disable startup message
(setq inhibit-startup-message t)

;;; Disable toolbar, menubar, and scrollbar
(menu-bar-mode 1)
(tool-bar-mode -1)
(scroll-bar-mode 0)

;;; Non-blinking cursor
(blink-cursor-mode 0)

;;; handling of backup files (the infamous ~files)
(setq backup-directory-alist '(("." . "~/.esaves")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 2
      kept-old-versions 1
      version-control t)

;;; Highlight some keywords
(font-lock-add-keywords
 nil '(("\\<\\(FIXME\\|TODO\\|BUG\\)" 1 font-lock-warning-face t)))

;;; UTF-8
(set-language-environment "UTF-8")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment 'utf-8)
(load-library "iso-transl")

;;; Autocomplete
(add-to-list 'load-path "/home/sid/emacs")
(require 'auto-complete-config)
(ac-config-default)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Major modes tweaks and config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; TRAMP Mode
(require 'tramp)
(setq tramp-default-method "ssh")

;; Colored output in M-x shell
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;;; IDO Mode
(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;;; org-mode
(require 'org)
(setq org-directory "~/org")
(org-agenda-files (quote ("~/org/")))
(setq org-startup-indented t)
(setq org-todo-keyword-faces (quote (("STARTED" :foreground "yellow" :weight bold) ("CANCELLED" . org-archived) ("DONE" . "(:foreground \"green\" :weight bold)"))))
(setq org-todo-keywords (quote ((sequence "TODO" "DONE"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-done ((t (:foreground "green" :inverse-video nil :underline nil :slant normal :weight bold))))
 '(org-level-3 ((t (:inherit outline-3 :foreground "SpringGreen3"))))
 '(org-level-4 ((t (:inherit outline-4 :foreground "turquoise"))))
 '(org-todo ((t (:inherit nil :background "#dc322f" :foreground "#002b36" :inverse-video t :underline nil :slant normal :weight bold)))))

(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

(org-babel-do-load-languages
 'org-babel-do-load-languages
 '((R . t)))

;;; Emacs speaks statistics
(require 'ess-site)

;;; Scheme support
(add-to-list 'load-path "~/emacs/")
(require 'quack)
;;; Disable tabs
(setq-default indent-tabs-mode nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(comment-style (quote plain))
 '(quack-default-program "racket"))

;;; Django support
(add-to-list 'load-path "~/emacs/python-django.el/")
(require 'python-django)

(autoload 'django-html-mumamo-mode "~/emacs/nxhtml/autostart.el")
(setq auto-mode-alist
      (append '(("\\.html?$" . django-html-mumamo-mode)) auto-mode-alist))
(setq mumamo-background-colors nil) 
(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mumamo-mode))

;; Workaround the annoying warnings:
;; Warning (mumamo-per-buffer-local-vars):
;; Already 'permanent-local t: buffer-file-name
(when (and (>= emacs-major-version 24)
(>= emacs-minor-version 2))
(eval-after-load "mumamo"
'(setq mumamo-per-buffer-local-vars
(delq 'buffer-file-name mumamo-per-buffer-local-vars))))

;;; YAML mode
(add-to-list 'load-path "~/emacs/yaml-mode/")
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;;; LaTex Support
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; need to relocate these
;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Follow symlinks
(setq vc-follow-symlinks t)

;;; URLs
(setq browse-url-browser-function 'browse-url-firefox
      browse-url-new-window-flag t
      browse-url-firefox-new-window-is-tab t)

;;;; Edit-mode improvements
;;; Auto-fill set to 80 columns
(auto-fill-mode)
(setq fill-column 80)
(add-hook 'org-mode-hook 'turn-on-auto-fill)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Other config files
;;;;;;;;;;;;;;;;;;;;;;;;;;

(load "~/dotfiles/eemacs.el") ;; emacs email config
