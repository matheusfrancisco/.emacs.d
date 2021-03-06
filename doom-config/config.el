;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
; Emacs 29 bug
(general-auto-unbind-keys :off)
(remove-hook 'doom-after-init-modules-hook #'general-auto-unbind-keys)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "matheusfrancisco"
      user-mail-address "matheusmachadoufsc@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
(let ((nudev-emacs-path "~/m/dev/ides/emacs/"))
  (when (file-directory-p nudev-emacs-path)
    (add-to-list 'load-path nudev-emacs-path)
    (require 'nu nil t)
    (require 'nu-datomic-query nil t)))
;(add-to-list 'default-frame-alist '(fullscreen . maximized))
;

(add-to-list 'auto-mode-alist '("\\.repl\\'" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.ect\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.ejs\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.xtend\\'" . java-mode))
;;(add-to-list 'auto-mode-alist '("\\.dart\\'" . dart-mode))

(add-hook 'html-mode-hook #'turn-off-auto-fill)
(add-hook 'markdown-mode-hook #'turn-off-auto-fill)
(add-hook 'dart-mode-hook (lambda () (setq left-fringe-width 16)))
(add-hook 'java-mode-hook (lambda () (setq left-fringe-width 16)))

(load! "+functions")
(setq-default evil-kill-on-visual-paste nil)

(setq
 history-length 300
 indent-tabs-mode nil
 confirm-kill-emacs nil
 mode-line-default-help-echo nil
 show-help-function nil
 evil-multiedit-smart-match-boundaries nil
 compilation-scroll-output 'first-error

 read-process-output-max (* 1024 1024)

 projectile-project-search-path '("~/dev/" "~/dev/nu/" "~/dev/nu/mini-meta-repo/" "~/dev/nu/mini-meta-repo/packages/" "~/m/")
 projectile-enable-caching nil

 evil-split-window-below t
 evil-vsplit-window-right t

 counsel-rg-base-command "rg -i -M 1000 --no-heading --line-number --color never %s ."

 frame-title-format (setq icon-title-format  ;; set window title with "project"
                          '((:eval (projectile-project-name))))

 doom-big-font-increment 2

 doom-theme 'doom-dracula
 doom-themes-treemacs-theme "all-the-icons"
 doom-localleader-key ","

 +format-on-save-enabled-modes '(dart-mode)
 evil-collection-setup-minibuffer t
 org-directory "~/Google Drive/My Drive/org"

 mode-require-final-newline t

 )

(set-popup-rule! "\\*LSP Dart tests\\*" :height 0.3)
(set-popup-rule! "\\*dap-ui-locals\\*" :side 'right :width 0.3)
(set-popup-rule! "\\*dap-ui-sessions\\*" :side 'right :width 0.3)
(set-popup-rule! "\\*midje-test-report\\*" :side 'right :width 0.5)


(use-package! clojure-mode
  :config
  (setq clojure-indent-style 'align-arguments
        clojure-thread-all-but-last t)
   (cljr-add-keybindings-with-prefix "C-c C-c")
  )

(use-package! cider
  :after clojure-mode
  :config
  (setq cider-ns-refresh-show-log-buffer t
        cider-show-error-buffer t ;'only-in-repl
        cider-font-lock-dynamically nil ; use lsp semantic tokens
        cider-eldoc-display-for-symbol-at-point nil ; use lsp
        ;;cider-repl-display-in-current-window t
        cider-repl-pop-to-buffer-on-connect nil
        cider-prompt-for-symbol nil)

  (set-popup-rule! "*cider-test-report*" :side 'right :width 0.4)
  (set-popup-rule! "^\\*cider-repl" :quit nil)
  (set-lookup-handlers! 'cider-mode nil) ; use lsp
  (add-hook 'cider-mode-hook (lambda () (remove-hook 'completion-at-point-functions #'cider-complete-at-point))) ; use lsp
  )

(use-package! clj-refactor
  :after clojure-mode
  :config
  (set-lookup-handlers! 'clj-refactor-mode nil)
  (setq cljr-warn-on-eval nil
        cljr-eagerly-build-asts-on-startup nil
        cljr-add-ns-to-blank-clj-files nil ; use lsp
        cljr-magic-require-namespaces
        '(("s"   . "schema.core")
          ("gen" . "common-test.generators")
          ("d-pro" . "common-datomic.protocols.datomic")
          ("ex" . "common-core.exceptions.core")
          ("dth" . "common-datomic.test-helpers")
          ("t-money" . "common-core.types.money")
          ("t-time" . "common-core.types.time")
          ("d" . "datomic.api")
          ("m" . "matcher-combinators.matchers")
          ("pp" . "clojure.pprint"))))

(use-package! company
  :config
  (setq company-tooltip-align-annotations t
        company-frontends '(company-pseudo-tooltip-frontend)))

(use-package! company-quickhelp
  :init
  (company-quickhelp-mode)
  :config
  (setq company-quickhelp-delay nil
        company-quickhelp-use-propertized-text t
        company-quickhelp-max-lines 10))

(use-package! dap-mode
  :init
  (require 'dap-chrome)
  :config
  (setq dap-enable-mouse-support nil))

(use-package! hover
  :after dart-mode
  :config
  (setq hover-hot-reload-on-save t
        hover-clear-buffer-on-hot-restart t
        hover-screenshot-path "$HOME/Pictures"))


(defvar use-local-dart nil)

(use-package! lsp-dart
  :config
  (setq lsp-dart-dap-flutter-hot-reload-on-save t)
  (when use-local-dart
    (setq lsp-dart-sdk-dir (expand-file-name "~/flutter/bin/cache/dart-sdk")
          lsp-dart-flutter-sdk-dir (expand-file-name "~/flutter"))))

(use-package! lsp-java
  :after lsp
  :config
  (setq lsp-java-references-code-lens-enabled t
        lsp-java-implementations-code-lens-enabled t
        lsp-file-watch-ignored-directories
        '(".idea" ".ensime_cache" ".eunit" "node_modules"
          ".git" ".hg" ".fslckout" "_FOSSIL_"
          ".bzr" "_darcs" ".tox" ".svn" ".stack-work"
          "build")))

(use-package! lsp-mode
  :commands lsp
  :config
  (setq
  ;; lsp-clojure-custom-server-command '("bash" "-c" "~/usr/local/bin/clojure-lsp") ;; Remove it if you don't develop clojure-lsp in your machine
        lsp-headerline-breadcrumb-enable nil
        lsp-lens-enable t
        lsp-enable-file-watchers t
        lsp-signature-render-documentation nil
        lsp-signature-function 'lsp-signature-posframe
        lsp-semantic-tokens-enable t
        lsp-idle-delay 0.3
        lsp-use-plists nil
        lsp-completion-sort-initial-results t ; check if should keep as t
        lsp-completion-no-cache t
        lsp-completion-use-last-result nil)
  (advice-add #'lsp-rename :after (lambda (&rest _) (projectile-save-project-buffers)))
  (add-hook 'lsp-mode-hook (lambda () (setq-local company-format-margin-function #'company-vscode-dark-icons-margin)))
  )


(use-package! lsp-treemacs
  :config
  (setq lsp-treemacs-error-list-current-project-only t))

;; (use-package! treemacs-persp
;;   :when (featurep! :ui workspaces)
;;   :after (treemacs persp-mode)
;;   :config
;;   (treemacs-set-scope-type 'Perspectives))

;; (after! treemacs
;;   (defun +treemacs--init ()
;;     (require 'treemacs)
;;     (let ((origin-buffer (current-buffer)))
;;       (cl-letf (((symbol-function 'treemacs-workspace->is-empty?)
;;                  (symbol-function 'ignore)))
;;         (treemacs--init))
;;       (unless (bound-and-true-p persp-mode)
;;         (dolist (project (treemacs-workspace->projects (treemacs-current-workspace)))
;;           (treemacs-do-remove-project-from-workspace project)))
;;       (with-current-buffer origin-buffer
;;         (let ((project-root (or (doom-project-root) default-directory)))
;;           (treemacs-do-add-project-to-workspace
;;            (treemacs--canonical-path project-root)
;;            (doom-project-name project-root)))
;;         (setq treemacs--ready-to-follow t)
;;         (when (or treemacs-follow-after-init treemacs-follow-mode)
;;           (treemacs--follow))))))

(use-package! lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-peek-list-width 60
        lsp-ui-doc-max-width 60
        lsp-ui-doc-enable nil
        lsp-ui-peek-fontify 'always
        lsp-ui-sideline-show-code-actions nil))

(use-package! org-tree-slide
  :config
  (setq +org-present-text-scale 2
        org-tree-slide-skip-outline-level 2
        org-tree-slide-modeline-display 'outside
        org-tree-slide-fold-subtrees-skipped nil)
  (add-hook! 'org-tree-slide-play-hook
             #'org-display-inline-images
             #'doom-disable-line-numbers-h
             #'spell-fu-mode-disable
             #'hl-line-unload-function
             #'org-mode-hide-all-stars)
  (add-hook! 'org-tree-slide-stop-hook
             #'spell-fu-mode-enable
             #'hl-line-mode)
  ;; (add-hook! 'org-tree-slide-after-narrow-hook
  ;;            #'outline-show-all)
  )


(use-package! paredit
  :hook '((clojure-mode . paredit-mode)
         (emacs-lisp-mode . paredit-mode)))

(use-package! treemacs-all-the-icons
  :after treemacs)

(after! projectile
  (add-to-list 'projectile-project-root-files-bottom-up "pubspec.yaml")
  (add-to-list 'projectile-project-root-files-bottom-up "BUILD")
  (add-to-list 'projectile-project-root-files-bottom-up "project.clj"))

(put 'narrow-to-region 'disabled nil)

(def-modeline-var! +modeline-modes ; remove minor modes
  '(""
    mode-line-process
    "%n"))

(def-modeline! :main
  '(""
    +modeline-matches
    " "
    +modeline-buffer-identification
    +modeline-position)
  `(""
    mode-line-misc-info
    +modeline-modes
    "  "
    (+modeline-checker ("" +modeline-checker "    "))))

(set-modeline! :main 'default)


(load! "+bindings")
