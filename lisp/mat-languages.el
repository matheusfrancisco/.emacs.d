;;should fix lispmode to wrap, and slurp
;; (use-package lispy
  ;; :straight t)

;; (use-package lispyville
;;  :straight t
;;)

;;move to typescript
;;typescript mode
(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))
; needs to install lsp ts server
;npm install -g typescript-language-server typescript

(defun mat/set-js-indentation ()
  (setq-default js-indent-level 2)
  (setq-default evil-shift-width js-indent-level)
  (setq-default tab-width 2))

;;js
(use-package json-mode :defer t)
(use-package yaml-mode :defer t)
(use-package jq-mode :defer t)
;
(use-package npm-mode
  :straight t
					;(npm-mode :host github :repo "mojochao/npm-mode" :fork t)
  :hook ((typescript-mode js-mode) . npm-mode))
;
(add-to-list 'compilation-error-regexp-alist-alist
            '(javascript-stack-trace
                "(\\([^:]+\\):\\([[:digit:]]+\\):\\([[:digit:]]+\\))"
                1 2 3 1))
;
(add-hook 'js-mode #'mat/setup-js)
(add-hook 'typescript-mode #'mat/setup-js)
;
;(use-package js2-mode
;  :straight t
;  :mode "\\.js\\"
;;  :custom
;;  (setq js2-mode-show-strict-warnings nil)
;  )
;  
;(add-hook 'js2-mode-hook #'mat/set-js-indentation)
;(add-hook 'json-mode-hook #'mat/set-js-indentation)


;; markdown mode

(use-package markdown-mode
  :defer t
  :config
  (dolist (face '((markdown-header-face-1 . 1.2)
                    (markdown-header-face-2 . 1.1)
                    (markdown-header-face-3 . 1.0)
                    (markdown-header-face-4 . 1.0)
                    (markdown-header-face-5 . 1.0)))
    (set-face-attribute (car face) nil :weight 'normal :height (cdr face))))

;; html mode

(use-package web-mode
  :mode "(\\.\\(html?\\|ejs\\|tsx\\|jsx\\)\\'"
  )

;; python packages
;; (use-package python-mode
;;   :straight t)

(use-package company-jedi
  :straight t
  :config
  (setq jedi:complete-on-dot t)
  :hook (python-mode . (lambda () (push 'company-jedi company-backends))))

(use-package lsp-python-ms
  :straight t
  :hook (python-mode . (lambda () (lsp-deferred))))

(use-package pippel
  :straight t)

;;rust
(use-package rustic
  :straight t
  :config
  (setq rustic-lsp-server 'rls)
  (setq rustic-format-on-save t))

(provide 'mat-languages)
