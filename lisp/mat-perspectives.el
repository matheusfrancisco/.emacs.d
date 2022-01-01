(use-package perspective
  :straight t
  :bind (("C-x k" . persp-kill-buffer*))
  :custom
  (persp-initial-frame-name "Main")
  :init
  (persp-mode))

(rune/leader-keys
  "C-M-j" '(persp-counsel-switch-buffer :which-key "switch persp buffer counsel integration"))

;(add-hook 'kill-emacs-hook #'persp-state-save)

(provide 'mat-perspectives)
