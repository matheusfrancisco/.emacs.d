
(use-package evil
  :config (evil-mode 1))

(setq local/override-mode-map 
  '((dired-mode . emacs)
    (imenu-list-major-mode . emacs)
    (cider-repl-mode . emacs)
    (edebug-mode . emacs)))
  
(with-eval-after-load "evil"
  (cl-loop for (mode . state) in local/override-mode-map
    do (evil-set-initial-state mode state)))

(use-package general
  :config
  (general-evil-setup t)
  (general-create-definer local/leader-def
    :prefix (local/get 'local/leader-key "C-c")))

(provide 'mat-evil)
