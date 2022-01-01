(use-package clojure-mode
  :straight t)

(defun mat/local-clojure-indent ()
  (define-clojure-indent
    (props/for-all 1)
    (h/defc 1)
    (fm/defmutation 1)
    (db.h/defmutation 1)
    (match? 0)
    (flow 1)
    (facts 1)
    (fact 1)
    (dth/let-entities 1)
    (let-entities 1)
    (verify 1)
  ))

(defun local-cider-config ()
  (add-to-list 'cider-test-defining-forms "defflow"))

(use-package cider
  :straight t)

(add-hook 'clojure-mode-hook 'mat/local-clojure-indent)

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
