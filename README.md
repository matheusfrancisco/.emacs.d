* Multiple emacs config


clone https://github.com/plexus/chemacs2 and move emacs-profile.el to ~/.emacs-profiles.el
to add new profiles edit .emacs-profiles.el adding

(("default" . ((user-emacs-directory . "~/.emacs.default")))
 ("spacemacs" . ((user-emacs-directory . "~/spacemacs"))))
