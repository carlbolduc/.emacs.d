(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;(setq default-directory "/Users/carl/" )
;(setq mac-right-option-modifier 'none)
;(setq mac-option-modifier 'none)
;(setq mac-command-modifier 'meta)
;(setq mac-right-command-modifier 'meta)
(setq visible-bell 1)
;(setq inhibit-startup-message t)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups/")))
;(tool-bar-mode -1)

;; theme
;(use-package zenburn-theme
;  :ensure t
;  :config
;  (load-theme 'zenburn t))

;; path
;(use-package exec-path-from-shell
;  :ensure t
;  :config
;  (exec-path-from-shell-initialize))

;; navigation
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

;; Completions
(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

;; hydra
(use-package hydra :ensure t)
(defhydra hydra-shortcuts (:color pink :hint nil)


 "
^Files^          ^Search^            ^Apps^
^^^^^^^^-----------------------------------------------
_b_: buffers     _r_: replace        _d_: dired
_f_: find file   _g_: grep project   _e_: eshell
_p_: prettier    ^ ^                 _m_: magit
_!_: errors
"
  ("b" buffer-menu :color blue)
  ("f" projectile-find-file :color blue)
  ("p" prettier-js :color blue)
  ("!" flycheck-list-errors :color blue)
  ("r" query-replace-regexp :color blue)
  ("g" counsel-rg :color blue)
  ("d" counsel-dired :color blue)
  ("m" magit-status :color blue)
  ("e" eshell :color blue)
  ("q" quit-window :color blue)
)
(global-set-key (kbd "M-m") 'hydra-shortcuts/body)

;; lang

;; apps
(use-package magit
  :ensure t
  :config
  (global-set-key (kbd "C-x g") 'magit-status))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (magit hydra company projectile counsel use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
