(use-package clojure-mode
  :straight t
  :config
  (setq clojure-indent-style :align-arguments
	clojure-align-forms-automatically nil)
  (defun mat/clojure-hook-mode ()
    (paredit-mode +1)
    (put-clojure-indent 'defui '(1 nil nil (1)))
    (rainbow-delimiters-mode)
    (lsp))
  (add-to-list 'interpreter-mode-alist '("bb" . clojure-mode))
  (add-hook 'clojure-mode-hook 'mat/clojure-hook-mode))

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
  :straight t
  :after clojure
  :init
  (setq cider-repl-pop-to-buffer-on-connect t
	cider-show-error-buffer t
	cider-auto-select-error-buffer t
	cider-repl-display-help-banner nil
	cider-repl-history-file "~/.emacs.d/cider-history.log"
	cider-repl-wrap-history t)
  :mode (("\\.edn$\\'" . clojure-mode)
	 ("\\.boot$\\'" . clojure-mode)
	 ("\\.cljs.*$\\'" . clojure-mode)
	 ("\\.lein-env\\'" . clojure-mode))
  :config
  (setq cider-eval-result-prefix " ;; => "
	cider-font-lock-dynamically '(macro core function var)
	cider-repl-pop-to-buffer-on-connect 'display-only
	cider-boot-parameters "cider repl -w wait"))

(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'mat/local-clojure-indent)

;(add-hook 'clojure-mode-hook 'lsp)
(add-hook 'clojurescript-mode-hook 'lsp)
(add-hook 'clojurec-mode-hook 'lsp)
(add-to-list 'auto-mode-alist '("\\.repl\\'" . clojure-mode))

(use-package clj-refactor
  :after clojure-mode
  :config
  (setq cljr-assume-language-context (quote clj)
        cljr-clojure-test-declaration "[clojure.test :as test :refer [are deftest is]]")
  ;(set-lookup-handlers! 'clj-refactor-mode nil)
  (setq cljr-warn-on-eval nil
        cljr-eagerly-build-asts-on-startup nil
        cljr-add-ns-to-blank-clj-files nil ; use lsp
        cljr-magic-require-namespaces
        '(("s"   . "schema.core")
          ("gen" . "common-test.generators")
          ("d-pro" . "common-datomic.protocols.datomic")
          ("ex" . "common-core.exceptions.core")
          ("dth" . "common-datomic.test-helpers")
          ("t-money" . "common-core.types.money")
          ("t-time" . "common-core.types.time")
          ("d" . "datomic.api")
          ("m" . "matcher-combinators.matchers")
          ("pp" . "clojure.pprint")))
  ;; :bind ("/" . cljr-slash)
  )

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


