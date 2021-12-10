(use-package verb
  :defer t
  :hook (org-mode . mat/setup-verb-bindings))

(defun mat/setup-verb-bindings ()
  (define-key org-mode-map (kbd "C-c C-r") verb-command-map))

(provide 'mat-http)
