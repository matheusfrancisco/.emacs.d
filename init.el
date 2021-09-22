(prog1 "prepare package repository"
  (custom-set-variables
    '(package-archives '(("org" . "https://orgmode.org/elpa/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/"))))
  (package-initialize))

(progn "install straight.el and use-package"
  ;; This is straight.el's bootstrap code
  (defvar bootstrap-version)
  (let ((bootstrap-file
         (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
        (bootstrap-version 5))
    (unless (file-exists-p bootstrap-file)
      (with-current-buffer
          (url-retrieve-synchronously
           "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
           'silent 'inhibit-cookies)
        (goto-char (point-max))
        (eval-print-last-sexp)))
    (load bootstrap-file nil 'nomessage))

  (straight-use-package 'use-package)
  (setq straight-use-package-by-default t)
  (setq-default use-package-verbose t))

(progn "load local variables from ~/.emacs.d/local-variables.el"
  (let ((local/variables-path (expand-file-name
				(concat user-emacs-directory "local-variables.el"))))
    (when (file-exists-p local/variables-path)
      (load-file local/variables-path))

    (defun local/get (var-name default)
      (if (boundp var-name)
	(eval var-name)
	default))))

(prog1 "Have custom settings go to a separate file"
  (setq custom-file (expand-file-name
		      (concat user-emacs-directory ".custom.el")))

  (load custom-file 'noerror))

(progn "load settings.org to finish remaining settings"
  (use-package org)
  (setq local/settings-org-path (expand-file-name
                                 (concat user-emacs-directory
                                         "settings.org")))
  (org-babel-load-file local/settings-org-path))
