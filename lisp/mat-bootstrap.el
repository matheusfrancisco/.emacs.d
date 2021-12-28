;(setq straight-use-package-by-default t)
;(setq straight-default-vc 'git)
;(setq straight-vc-git-default-protocol 'ssh)
(setq visible-bell t)
(require 'package)
(setq straight-host-usernames '((github . "matheusfrancisco")
                                (gitlab . "matheusfrancisco")))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;(defvar bootstrap-version)
;(let ((bootstrap-file
;       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
;      (bootstrap-version 5))
;  (unless (file-exists-p bootstrap-file)
;    (with-current-buffer
;        (url-retrieve-synchronously
;         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
;         'silent 'inhibit-cookies)
;      (goto-char (point-max))
;      (eval-print-last-sexp)))
;  (load bootstrap-file nil 'nomessage))
;
;(straight-use-package 'use-package)

(use-package command-log-mode)

(provide 'mat-bootstrap)
