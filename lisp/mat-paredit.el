(use-package paredit
  :straight t
  :hook
  (emacs-lisp-mode . paredit-mode)
  ;;; enable in the *scratch* buffer
  )

(provide 'mat-paredit)
