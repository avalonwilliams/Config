;; Hide GUI elements
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; Make "yes or no" prompts take 'y' or 'n' as input
(fset 'yes-or-no-p 'y-or-n-p)

;; Make menu-bar-open use a keyboard-centric interface
(if (display-graphic-p)
    (fset 'menu-bar-open 'tmm-menubar))

;; I can manage my configuration myself, damn it!
(setq custom-file "/dev/null")


;;======= Indentation =======

(setq-default indent-tabs-mode nil)
(setq tab-width 4)

(defvaralias 'c-basic-offset 'tab-width)


;;======= Package management ========

(require 'package)

;; package-archives (eg. MELPA) 
(add-to-list 'package-archives 
	     '("MELPA" . "http://melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)


;;======= Packages =======
(use-package magit)
(use-package company)

(use-package projectile
  :config
  (setq projectile-project-search-path '("~/src/")))

(use-package helm
  :init
  (helm-mode 1))

(use-package helm-system-packages
  :requires helm)

(use-package helm-projectile
  :requires (helm projectile))

(use-package org-bullets
  :config
  (require 'org-bullets)
  (add-hook 'org-mode-hook
            (lambda ()
              (org-bullets-mode 1))))

(use-package anzu
  :config
  (setq anzu-cons-mode-line-p nil)
  (global-anzu-mode t))

;;======= Vim Emulation =======

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)

  ;; Make evil not clobber clipboard
  (setq x-select-enable-clipboard nil)

  ;; Make keybindings 
  (define-key evil-normal-state-map (kbd "gbb")
    (lambda () (interactive) (compile "make")))

  (define-key evil-normal-state-map (kbd "gbc")
    (lambda () (interactive) (compile "make clean")))

  (define-key evil-normal-state-map (kbd "gbd")
    (lambda () (interactive) (compile "make debug")))

  (define-key evil-normal-state-map (kbd "gbr")
    (lambda () (interactive) (shell-command "make run")))

  ;; nicer window switching
  (define-key evil-normal-state-map (kbd "C-h")
    'evil-window-left)

  (define-key evil-normal-state-map (kbd "C-j")
    'evil-window-down)

  (define-key evil-normal-state-map (kbd "C-k")
    'evil-window-up)

  (define-key evil-normal-state-map (kbd "C-l")
    'evil-window-right)

  ;; ibuffer
  (define-key evil-normal-state-map (kbd "C-i")
    'ibuffer))

(use-package evil-collection
  :requires evil
  :config
  (evil-collection-init))

;; More accurate vim-like incrementing and decrementing
(use-package evil-numbers
  :requires evil
  :config
  (define-key evil-normal-state-map (kbd "C-a")
    'evil-numbers/inc-at-pt)
  ;; Can't bind to C-x because of conflicts
  (define-key evil-normal-state-map (kbd "C-s")
    'evil-numbers/dec-at-pt))

;; Org mode
(use-package evil-org
  :requires evil
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;; Nerd commenter
(use-package evil-nerd-commenter
  :requires evil
  :config
  (evilnc-default-hotkeys)
  (define-key evil-normal-state-map (kbd "gc")
    'evilnc-comment-or-uncomment-lines))

;; Magit support
(use-package evil-magit
  :requires (magit evil))

;; Anzu support
(use-package evil-anzu
  :requires (evil anzu))


;;======= Line numbers =======

;; Display real line number on current line
(use-package linum-relative
  :config
  (setq linum-relative-current-symbol "")
  (set-face-attribute 'linum nil
                      :background "unspecified-bg")
  (set-face-attribute 'linum-relative-current-face nil
                      :foreground "#f2fa9c"
                      :background "unspecified-bg"
                      :inherit 'linum)

  (if (display-graphic-p)
      (add-hook
       'prog-mode-hook
       'linum-relative-mode)))


;;======= Theming =======

;; Display window numbers
(use-package window-numbering
  :config
  (window-numbering-mode t))

;; Powerline (spaceline)
(use-package spaceline 
  :requires helm
  :after window-numbering
  :config
  (require 'spaceline-config)
  (setq powerline-height 19)

  (if (display-graphic-p)
      (setq spaceline-window-numbers-unicode t))

  (setq powerline-default-separator 'wave)

  (setq spaceline-highlight-face-func
        'spaceline-highlight-face-evil-state)
 
  (spaceline-spacemacs-theme)
  (spaceline-helm-mode))

;; Dracula theme
(use-package dracula-theme
  :after (company spaceline)
  :config
  (load-theme 'dracula t)

  ;; Make top-level headings in org mode slightly smaller
  (set-face-attribute 'org-level-1 nil
                      :height 1.25)

  ;; Make company look nicer
  (when (featurep 'company)
    (set-face-attribute 'company-tooltip nil
                        :background "#373844"))

  ;; Spaceline evil mode colors
  (when (featurep 'spaceline)
    (set-face-attribute 'spaceline-evil-insert nil
                        :foreground "#373845"
                        :background "#8be9fd"
                        :inherit 'mode-line)

    (set-face-attribute 'spaceline-evil-normal nil
                        :foreground "#373845"
                        :background "#50fa7b"
                        :inherit 'mode-line)

    (set-face-attribute 'spaceline-evil-visual nil
                        :foreground "#373845"
                        :background "#ffb86c"
                        :inherit 'mode-line)

    (set-face-attribute 'spaceline-evil-replace nil
                        :foreground "#373845"
                        :background "#ff5555"
                        :inherit 'mode-line)

    (set-face-attribute 'spaceline-evil-motion nil
                        :foreground "#373845"
                        :background "#bd93f9"
                        :inherit 'mode-line)

    (set-face-attribute 'spaceline-evil-emacs nil
                        :foreground "#373845"
                        :background "#f1fa8c"
                        :inherit 'mode-line)))


;;======= Language-server protocol support =======

(use-package flycheck 
  :config
  (setq-default flycheck-disabled-checkers 
                '(c/c++-clang c/c++-cppcheck c/c++-gcc)))

(use-package yasnippet)

(use-package lsp-mode
  :requires (flycheck yasnippet company projectile)
  :config
  ;; Keybindings
  (evil-define-key 'normal 'global (kbd "glr")
    'lsp-rename))

(use-package helm-lsp
  :requires (lsp-mode helm))

(use-package lsp-ui
  :requires lsp-mode
  :init
  (setq lsp-ui-flycheck-enable t)
  (setq lsp-perfer-flymake nil)
  :hook (lsp-mode . lsp-ui-mode))

(defun generic-lsp-hook ()
  (yas-minor-mode t)
  (flycheck-mode t)
  (lsp)
  (flymake-mode -1))

(use-package company-lsp
  :requires (company lsp-mode)
  :init
  (push 'company-lsp company-backends))

(use-package cquery
  :requires lsp-mode
  :init
  (setq cquery-executable "~/cquery/build/release/bin/cquery")
  (setq cquery-cache-dir "~/.cache/cquery")
  (add-hook 'c-mode-hook #'generic-lsp-hook)
  (add-hook 'c++-mode-hook #'generic-lsp-hook))


;;======= EMMS =======
(use-package emms
  :config
  (require 'emms-setup)
  (emms-standard)
  (emms-default-players))


;;======= Misc Settings =======

(use-package dtrt-indent
  :init
  (dtrt-indent-global-mode 1))

;; Mouse support
(xterm-mouse-mode 1)

;; Prevent emacs from leaving a mess
(use-package no-littering
  :config
  (setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t))))

;; Latex previewer
(use-package latex-preview-pane)

;; Diminish
(use-package diminish
  :config
  (diminish 'helm-mode "")
  (diminish 'dtrt-indent-mode "")
  (diminish 'undo-tree-mode "")
  (diminish 'auto-revert-mode "")
  (when (display-graphic-p)
       (diminish 'linum-relative-mode "")
       (diminish 'anzu-mode "")
       (diminish 'flyspell-mode "")))

(use-package neotree
  :config
  (global-set-key [f8] 'neotree-toggle))

;; (add-to-list 'org-agenda-files
;;              ("~/Agenda"
;;               "~/TODO.org"))

(setq org-agenda-files
      '("~/Agenda" "~/TODO.org"))

;; TODO
;;   - Fix issues with C/C++ LSP support
;;   - Reorganize ~/.emacs.el so it has more logical sorting
