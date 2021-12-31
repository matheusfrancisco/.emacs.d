(use-package paredit
  :hook
  (emacs-lisp-mode . paredit-mode)
  (emacs-lisp-mode-hook . 'paredit-mode)
  ;;; enable in the *scratch* buffer
  (lisp-interaction-mode-hook . paredit-mode)
  (ielm-mode-hook . paredit-mode)
  (lisp-mode-hook . paredit-mode))

(provide 'mat-paredit)
