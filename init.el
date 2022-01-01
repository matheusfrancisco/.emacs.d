(add-to-list 'load-path (concat user-emacs-directory "lisp/"))

(require 'mat-bootstrap)
(require 'mat-ui)
(require 'mat-ivy)
(require 'mat-modeline)
(require 'mat-rainbow)
(require 'mat-evil)
(require 'mat-bindings)
(require 'mat-project)
(require 'mat-git)
(require 'mat-org)
(require 'mat-lsp)
(require 'mat-company)
(require 'mat-eshell)
(require 'mat-dired)
;not able to install
;(require 'mat-diminish)
(require 'mat-paredit)
(require 'mat-clojure-lsp)
(require 'mat-ace)
(require 'mat-winum)
(require 'mat-perspectives)
(require 'mat-keycast)
(require 'mat-languages)

;;improve bindings
;;toggle commands
; (use-package posframe
;  :straight t
;)

; (setq mat/command-window-frame nil)

;; (defun mat/toggle-command-window ()
;;   (interactive)
;;   (if mat/command-window-frame
;;       (progn
;;         (posframe-delete-frame clm/command-log-buffer)
;;         (setq mat/command-window-frame nil))
;;     (progn
;;       (global-command-log-mode t)
;;       (with-current-buffer
;;           (setq clm/command-log-buffer
;;                 (get-buffer-create " *command-log*"))
;;         (text-scale-set -1))
;;       (setq mat/command-window-frame
;;             (posframe-show
;;              clm/command-log-buffer
;;              :position `(,(- (x-display-pixel-width) 590) . 15)
;;              :width 38
;;              :height 5
;;              :min-width 38
;;              :min-height 5
;;              :internal-border-width 2
;;              :internal-border-color "#c792ea"
;;              :override-parameters '((parent-frame . nil)))))))

;; (rune/leader-keys
;;  "tc" 'mat/toggle-command-window)

;;session package
 ;; (use-package desktop
 ;;   :custom
 ;;   (desktop-dirname (expand-file-name user-emacs-directory))
 ;;   (desktop-restore-eager 2)
 ;;   :config
 ;; (desktop-save-mode 1))

;;search
(use-package rg
  :defer 1
  :config
  (rg-enable-default-bindings)
  (add-to-list 'rg-required-command-line-flags "--max-columns=2000"))

(rg-define-search rg-no-tests
  :format regexp
  :dir project
  :files "all"
  :flags ("--type-add 'notest:*.test.*'"
	  "--type-not notest"
	  "--type-add 'notest:*-test-*")
  :menu ("Custom" "n" "No tests"))

;;backup
(use-package files
  :straight nil
  :init
  (make-directory "~/tmp/emacs/backups" t)
  :custom
  (backup-by-copying t)
  (backup-directory-alist
   '(("." . "~/tmp/emacs/backups"))))


;; python packages

;; bindings move to bindinds file

(rune/leader-keys
  "pf"  'projectile-find-file
  "ps"  'projectile-switch-project
  "pF"  'consult-ripgrep
  "pp"  'projectile-find-file
  "pc"  'projectile-compile-project
  "pd"  'projectile-dired)

;; avy jumping
(use-package avy
  :straight nil)
;;jumping to ..
(rune/leader-keys
 "j"   '(:ignore t :which-key "jump")
 "jj"  '(avy-goto-char :which-key "jump to char")
 "jw"  '(avy-goto-word-0 :which-key "jump to word")
 "jl"  '(avy-goto-line :which-key "jump to line"))



;;bindings to eval
(rune/leader-keys
  :keymaps '(visual)
  "er" '(eval-region :which-key "eval region"))
