;; Avoid constant errors on Windows about the coding system by setting the default to UTF-8.
;; or any other system
(set-default-coding-systems 'utf-8)

;; disable some ui elements

(defvar runemacs/default-font-size 180)

(setq inhibit-startup-message t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)

(setq visible-bell nil)
(setq ring-bell-function 'ignore)
;; disable gui dialogs
(setq use-dialog-box nil
      use-file-dialog nil)

;; set a nice monospace font
;(set-frame-font "JetBrains Mono-13" nil t)
;; Set the font face based on platform

(use-package dracula-theme
  :config (load-theme 'dracula t))


(column-number-mode)
(global-display-line-numbers-mode t)


;; Disable line numbers for some modes


;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
		eshell-mode-hook
                term-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.5))


(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))


; (unless dw/is-termux
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq use-dialog-box nil)
;)

;;tab-bar-mode
(use-package tab-bar
  :straight nil
  :custom
  (tab-bar-show 1)
  (tab-bar-new-button-show nil)
  (tab-bar-close-button-show nil)
  :config
  (tab-bar-mode))

(setq tab-bar-show nil)

(provide 'mat-ui)

