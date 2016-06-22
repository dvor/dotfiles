(use-package elisp-slime-nav
  :ensure t
  :config
  (progn
    (defun my-lisp-hook ()
      (elisp-slime-nav-mode)
      (turn-on-eldoc-mode))
    (add-hook 'emacs-lisp-mode-hook 'my-lisp-hook)))

(provide 'init-slime)
