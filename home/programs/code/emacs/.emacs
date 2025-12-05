;;;
;;; Adapted from https://github.com/rexim/dotfiles
;;;

;;; Set custom stuff written by Emacs in another file
(setq custom-file "~/.emacs.custom.el")

;;; Load all installed Emacs Lisp packages and activate them
(package-initialize)

;;; Add to path so emacs can find (simpc-mode)
(add-to-list 'load-path "~/.emacs.local/")

;;; Lib
(load "~/.emacs.rc/rc.el")
(load "~/.emacs.rc/misc-rc.el")
(load "~/.emacs.rc/org-mode-rc.el")
(load "~/.emacs.rc/autocommit-rc.el")

;;; Autosave to dir
(setq backup-directory-alist `(("." . , (concat user-emacs-directory "backups"))))

;;;; Appearance
(rc/require-theme 'gruber-darker) ; gruber-darker or zenburn
(add-to-list 'default-frame-alist '(font . "Iosevka Nerd Font-20"))
  
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1) 
(show-paren-mode 1)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

;;; Text Completion
(rc/require 'company 'company-flx)
(require 'company)

(global-company-mode) ; disable it for haskell?
(company-flx-mode 1)  

;;; Emacs Completion
(rc/require 'smex 'ido-completing-read+)
(require 'ido-completing-read+)

(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)

(global-set-key (kbd "M-x") 'smex)                             ; better M-x
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ; old M-x

;;; Snippets
(rc/require 'yasnippet)
(require 'yasnippet)

(setq yas/triggers-in-field nil)
(setq yas-snippet-dirs '("~/.emacs.snippets/"))

(yas-global-mode 1)

;;; jump
(rc/require 'dumb-jump)
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)

;;; Move Text
(rc/require 'move-text)
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

;;; helm
(rc/require 'helm 'helm-git-grep 'helm-ls-git)

(setq helm-ff-transformer-show-only-basename nil)

(global-set-key (kbd "C-c h t") 'helm-cmd-t)
(global-set-key (kbd "C-c h g g") 'helm-git-grep)
(global-set-key (kbd "C-c h g l") 'helm-ls-git-ls)
(global-set-key (kbd "C-c h f") 'helm-find)
(global-set-key (kbd "C-c h a") 'helm-org-agenda-files-headings)
(global-set-key (kbd "C-c h r") 'helm-recentf)

;;; magit
(rc/require 'magit)

(setq magit-auto-revert-mode nil)

(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "C-c m l") 'magit-log)

;;; multiple cursors
(rc/require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

;;; dired
(require 'dired-x)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")
(setq dired-mouse-drag-files t) ; doesn't work on wayland. fix ?

;;; TODO: lol this doesnt work
(defun rc/enable-word-wrap ()
  (interactive)
  (toggle-word-wrap 1))

(add-hook 'markdown-mode-hook 'rc/enable-word-wrap)

;;; Whitespace mode & remove trailing whitespaces for some modes
(defun rc/set-up-whitespace-handling ()
  (interactive)
  (whitespace-mode 1)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace)
  (Claudio-whitespace-display-newline)) ; dont visualize new lines in whitespace-mode

(add-hook 'tuareg-mode-hook   'rc/set-up-whitespace-handling)
(add-hook 'simpc-mode-hook    'rc/set-up-whitespace-handling)
(add-hook 'c-mode-hook        'rc/set-up-whitespace-handling)
(add-hook 'c++-mode-hook      'rc/set-up-whitespace-handling)
(add-hook 'emacs-lisp-mode    'rc/set-up-whitespace-handling)
(add-hook 'java-mode-hook     'rc/set-up-whitespace-handling)
(add-hook 'lua-mode-hook      'rc/set-up-whitespace-handling)
(add-hook 'rust-mode-hook     'rc/set-up-whitespace-handling)
(add-hook 'scala-mode-hook    'rc/set-up-whitespace-handling)
(add-hook 'markdown-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'haskell-mode-hook  'rc/set-up-whitespace-handling)
(add-hook 'python-mode-hook   'rc/set-up-whitespace-handling)
(add-hook 'erlang-mode-hook   'rc/set-up-whitespace-handling)
(add-hook 'asm-mode-hook      'rc/set-up-whitespace-handling)
(add-hook 'nasm-mode-hook     'rc/set-up-whitespace-handling)
(add-hook 'go-mode-hook       'rc/set-up-whitespace-handling)
(add-hook 'nim-mode-hook      'rc/set-up-whitespace-handling)
(add-hook 'yaml-mode-hook     'rc/set-up-whitespace-handling)
(add-hook 'porth-mode-hook    'rc/set-up-whitespace-handling)

;;; Paredit (better parenthesis management for lisp like languages)
;;; Smartparens ? Puni ?
(rc/require 'paredit)

(defun rc/turn-on-paredit ()
  (interactive)
  (paredit-mode 1))

(add-hook 'emacs-lisp-mode-hook  'rc/turn-on-paredit)
(add-hook 'clojure-mode-hook     'rc/turn-on-paredit)
(add-hook 'lisp-mode-hook        'rc/turn-on-paredit)
(add-hook 'common-lisp-mode-hook 'rc/turn-on-paredit)
(add-hook 'scheme-mode-hook      'rc/turn-on-paredit)
(add-hook 'racket-mode-hook      'rc/turn-on-paredit)

;;; lsp-mode lsp-booster ccls clangd ?
(rc/require 'lsp-mode 'lsp-ui)

(add-hook 'simpc-mode-hook  'lsp)
(add-hook 'c-mode-hook      'lsp)
(add-hook 'c++-mode-hook    'lsp)

;;; c-mode
(setq-default c-basic-offset 4
              c-default-style '((java-mode . "java")
                                (awk-mode . "awk")
                                (other . "bsd")))

(add-hook 'c-mode-hook (lambda ()
                         (interactive)
                         (c-toggle-comment-style -1)))

;; simpc-mode
(require 'simpc-mode)

(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))
(add-to-list 'auto-mode-alist '("\\.[b]\\'" . simpc-mode))

(defun astyle-buffer (&optional justify)
  (interactive)
  (let ((saved-line-number (line-number-at-pos)))
    (shell-command-on-region
     (point-min)
     (point-max)
     "astyle --style=kr"
     nil
     t)
    (goto-line saved-line-number)))

(add-hook 'simpc-mode-hook
          (lambda ()
            (interactive)
            (setq-local fill-paragraph-function 'astyle-buffer)))

;; python-mode
(rc/require 'elpy)

(defvar rc/elpy-enabled nil)
(defun rc/turn-on-elpy ()
  (interactive)
  (unless rc/elpy-enabled
    (elpy-enable)
    (setq rc/elpy-enabled t))
  (elpy-mode 1))

(add-hook 'python-mode-hook 'rc/turn-on-elpy)

;;; Haskell mode
;;; When I'll be there, go check https://github.com/serras/emacs-haskell-tutorial/blob/master/tutorial.md
(rc/require 'haskell-mode)

(setq haskell-process-type 'cabal-new-repl)
(setq haskell-process-log t)

(add-hook 'haskell-mode-hook 'haskell-indent-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'haskell-doc-mode)

;;; LaTeX mode
(add-hook 'tex-mode-hook
          (lambda ()
            (interactive)
            (add-to-list 'tex-verbatim-environments "code")))

(setq font-latex-fontify-sectioning 'color)

;;; Nasm Mode
(rc/require 'nasm-mode)
(add-to-list 'auto-mode-alist '("\\.asm\\'" . nasm-mode))

;;; nxml
(add-to-list 'auto-mode-alist '("\\.html\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.xsd\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.ant\\'" . nxml-mode))

;;; Tide
(rc/require 'tide 'typescript-mode)

(defun rc/turn-on-tide-and-flycheck ()  ; flycheck is a dependency of tide
  (interactive)
  (tide-setup)
  (flycheck-mode 1))

(add-hook 'typescript-mode-hook 'rc/turn-on-tide-and-flycheck)

;;; eldoc mode
(defun rc/turn-on-eldoc-mode ()
  (interactive)
  (eldoc-mode 1))

(add-hook 'emacs-lisp-mode-hook 'rc/turn-on-eldoc-mode)


;;; Emacs lisp
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-j")
                            (quote eval-print-last-sexp))))
(add-to-list 'auto-mode-alist '("Cask" . emacs-lisp-mode))


;;; Packages that don't require configuration
(rc/require
 'scala-mode
 'd-mode
 'yaml-mode
 'glsl-mode
 'tuareg
 'lua-mode
 'less-css-mode
 'graphviz-dot-mode
 'clojure-mode
 'cmake-mode
 'rust-mode
 'csharp-mode
 'nim-mode
 'jinja2-mode
 'markdown-mode
 'purescript-mode
 'nix-mode
 'dockerfile-mode
 'toml-mode
 'nginx-mode
 'kotlin-mode
 'go-mode
 'racket-mode
 'qml-mode
 'ag
 'rfc-mode
 'sml-mode
 'zig-mode
 )

