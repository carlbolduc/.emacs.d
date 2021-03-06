(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq inhibit-startup-screen t)
;(setq default-directory "/Users/carl/" )
;(setq mac-right-option-modifier 'none)
;(setq mac-option-modifier 'none)
;(setq mac-command-modifier 'meta)
;(setq mac-right-command-modifier 'meta)
(setq visible-bell 1)
;(setq inhibit-startup-message t)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups/")))
(tool-bar-mode -1)

;;; sensible editing defaults
;; turn on highlight matching brackets when cursor is on one
(show-paren-mode 1)
;; auto close bracket insertion.
(electric-pair-mode 1)
;; overwrite when pasting
(delete-selection-mode 1)

;;; look
(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))
(if window-system
    (set-frame-font "Input Mono-13" nil t))

;;; navigation
(use-package counsel
 :ensure t
 :config
 (global-set-key (kbd "C-s") 'swiper-isearch)
 (global-set-key (kbd "C-x C-f") 'counsel-find-file)
 (global-set-key (kbd "C-x b") 'counsel-switch-buffer)
 (global-set-key (kbd "M-x") 'counsel-M-x))
(use-package projectile
   :ensure t
   :config
   (setq projectile-completion-system 'ivy))

;;; Completions
(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

;;; Search
(use-package deadgrep :ensure t)

;;; Tasks
;(use-package taskrunner :ensure t)

;;; hydra
(use-package hydra :ensure t)
(defhydra hydra-shortcuts (:color pink :hint nil)


 "
^Files^          ^Search^            ^Apps^        ^Code^
^^^^^^^^----------------------------------------------------------
_b_: buffers     _%_: replace        _o_: dired    _d_: definition
_f_: find file   _/_: grep project   _e_: eshell   _r_: references
_p_: prettier    ^ ^                 _m_: magit
_!_: errors
"
  ("b" buffer-menu :color blue)
  ("f" projectile-find-file :color blue)
  ("p" prettier-js :color blue)
  ("!" flycheck-list-errors :color blue)
  ("%" query-replace-regexp :color blue)
;  ("g" counsel-rg :color blue)
  ("/" deadgrep :color blue)
  ("o" counsel-dired :color blue)
  ("e" eshell :color blue)
  ("m" magit-status :color blue)
  ("d" lsp-find-definition :color blue)
  ("r" lsp-find-references :color blue)
  ("q" quit-window :color blue)
)
(global-set-key (kbd "M-m") 'hydra-shortcuts/body)



(setq lsp-keymap-prefix "C-c l")

(use-package lsp-mode
  :ensure t
  :hook (
         (js-mode . lsp))
  :commands lsp)
(use-package lsp-java
  :ensure t
  :config
  (setq lombok-jar-path
	(expand-file-name
         "~/.emacs.d/vendor/lombok.jar"
	 )
	)
  (setq lsp-java-vmargs `(
			  "-Xmx1G"
			  ,(concat "-javaagent:" lombok-jar-path)
			  ,(concat "-Xbootclasspath/a:" lombok-jar-path)
			  )
	)
  (add-hook 'java-mode-hook 'lsp))

;; optionally
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

;;; lang

;; JavaScript
(defun my-js-mode-hook ()
  (setq indent-tabs-mode nil tab-width 2 js-indent-level 2)
(add-hook 'js-mode-hook 'my-js-mode-hook))

;; Web templates
(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.php?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.twig?\\'" . web-mode))
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook
 'web-mode-hook
 (lambda ()
   (setq-local electric-pair-inhibit-predicate
               `(lambda (c)
                  (if (char-equal c ?{) t (,electric-pair-inhibit-predicate c))))))

;;; apps
(use-package magit :ensure t)

(use-package olivetti :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(taskrunner deadgrep web-mode magit hydra company projectile counsel use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
