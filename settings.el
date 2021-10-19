(defun local/find-settings ()
  "Edit settings.org"
  (interactive)
  (find-file (concat user-emacs-directory "settings.org")))

(defun local/reload-emacs ()
  "Reload emacs"
  (interactive)
  (load-file user-init-file))

(global-set-key (kbd "C-c I") 'local/find-settings)
(global-set-key (kbd "C-c R") 'local/reload-emacs)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(setq initial-major-mode 'org-mode)
(setq initial-scratch-message
  (concat
    "# This buffer is for unsaved text, like general annotations and etc..\n"
    "# To create a file, visit it with C-x C-f and enter text in this buffer instead.\n"
    "\n"))

(setq inhibit-startup-message t)
(setq initial-buffer-choice nil)

(setq ring-bell-function 'ignore)

(defalias 'yes-or-no-p 'y-or-n-p)

(load "dired-x")
(with-eval-after-load "dired"
  (setq-default dired-omit-files-p t)
  (setq dired-omit-files (concat dired-omit-files "^\\.|\\*\\\#")))

(global-auto-revert-mode t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(setq frame-title-format '("" "%b %* [%m]"))

;(use-package dracula-theme)
  ;(use-package eziam-theme)
  ;(use-package minimal-theme
  ;  :config (load-theme 'minimal t))
(use-package dracula-theme
  :config (load-theme 'dracula t))

;(let ((chosen-font (local/get 'local-preferred-font "Jetbrains Mono-14")))
;  (setq default-frame-alist `((font . ,chosen-font))))

;(use-package smart-mode-line
;  :init (setq sml/no-confirm-load-theme t)
;	    (setq sml/theme 'dark)
;  :config (sml/setup))

;(use-package minions
;  :config (minions-mode 1))

(use-package feebleline
  :config (feebleline-mode 1))

;;(use-package golden-ratio
;;  :config (add-to-list 'golden-ratio-extra-commands 'ace-window)
;;          (golden-ratio-mode 1))

(use-package frames-only-mode
  :config (frames-only-mode 1))

;;(setq window-divider-default-places t)
;;(setq window-divider-default-right-width 1)
;;(window-divider-mode 1)

(use-package evil
  :config (evil-mode 1))

(setq local/override-mode-map 
  '((dired-mode . emacs)
    (imenu-list-major-mode . emacs)
    (cider-repl-mode . emacs)
    (edebug-mode . emacs)))
  
(with-eval-after-load "evil"
  (cl-loop for (mode . state) in local/override-mode-map
    do (evil-set-initial-state mode state)))

(use-package general
  :config
  (general-evil-setup t)
  (general-create-definer local/leader-def
    :prefix (local/get 'local/leader-key "C-c")))

(use-package ivy

:bind (("M-x" . counsel-M-x)
         ("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)	
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  ("C-c C-c M-x" . execute-extended-command)
		 :config
		 (progn
		   (with-eval-after-load 'ido
		     (ido-mode -1)
		     (ivy-mode 1)))

	   ;; Show recently killed buffers when calling `ivy-switch-buffer'
	   (setq ivy-use-virtual-buffers t)
	   (setq ivy-virtual-abbreviate 'full) ;Show the full virtual file paths

	   (setq ivy-count-format "%d/%d ")
	   (setq ivy-re-builders-alist '((t . ivy--regex-plus))) ;Default
	   ;; (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))

	   ;; Do not show "./" and "../" in the `counsel-find-file' completion list
	   (setq ivy-extra-directories nil)    ;Default value: ("../" "./")
		 )

       (use-package counsel
	 :defer t
	 :config
    ;; Show parent directory in the prompt
	 (ivy-set-prompt 'counsel-ag #'counsel-prompt-function-dir)
  )
