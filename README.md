* Multiple emacs config


clone https://github.com/plexus/chemacs2 and move emacs-profile.el to ~/.emacs-profiles.el
to add new profiles edit .emacs-profiles.el adding

(("default" . ((user-emacs-directory . "~/.emacs.default")))
 ("spacemacs" . ((user-emacs-directory . "~/spacemacs"))))


 I think chemacs2 has problem with doom-modeline when tried to download shrink-path then to fixed it
 you need to run git clone git@github.com:zbelial/shrink-path.el.git and move .emacs.multi/default/straight/repos/
