(use-package clojure-mode
  :straight t)

(use-package cider
  :straight t)

(add-hook 'clojure-mode-hook 'lsp)
(add-hook 'clojurescript-mode-hook 'lsp)
(add-hook 'clojurec-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      lsp-headerline-breadcrumb-enable nil
      company-idle-delay 0.2
      company-minimum-prefix-length 1
      ;; lsp-lens-enable t
      lsp-file-watch-threshold 10000
      lsp-signature-auto-activate nil
      lsp-clojure-custom-server-command '("/usr/local/bin/clojure-lsp")
      ;; I use clj-kondo from master
      lsp-diagnostics-provider :none
      lsp-enable-indentation nil ;; uncomment to use cider indentation instead of lsp
      ;; lsp-enable-completion-at-point nil ;; uncomment to use cider completion instead of lsp
)


(provide 'mat-clojure-lsp)
