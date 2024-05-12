(require 'ansi-color)

(global-set-key (kbd "C-c p") 'find-file-at-point)
(global-set-key (kbd "C-c i m") 'imenu)

(setq-default inhibit-splash-screen t
              make-backup-files nil
              tab-width 4
              indent-tabs-mode nil
              compilation-scroll-output t
              default-input-method "russian-computer"
              visible-bell (equal system-type 'windows-nt))

(defun rc/colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'rc/colorize-compilation-buffer)

(defun rc/buffer-file-name ()
  (if (equal major-mode 'dired-mode)
      default-directory
    (buffer-file-name)))

(defun rc/parent-directory (path)
  (file-name-directory (directory-file-name path)))

(defun rc/root-anchor (path anchor)
  (cond
   ((string= anchor "") nil)
   ((file-exists-p (concat (file-name-as-directory path) anchor)) path)
   ((string-equal path "/") nil)
   (t (rc/root-anchor (rc/parent-directory path) anchor))))

(defun rc/clipboard-org-mode-file-link (anchor)
  (interactive "sRoot anchor: ")
  (let* ((root-dir (rc/root-anchor default-directory anchor))
         (org-mode-file-link (format "file:%s::%d"
                                     (if root-dir
                                         (file-relative-name (rc/buffer-file-name) root-dir)
                                       (rc/buffer-file-name))
                                     (line-number-at-pos))))
    (kill-new org-mode-file-link)
    (message org-mode-file-link)))

;;; Taken from here:
;;; http://stackoverflow.com/questions/2416655/file-path-to-clipboard-in-emacs
(defun rc/put-file-name-on-clipboard ()
  "Put the current file name on the clipboard"
  (interactive)
  (let ((filename (rc/buffer-file-name)))
    (when filename
      (kill-new filename)
      (message filename))))

(defun rc/put-buffer-name-on-clipboard ()
  "Put the current buffer name on the clipboard"
  (interactive)
  (kill-new (buffer-name))
  (message (buffer-name)))

(defun rc/kill-autoloads-buffers ()
  (interactive)
  (dolist (buffer (buffer-list))
    (let ((name (buffer-name buffer)))
      (when (string-match-p "-autoloads.el" name)
        (kill-buffer buffer)
        (message "Killed autoloads buffer %s" name)))))

(defun rc/start-python-simple-http-server ()
  (interactive)
  (shell-command "python -m SimpleHTTPServer 3001 &"
                 "*Simple Python HTTP Server*"))

(global-set-key (kbd "C-x p s") 'rc/start-python-simple-http-server)

;;; Taken from here:
;;; http://blog.bookworm.at/2007/03/pretty-print-xml-with-emacs.html
(defun bf-pretty-print-xml-region (begin end)
  "Pretty format XML markup in region. You need to have nxml-mode
http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do
this.  The function inserts linebreaks to separate tags that have
nothing but whitespace between them.  It then indents the markup
by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
    (nxml-mode)
    (goto-char begin)
    (while (search-forward-regexp "\>[ \\t]*\<" nil t) 
      (backward-char) (insert "\n"))
    (indent-region begin end))
  (message "Ah, much better!"))

;;; Stolen from http://ergoemacs.org/emacs/emacs_unfill-paragraph.html
(defun rc/unfill-paragraph ()
  "Replace newline chars in current paragraph by single spaces.
This command does the inverse of `fill-paragraph'."
  (interactive)
  (let ((fill-column 90002000)) ; 90002000 is just random. you can use `most-positive-fixnum'
    (fill-paragraph nil)))

(global-set-key (kbd "C-c M-q") 'rc/unfill-paragraph)

(defun rc/load-path-here ()
  (interactive)
  (add-to-list 'load-path default-directory))

(defconst rc/frame-transparency 85)

(defun rc/toggle-transparency ()
  (interactive)
  (let ((frame-alpha (frame-parameter nil 'alpha)))
    (if (or (not frame-alpha)
            (= (cadr frame-alpha) 100))
        (set-frame-parameter nil 'alpha
                             `(,rc/frame-transparency
                               ,rc/frame-transparency))
      (set-frame-parameter nil 'alpha '(100 100)))))

(defun rc/duplicate-line ()
  "Duplicate current line"
  (interactive)
  (let ((column (- (point) (point-at-bol)))
        (line (let ((s (thing-at-point 'line t)))
                (if s (string-remove-suffix "\n" s) ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))

(global-set-key (kbd "C-,") 'rc/duplicate-line)

;;; A little hack which fixes a problem with meta key in fluxbox under VNC.
(setq x-alt-keysym 'meta)

(setq confirm-kill-emacs 'y-or-n-p)


(defun Claudio-whitespace-display-newline (&optional toggle-when-nil)
  "This function controls whether `whitespace-mode' visualizes newlines.

Call it only when `whitespace-mode' is on locally.

`M-x Claudio-whitespace-display-newline' or `(Claudio-whitespace-display-newline)' or `(Claudio-whitespace-display-newline nil)':
toggle newline visualization;

`(Claudio-whitespace-display-newline POSITIVE-NUMBER)':
enable newline visualization;

Call with other arguments:
disable newline visualization.

Written by Shynur, for Claudio"
  (interactive)
  (require 'whitespace)
  (unless whitespace-mode
    (error "Claudio-whitespace-display-newline: this function makes sense only when whitespace-mode is on locally"))
  (cond
   ;; As this function's argument's name said, this form will toggle the display of 'newline'.
   ((null toggle-when-nil)
    (Claudio-whitespace-display-newline
     ;; If 'newline' is displayed, turn it off; otherwise, turn on.
     ;; `whitespace-active-style' is described in 'whitespace.el';
     ;; the presence of `newline-mark' means that: 'newline' is displayed.
     (if (memq 'newline-mark whitespace-active-style)
         -1
       1)))
   ;; Instead of toggling, you want to directly turn it on/off.
   (t
    (let ((new-style (remove 'newline-mark whitespace-style))) ; Make a new 'whitespace-style' without `newline-mark'.
      ;; !!! `whitespace-mode' will read `whitespace-style' _when_it_starts_,
      ;; !!! so you should turn it off now (and then turn it on).
      (whitespace-mode -1)
      (let ((whitespace-style (if (> toggle-when-nil 0)
                                  ;; If you want to display 'newline',
                                  ;; add a 'newline-mark' to `new-style' which is created just now;
                                  (push 'newline-mark new-style)
                                ;; otherwise, don't modify it.
                                new-style)))
        ;; Now `new-style' has been assigned to `whitespace-style',
        ;; which will tell `whitespace-mode' what to display.
        (whitespace-mode)))))) ; Enable it.

