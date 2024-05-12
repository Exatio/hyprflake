;;;
;;; Adapted from https://github.com/rexim/dotfiles/blob/master/.emacs.rc/rc.el
;;;

;;; Load the MELPA package archiver 
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;;; Load the MELPA STABLE package archiver
;;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)


;;; Variable created to ensure that we do not make multiple package-refresh-contents in a single startup
(defvar rc/package-contents-refreshed nil)

;;; If not already done from the start of EMACS, inform Emacs about
;;; the latest versions of packages and we make them available for download
(defun rc/package-refresh-contents-once ()
  (when (not rc/package-contents-refreshed)
    (setq rc/package-contents-refreshed t)
    (package-refresh-contents)))

;;; If and only if the package is not already installed, we install the latest version of the package.
(defun rc/require-one-package (package)
  (when (not (package-installed-p package))
    (rc/package-refresh-contents-once)
    (package-install package)))

;;; If we have multiple packages to install, we go through each of them
(defun rc/require (&rest packages)
  (dolist (package packages)
    (rc/require-one-package package)))

;;; We take theme, get its symbol name, append -theme and then get it back into a symbol.
;;; Then, we install it with our above function, and load the theme.
(defun rc/require-theme (theme)
  (let ((theme-package (->> theme
                            (symbol-name)
                            (funcall (-flip #'concat) "-theme")
                            (intern))))
    (rc/require theme-package)
    (load-theme theme t)))


;;; Make rc/require-theme and other fun work.
(rc/require 'dash)
(require 'dash)