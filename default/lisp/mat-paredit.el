(use-package paredit
  :straight t
  :hook
  ((emacs-lisp-mode . paredit-mode)
   (clojure-mode . paredit-mode)))

;(global-set-key (kbd "M-<right>") 'paredit-forward-slurp-sexp)
;(global-set-key (kbd "M-S-<left>") 'paredit-backward-slurp-sexp)
;(global-set-key (kbd "M-<left>") 'paredit-forward-barf-sexp)
;(global-set-key (kbd "M-S-<right>") 'paredit-backward-barf-sexp)

(rune/leader-keys
  "M-S-l" '(paredit-forward-slurp-sexp :which-key "Forward slurp ")
  "M-S-<rigth>" '(paredit-backward-barf-sexp :which-key "Backward barf ")
  "M-S-j" '(paredit-forward-barf-sexp :which-key "Forward barf ")
  "M-S-<left>" '(paredit-backward-slurp-sexp :which-key "Backward slurp"))

(provide 'mat-paredit)
