(add-to-list 'load-path (concat user-emacs-directory "lisp/"))

(require 'mat-bootstrap)
(require 'mat-ui)
(require 'mat-ivy)
(require 'mat-doom-modeline)
(require 'mat-rainbow)
(require 'mat-evil)
(require 'mat-bindings)
(require 'mat-project)
(require 'mat-git)
(require 'mat-org)
(require 'mat-lsp)
(require 'mat-company)
(require 'mat-eshell) 
(require 'mat-dirmode)
;(require 'mat-clojure-lsp)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(dired-hide-dotfiles dired-open all-the-icons-dired dired-single eshell-git-prompt evil-nerd-commenter company-box company lsp-treemacs lsp-ivy lsp-ui typescript-mode lsp-mode visual-fill-column org-bullets forge evil-magit magit counsel-projectile projectile hydra general evil-collection evil rainbow-delimiters doom-modeline counsel ivy-rich ivy helpful which-key dracula-theme command-log-mode all-the-icons use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

