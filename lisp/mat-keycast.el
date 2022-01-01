(use-package keycast
  :straight t
;; https://github.com/tarsius/keycast/issues/7#issuecomment-627604064
  :config
  (define-minor-mode keycast-mode
    "Show current command and its key binding in the mode line."
    :global t
    (require 'keycast)
    (if keycast-mode
        (add-hook 'pre-command-hook 'keycast-mode-line-update)
        (remove-hook 'pre-command-hook 'keycast-mode-line-update)))

  (add-to-list 'global-mode-string '("" mode-line-keycast " "))
  :init
  (keycast-mode))

(provide 'mat-keycast)
