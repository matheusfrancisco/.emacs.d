(use-package general
  :config
  (general-evil-setup)
  (general-override-mode))

(general-create-definer leader-def
  :prefix "SPC"
  :non-normal-prefix "M-SPC"
  :states '(normal visual emacs))

(defun mat/alternate-buffer ()
  "Switch to previous buffer."
  (interactive)
  (switch-to-buffer (other-buffer)))

(defun mat/setup-bindings ()
  "Setup custom bindings."
  (leader-def
    "SPC" 'execute-extended-command
    "TAB" 'mat/alternate-buffer
    "a" 'projectile-toggle-between-implementation-and-test
    "b" 'consult-buffer
    "c" (general-simulate-key "C-c")
    "d" 'kill-buffer-and-window
    "e" nil
    "eb" 'eval-buffer
    "ee" 'mat/edit-emacs
    "ef" 'eval-defun
    "er" 'eval-region
    "es" 'eshell
    "et" 'vterm
    "f" 'projectile-find-file
    "g" 'magit-status
    "h" nil
    "i" 'consult-imenu
    "j" 'avy-goto-char-timer
    "k" 'kill-this-buffer
    "l" 'consult-line
    "m" 'consult-bookmark
    "n" nil
    "o" 'delete-other-windows
    "p" 'projectile-command-map
    "q" nil
    "r" 'eglot-rename
    "s" 'save-buffer
    "t" (general-simulate-key "C-x t")
    "u" nil
    "v" (general-simulate-key "C-x 4")
    "w" 'other-window
    "x" nil
    "y" nil
    "z" nil
    ";" 'eval-expression)

  (general-nmap
    ;; goto
    "gb" 'xref-pop-marker-stack
    "gr" 'xref-find-references
    "]e" 'next-error
    "[e" 'previous-error
    "]h" 'diff-hl-show-hunk-next
    "[h" 'diff-hl-show-hunk-previous))
(add-hook 'after-init-hook #'mat/setup-bindings)

(provide 'mat-bindings)