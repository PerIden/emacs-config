(require 'package)
  (package-initialize)
  (add-to-list 'package-archives
	   '("melpa-stable" . "http://stable.melpa.org/packages/") t)
  (package-refresh-contents)

(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

(global-set-key (kbd "<s-return>" )  'ansi-term)

(defalias 'yes-or-no-p 'y-or-n-p)

(global-hl-line-mode t)

(use-package beacon
  :ensure t
  :init
  (beacon-mode 1))

(global-subword-mode 1)

(setq electric-pair-pairs '(
			    (?\( . ?\))
			    (?\[ . ?\])
			    ))
(electric-pair-mode t)

(setq scroll-conservatively 100)

(setq inhibit-startup-message t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(line-number-mode 1)
(column-number-mode 1)

(defvar myPackages
      '(better-defaults
        elpy
        flycheck
        material-theme
        )
      )


  (unless (package-installed-p 'elpy)
    (package-refresh-contents)
    (package-install 'elpy))
  (use-package elpy
    :ensure t
    :init)
(elpy-enable)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(org-babel-do-load-languages
 'org-babel-load-languages '((python . t)
                             (emacs-lisp . t )
                             (scheme . t)
                             ))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda ()  (org-bullets-mode))))

(global-set-key (kbd "M-s-RET") 'org-insert-todo-heading )

(setq ido-enable-flex-matching nil )
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)

(use-package ido-vertical-mode
    :ensure t
    :init
    (ido-vertical-mode 1))
  (setq ido-vertical-define-keys 'C-n-and-C-p-only)

(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

(use-package smex
  :ensure t
  :init (smex-initialize)
  :bind
  ("M-x" . smex))

(global-set-key (kbd "C-x b") 'ibuffer)

(use-package avy
     :ensure t
  :bind
  ("M-s" . avy-goto-char))

(defun config-visit ()
  (interactive)
  (find-file "~/.emacs.d/config.org"))
(global-set-key (kbd "C-c e") 'config-visit)

(defun config-reload()
       (interactive)
       (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))
(global-set-key (kbd "C-c r") 'config-reload)

(use-package dashboard
  :init
  (add-hook 'after-init-hook 'dashboard-refresh-buffer)
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo )
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 10)))
  (setq dashboard-banner-logo-title "I am the bone of my sword"))

(use-package symon
  :ensure t
  :bind
 ( "M-ö" . symon-mode))

(use-package swiper
  :ensure t
  :bind("C-s" . swiper))

(global-font-lock-mode 1)
(setq show-paren-delay 0
      show-paren-style 'parenthesis)
(show-paren-mode 1)

(load-file "~/Documents/SICP/geiser/elisp/geiser.el")
(load "~/Documents/SICP/geiser/build/elisp/geiser-load")
  (require 'geiser-install)

;(require 'package)
;;; either the stable version:

;(add-to-list 'package-archives
  ;; choose either the stable or the latest git version:
;   '("melpa-stable" . "http://stable.melpa.org/packages/"))
  ;; '("melpa-unstable" . "http://melpa.org/packages/"))

;(package-initialize)


;(use-package geiser
;    :ensure t
;    :config
;    (setq geiser-active-implementations '(chicken))
;    (setq geiser-chicken-compile-geiser-p nil)
;    (require 'geiser)
;    (add-hook 'scheme-mode-hook 'geiser-mode)
;    (add-to-list 'auto-mode-alist '("\\.scm\\'" . geiser-mode)))

(visual-line-mode t)

(defun django-shell ()
  (interactive)
  (let ((python-shell-interpreter (read-file-name "Locate manage.py "))
        (python-shell-interpreter-args "shell"))
    (run-python (python-shell-calculate-command) nil t)))

(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet-snippets
    :ensure t)
    (yas-reload-all))

(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (setq web-mode-engines-alist
        '(("django" . "\\.html\\ '")))
  (setq web-mode-ac-sources-alist
        '(("css" . (ac-source-css-property))
          ("html" . (ac-source-words-in-buffer ac-source-abbrrev))))
  (setq web-mode-enable-auto-closing t))

(use-package meghanada
  :ensure t
  :diminish meghanada-mode "Mm"
  :config
  (add-hook 'java-mode-hook
            (lambda ()
              (meghanada-mode t)
              (flycheck-mode t)
              (company-mode t)
              (add-hook 'before-save-hook 'delete-trailing-whitespace))))
