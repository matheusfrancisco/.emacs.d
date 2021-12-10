(setq native-comp-async-report-warnings-errors 'silent)

(add-hook 'after-init-hook #'(lambda () (message "Emacs took %s to load." (emacs-init-time))))

(defun mat/make-module (name)
  "Create a new module at `user-emacs-directory' lisp directory.
   NAME is the module suffix."
  (interactive "sName: ")
  (let* ((filename (concat user-emacs-directory "lisp/" "mat-" name ".el"))
         (buffer (get-buffer-create filename)))
    (with-current-buffer (get-buffer "init.el")
      (goto-char (point-max))
      (insert (concat "(require 'mat-" name ")"))
      (save-buffer))
    (with-current-buffer buffer
      (emacs-lisp-mode)
      (insert "(provide 'mat-" name ")")
      (goto-char (point-min))
      (open-line 2)
      (write-region nil nil filename)
      (set-buffer-modified-p nil)
      (set-visited-file-name (expand-file-name filename))
      (switch-to-buffer buffer))))

(use-package files
  :straight nil
  :custom
  (confirm-kill-emacs #'y-or-n-p)
  :config
  (defalias 'yes-or-no-p #'y-or-n-p))

(use-package restart-emacs
  :commands restart-emacs)

(defun mat/edit-emacs ()
  "Open init.el."
  (interactive)
  (find-file (expand-file-name (concat user-emacs-directory "init.el"))))

(provide 'mat-qol)