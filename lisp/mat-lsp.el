
;; (use-package flycheck
;;   :straight t
;;   )

(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :straight t
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :bind (("TAB" . completion-at-point))
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t)
  (setq lsp-clojure-custom-server-command '("bash" "-c" "~/dev/clojure-lsp/clojure-lsp") ;; Remove it if you don't develop clojure-lsp in your machine
          lsp-headerline-breadcrumb-enable nil
          lsp-lens-enable t
          lsp-enable-file-watchers t
          lsp-signature-render-documentation nil
          lsp-signature-function 'lsp-signature-posframe
          lsp-semantic-tokens-enable t
          lsp-idle-delay 0.3
          lsp-use-plists nil
          lsp-completion-sort-initial-results t ; check if should keep as t
          lsp-completion-no-cache t
          lsp-completion-use-last-result nil))
  


(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom)
  (setq lsp-ui-peek-list-width 60
        lsp-ui-doc-max-width 60
        lsp-ui-doc-enable nil
        lsp-ui-peek-fontify 'always
        lsp-ui-sideline-show-code-actions nil))

(use-package lsp-ivy)

(use-package lsp-treemacs
  :after lsp
  :config
  (setq lsp-treemacs-error-list-current-project-only t))

(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))


;;lsp-bindings

(rune/leader-keys
  "l" '(:ignore t :which-key "lsp")
  "ld" 'xref-find-definitions
  "lr" 'xref-find-references
  "ln" 'lsp-ui-find-next-reference
  "lp" 'lsp-ui-find-prev-reference
  "ls" 'counsel-imenu
  "le" 'lsp-ui-flycheck-list
  "lS" 'lsp-ui-sideline-mode
  "lX" 'lsp-execute-code-action)

(provide 'mat-lsp)
