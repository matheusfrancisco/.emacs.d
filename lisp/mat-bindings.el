
;; Make ESC quit prompts (global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;;rebind C-u
;;Since I let evil-mode take over C-u for buffer scrolling, I need to re-bind the universal-argument command to another key sequence. I’m choosing C-M-u for this purpose.
(global-set-key (kbd "C-M-u") 'universal-argument)

(use-package general
  :after evil
  :config
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (rune/leader-keys
    "t" '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme"))

  (general-create-definer rune/ctrl-c-keys
    :prefix "C-c"))

(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(rune/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

(rune/leader-keys
  "eb" '(eval-buffer :which-key "eval region"))

;;switch buffer fast
(global-set-key (kbd "C-M-j") 'counsel-switch-buffer)

(defun mat/format-elisp-buffer ()
  "Format an emacs-lisp-mode buffer."
  (interactive)
  (untabify (point-min) (point-max))
  (delete-trailing-whitespace (point-min) (point-max))
  (indent-region (point-min) (point-max)))

(defun mat/format-buffer ()
  "Format whole buffer."
  (interactive)
  (cond ((string-equal major-mode "json-mode") (json-mode-beautify (point-min) (point-max)))
        ((string-equal major-mode "sql-mode") (sqlformat-buffer))
        ((string-equal major-mode "emacs-lisp-mode") (mat/format-elisp-buffer))))

(defun mat/edit-emacs ()
  "Open init.el."
  (interactive)
  (find-file (expand-file-name (concat user-emacs-directory "init.el"))))

(defun mat/alternate-buffer ()
  "Switch to previous buffer."
  (interactive)
  (switch-to-buffer (other-buffer)))

(rune/leader-keys
  "ee" '(mat/edit-emacs :which-key "open init.el")
  "=" 'mat/format-buffer
  "g" 'magit-status
  "s" 'save-buffer
  "TAB" 'mat/alternate-buffer
  "k" 'kill-this-buffer
  "d" 'kill-buffer-and-window
  "o" 'delete-other-windows
  ";" 'eval-expression
  )

(rune/ctrl-c-keys
  "C-h" 'evil-window-left
  "C-j" 'evil-window-down
  "C-k" 'evil-window-up
  "C-l" 'evil-window-right

  "C-S-h" 'evil-window-move-far-left
  "C-S-j" 'evil-window-move-very-bottom
  "C-S-k" 'evil-window-move-very-top
  "C-S-l" 'evil-window-move-far-right
  )

(provide 'mat-bindings)
