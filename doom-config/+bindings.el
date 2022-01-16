;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-

(when (eq system-type 'gnu/linux)
  (setq x-super-keysym 'meta))

(define-key evil-normal-state-map (kbd "M-r") 'evil-multiedit-match-all)
(define-key evil-normal-state-map (kbd "<tab>") 'evil-jump-item)
(define-key evil-motion-state-map (kbd "] e") #'flycheck-next-error)
(define-key evil-motion-state-map (kbd "[ e") #'flycheck-previous-error)

(defun scroll-up-bottom-window ()
  "Scroll up bottom window"
  (interactive)
  (save-selected-window
    (when-let ((bottom-window (-first (lambda (w)
                                        (and (window-full-width-p w)
                                             (not (eq w (get-buffer-window))))) (window-list))))
      (select-window bottom-window)
      (scroll-up-line))))

(defun scroll-down-bottom-window ()
  "Scroll down bottom window"
  (interactive)
  (save-selected-window
    (when-let ((bottom-window (-first (lambda (w)
                                        (and (window-full-width-p w)
                                             (not (eq w (get-buffer-window))))) (window-list))))
      (select-window bottom-window)
      (scroll-down-line))))

(defun mat/edit-config-emacs ()
  "Open init.el."
  (interactive)
  (find-file (expand-file-name (concat user-emacs-directory "../doom-config/config.el"))))


(map! :nvi 

      :desc "Toggle buffer full screen"
      "<f10>" #'doom/window-maximize-buffer

      )

(map! :nv
      :desc "Evil multiedit word"
      "M-r" #'evil-multiedit-match-all)


(map! :leader

      :desc "Open config.el"
      "f T" #'mat/edit-config-emacs

      :desc "Find file in dotfiles"
      "f t" #'find-in-dotfiles

      :desc "Treemacs open currenty project"
      "T o" #'treemacs-display-current-project-exclusively

      :desc "Treemacs select folder"
      "T s" #'treemacs-select-directory

      :desc "Treemacs toogle"
      "T t" #'treemacs
      )

(after! paredit
  (define-key paredit-mode-map (kbd "C-<left>") nil)
  (define-key paredit-mode-map (kbd "C-<right>") nil)
  ; #TODO should improve this key bindings
  (map! :nvi

        :desc "Forward barf"
        "M-<left>" #'paredit-forward-barf-sexp

        :desc "Forward slurp"
        "M-<right>" #'paredit-forward-slurp-sexp

        :desc "Backward slurp"
        "M-S-<left>" #'paredit-backward-slurp-sexp

        :desc "Backward barf"
        "M-S-<right>" #'paredit-backward-barf-sexp

        :desc "Backward"
        "C-c <left>" #'paredit-backward

        :desc "Forward"
        "C-c <right>" #'paredit-forward))

(map! :after clojure-mode
      :leader

      :desc "Search for symbol in project excluding test folders"
      "&" (lambda () (interactive) (rg-ignoring-folders (list "test" "postman")))

      :desc "Search for symbol in project excluding src folder"
      "(" (lambda () (interactive) (rg-ignoring-folders (list "src")))

      :desc "lsp-clojure cursor info"
      "-" #'lsp-clojure-cursor-info)

(map! :after cider-mode
      :map cider-mode-map
      :localleader

      :desc "Cider eval last sexpr and copy to clipboard"
      "e c" #'cider-eval-last-sexpr-and-copy-to-clipboard)


(after! company
  (define-key company-active-map (kbd "M-h") #'company-quickhelp-manual-begin))

(map! :after lsp-mode
      :n

      :desc "Start lsp on buffer"
      "M-l" #'lsp)

(map! :after dap-mode
      :map dap-mode-map
      :n

      :desc "DAP step-in"
      "<f4>" #'dap-step-in

      :desc "DAP step-out"
      "<f5>" #'dap-step-out

      :desc "DAP next"
      "<f6>" #'dap-next

      :desc "DAP continue"
      "<f8>" #'dap-continue)

(map! :after java-mode
      :map java-mode-map
      :localleader

      :desc "Run method test"
      "t" #'dap-java-run-test-method

      :desc "Run class tests"
      "T" #'dap-java-run-test-class)
