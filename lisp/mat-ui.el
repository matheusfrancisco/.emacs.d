;; disable some ui elements

(defvar runemacs/default-font-size 180)

(setq inhibit-startup-message t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)

;; disable gui dialogs
(setq use-dialog-box nil
      use-file-dialog nil)

;; set a nice monospace font
;(set-frame-font "JetBrains Mono-13" nil t)

;; set a nice dark theme
;(load-theme 'modus-vivendi)


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

(provide 'mat-ui)
