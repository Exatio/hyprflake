;;;
;;; Adapted from https://github.com/rexim/dotfiles
;;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(use-package emacs
  :ensure nil
  :init
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (scroll-bar-mode 0)
  (column-number-mode 1)
  (global-display-line-numbers-mode)
  (set-default-coding-systems 'utf-8)
  (setq backup-directory-alist `(("." . ,(expand-file-name "backup/" user-emacs-directory))))

  :custom
  ;; General Settings
  (custom-file "~/.emacs.d/.emacs.custom.el")
  (create-lockfiles nil)             ; no .# files
  (ring-bell-function 'ignore)       ; no sound
  (use-short-answers t)              ; y or n
  (display-line-numbers-type 'relative)
  ; funny trick here. the first time we use :ensure nil, even if it's useless, we load use-package-ensure. this means that now this variable has a meaning.
  (use-package-always-ensure t)
  ; use-package-report to see statistics
  (use-package-compute-statistics t)
  (use-package-minimum-reported-time 0.0001)
  ;; TODO: check visual-line-mode, visual-fill-column-mode
  ;; TODO: Try `cape-dict' as an alternative.
  (tab-width 4)
  (indent-tabs-mode nil)
  (compilation-scroll-output t)
  ;; Hide commands in M-x which do not apply to the current mode.
  (read-extended-command-predicate #'command-completion-default-include-p)

  :bind
  ;;; Zoom in/out like we do everywhere else
  ("C-=" . text-scale-increase)
  ("C--" . text-scale-decrease)
  ("<C-wheel-down>" . text-scale-decrease)
  ("<C-wheel-up>" . text-scale-increase)

  :hook
  (emacs-lisp-mode . eldoc-mode) ;TODO: check eldoc
  (before-save . delete-trailing-whitespace)

  :config
  (add-to-list 'default-frame-alist '(font . "Iosevka NF-26"))

  ;; Set visualized whitespaces background to nil (transparent) to match the editor background
  ;; gruber-darker does this internally, but this allows it for all themes
  (defun rc/set-whitespace-transparent (&rest _)
    "Force whitespace-mode spaces and tabs to be transparent."
    (interactive)
    (when (facep 'whitespace-space)
      (set-face-attribute 'whitespace-space nil :background nil))
    (when (facep 'whitespace-tab)
      (set-face-attribute 'whitespace-tab nil :background nil)))

  ;; This catches `load-theme` and `consult-theme` previews.
  ;; Couldn't find a fix to make this work on the default theme as well.
  (advice-add 'enable-theme :after #'rc/set-whitespace-transparent)  ;; on load-theme
  (add-hook 'whitespace-mode-hook #'rc/set-whitespace-transparent)  ;; when whitespace-mode is active
  (add-hook 'server-after-make-frame-hook #'rc/set-whitespace-transparent)) ;; TODO check if its true; faces reset when a new GUI frame is created

(use-package whitespace
  :ensure nil
  :config
  (rc/set-whitespace-transparent)
  :custom
  (whitespace-style '(face tabs spaces trailing space-before-tab newline empty space-after-tab space-mark tab-mark indentation))
  :hook
  ((prog-mode markdown-mode yaml-mode) . whitespace-mode))

;;; Appearance (TODO: look at ef-themes)
(use-package gruber-darker-theme
  :config
  (load-theme 'gruber-darker t))

(use-package zenburn-theme)
(use-package ef-themes) ; I like ef-autumn

(use-package golden-ratio
  :hook
  (after-init . golden-ratio-mode)
  :custom
  (golden-ratio-exclude-modes '(treemacs-mode
    dired-mode
    dashboard-mode
    eshell-mode
    vterm-mode))
  (golden-ratio-exclude-buffer-names '(" *Corfu*" "*lv*")))

(use-package nerd-icons
  :custom
  (nerd-icons-font-family "Iosevka NF"))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  :custom
  (dashboard-startup-banner 'logo)
  (dashboard-center-content t)
  (dashboard-vertically-center-content t)
  (initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name))))

;;; direnv in linux
(when (eq system-type 'gnu/linux)
  (use-package direnv
    :config
    (direnv-mode)
    (setq direnv-always-show-summary nil)))

;;; TODO: change keybinds
(use-package multiple-cursors :disabled
  :bind
  ("C-S-c C-S-c" . 'mc/edit-lines)
  ("C->"         . 'mc/mark-next-like-this)
  ("C-<"         . 'mc/mark-previous-like-this)
  ("C-c C-<"     . 'mc/mark-all-like-this)
  ("C-\""        . 'mc/skip-to-next-like-this)
  ("C-:"         . 'mc/skip-to-previous-like-this))

;;; TODO: look repo to find snippet bundles
(use-package yasnippet
  :config
  (setq yas/triggers-in-field nil)
  (setq yas-snippet-dirs '("~/.emacs.snippets/"))
  (yas-global-mode 1))

;;; Flexing on Discord
(use-package elcord
  :config
  (require 'elcord)
  (elcord-mode))

(use-package treemacs
  :bind
  ("<f5>" . treemacs)
  :custom
  (treemacs-is-never-other-window t)
  :hook
  (treemacs-mode . treemacs-project-follow-mode))

(use-package move-text
  :config
  (move-text-default-bindings))

(use-package corfu   ; M-SPC to add a space without quitting corfu. this helps filtering with orderless.
  :custom
  (corfu-auto t)
  (corfu-cycle t)
  (corfu-auto-delay 0.2)
  (corfu-quit-no-match 'separator)
  :init
  (global-corfu-mode))

(use-package nerd-icons-corfu ;TODO: :demand t?
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package cape
  :ensure t
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)

  :config
  (defun rc/cape-merge-lsp-and-file ()
    "Replace the standard completion backend with a 'Super' backend
     that tries LSP, Files, and Dabbrev simultaneously."
    (setq-local completion-at-point-functions
                (list (cape-capf-super
                       #'cape-file
                       #'cape-dabbrev
                       (car completion-at-point-functions)))))
  (add-hook 'lsp-completion-mode-hook #'rc/cape-merge-lsp-and-file)
)

(use-package spacious-padding
  :config
  (spacious-padding-mode 1))

(use-package helpful
  :bind
  ("C-h f" . helpful-callable)
  ("C-h v" . helpful-variable)
  ("C-h k" . helpful-key)
  ("C-h x" . helpful-command)
  ("C-c C-d" . helpful-at-point)
  ("C-h F" . helpful-function))

(use-package saveplace
  :ensure nil
  :init
  (save-place-mode 1))

(use-package which-key
  :config
  (which-key-mode 1))

;;; https://docs.magit.vc/magit/Getting-Started.html
(use-package magit
  :bind
  ("C-c m s" . magit-status)
  ("C-c m l" . magit-log)
  ;;:config
  ;;(setq magit-completing-read-function 'magit-ido-completing-read) ; TODO Watch
)

(use-package dired
  :ensure nil
  :hook (dired-mode . dired-omit-mode)
  :custom
  (dired-dwim-target t) ; Suggest other window as copy/move target
  (dired-auto-revert-buffer t) ; auto refresh dired on file change
  (dired-listing-switches "-alh --group-directories-first")
  (dired-mouse-drag-files t)
  (dired-recursive-copies 'always) ; dont ask for every subdir when copying
  (dired-recursive-deletes 'always)
  ;; TODO Note: You might need (require 'dired-x) in :config if your Emacs version is old,
  ;; but in modern Emacs dired-x features are often autoloaded or built-in variables.
  :config
  (require 'dired-x))

(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package diredfl
  :hook (dired-mode . diredfl-mode))

(use-package dired-subtree
  :bind (:map dired-mode-map
              ("<tab>" . dired-subtree-toggle)
              ("<backtab>" . dired-subtree-cycle))) ; shift + Tab

(use-package puni
  :hook ((nxml-mode tex-mode emacs-lisp-mode simpc-mode) . puni-mode))

;;; TODO: auctex? citar? reftex? (setq font-latex-fontify-sectioning 'color)

;; Completion interface
(use-package vertico
  :init
  (vertico-mode)
  :custom
  ;; (vertico-scroll-margin 0) ;; Different scroll margin
  ;; (vertico-count 20) ;; Show more candidates
  ;; (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
  (vertico-cycle t)) ;; Enable cycling for `vertico-next/previous'

;; Persistant command history
(use-package savehist
  :ensure nil
  :init
  (savehist-mode))

;; File/command buffers annotations
(use-package marginalia
  :after vertico
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle)) ; cycle through annotation styles
  :init
  (marginalia-mode))

;; filters and sort candidates. (works in vertico, corfu, ...)
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion))))
  (completion-pcm-leading-wildcard t) ; emacs 31
)

;; filters and sort candidates. we only use filtering, by replacing the current the sort functions in vertico, corfu, ...
(use-package prescient
  :custom
  (prescient-aggressive-file-save t)
  (prescient-sort-length-enable nil)
  (prescient-sort-full-matches-first t)
  (prescient-history-length 200)
  (prescient-frequency-decay 0.997)
  (prescient-frequency-threshold 0.05)
  :config
  (prescient-persist-mode 1))

(use-package corfu-prescient
  :after corfu prescient
  :custom
  ;; Disable filtering (orderless's job)
  (corfu-prescient-enable-filtering nil)
  :config
  (corfu-prescient-mode 1))

(use-package vertico-prescient
  :after vertico prescient
  :custom
  ;; Disable filtering (orderless's job)
  (vertico-prescient-enable-filtering nil)
  :config
  (vertico-prescient-mode 1))


;; commands that replace builtin's but with support for completing-read. in this config, it uses vertico + orderless
(use-package consult
  :bind (;; Remplace switch-to-buffer et helm-mini
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g r" . consult-grep-match)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)   ;TODO M-s f ?   ;; Alternative: consult-fd
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line) ;TODO C-s ?
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)
  (advice-add #'register-preview :override #'consult-register-window)

  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  :config
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep consult-man
   consult-bookmark consult-recent-file consult-xref
   consult-source-bookmark consult-source-file-register
   consult-source-recent-file consult-source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))
  (setq consult-narrow-key "<"))

(use-package consult-dir
  :ensure t
  :bind (("C-x C-d" . consult-dir)
         :map minibuffer-local-completion-map
         ("C-x C-d" . consult-dir)
         ("C-x C-j" . consult-dir-jump-file)))

;; This explains embark pretty well : https://karthinks.com/software/fifteen-ways-to-use-embark/
(use-package embark
  :bind
  (("C-." . embark-act)         ; LE raccourci à retenir
   ("C-;" . embark-dwim)        ; Do What I Mean
   ("C-h B" . embark-bindings)) ; Affiche les bindings disponibles
  :init
  ;; Remplace le help standard par celui d'Embark
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  ;; Intégration pour que Embark utilise Vertico
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; ============================================
;; LSP
;; ============================================
;; TODO: lsp-booster ccls clangd ?
(use-package flymake
  :ensure nil
  :hook (prog-mode . flymake-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :custom
  (lsp-idle-delay 0.5)
  (lsp-log-io nil)
  (lsp-enable-symbol-highlighting t)
  (lsp-enable-snippet t)
  (lsp-headerline-breadcrumb-enable t)
  (lsp-modeline-code-actions-enable t)
  (lsp-modeline-diagnostics-enable t)
  (lsp-file-watch-threshold 2000)
  (lsp-completion-provider :none)
  (lsp-enable-indentation nil)
  (lsp-enable-on-type-formatting nil)
  (read-process-output-max (* 1 1024 1024)) ;; 1mb
  :config
  (lsp-enable-which-key-integration t)
  (add-to-list 'lsp-language-id-configuration '(simpc-mode . "c"))
  (defun rc/corfu-setup-lsp ()
  "Use orderless completion style with lsp-capf instead of the
  default lsp-passthrough."
  (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
        '(orderless)))
  :hook
  (lsp-completion-mode . rc/corfu-setup-lsp)
  ((simpc-mode
    c-mode          ; clangd
    c++-mode
    rust-mode
    go-mode
    js-mode
    typescript-mode ; npm install -g typescript-language-server typescript
    nim-mode
    kotlin-mode
    zig-mode
    haskell-mode) . lsp-deferred))

(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config

  (setq lsp-ui-doc-enable t
      lsp-ui-doc-position 'at-point
      lsp-ui-sideline-enable t
      lsp-ui-sideline-show-code-actions t
      lsp-ui-sideline-show-diagnostics t
      lsp-ui-imenu-enable t))

;; Garbage Collector
(use-package gcmh
  :init
  (gcmh-mode 1)
  :custom
  (gcmh-idle-delay 5)
  (gcmh-high-cons-threshold (* 100 1024 1024))) ; 100mb

;; ============================================
;; File Modes
;; ============================================
(use-package clang-format)

(defun rc/c-mode-setup ()
  "Custom setup for C/C++ modes."
  (require 'clang-format)
  (setq c-basic-offset 4)
  ;(c-toggle-comment-style -1)     ;; Toggle comment style from /* */ to //
  (clang-format-on-save-mode 1))  ;; Enable format on save (1 ensures it enables)


(add-hook 'simpc-mode-hook #'rc/c-mode-setup)
(add-hook 'c-mode-hook #'rc/c-mode-setup)
(add-hook 'c++-mode-hook #'rc/c-mode-setup)
(add-hook 'java-mode-hook #'rc/c-mode-setup)

(use-package simpc-mode
  :ensure nil
  :load-path "~/.emacs.local/"
  :mode "\\.[ch]\\(pp\\)?\\'")

;;;

(use-package lsp-pyright
  :after lsp-mode
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp-deferred)))
  :config
  (setq lsp-pyright-typechecking-mode "basic"))

;;;

; When I'll be there, go check https://github.com/serras/emacs-haskell-tutorial/blob/master/tutorial.md
(use-package haskell-mode
  :hook ((haskell-mode . haskell-indent-mode)
         (haskell-mode . interactive-haskell-mode)
         (haskell-mode . haskell-doc-mode))
  :config
  (setq haskell-process-type 'cabal-new-repl
        haskell-process-log t))

(use-package markdown-mode
  :ensure t
  :defer t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
         ("C-c C-e" . markdown-do)))

;;; Simple Language Modes (Installation only)
(dolist (package '(nix-mode
                   typescript-mode
                   rust-mode
                   csharp-mode
                   nim-mode
                   kotlin-mode
                   go-mode
                   zig-mode
                   yaml-mode
                   markdown-mode
                   toml-mode
                   dockerfile-mode
                   cmake-mode))
  (eval `(use-package ,package :ensure t :defer t)))

;; ============================================
;; Tools
;; ============================================

; (use-package ag)
