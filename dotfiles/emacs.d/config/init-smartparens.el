(use-package smartparens
  :ensure t
  :config
  (dolist (hook (list
                 'emacs-lisp-mode-hook
                 'swift-mode-hook
                 'objc-mode-hook
                 'c-mode-hook
                 'c++-mode-hook
                 'lisp-mode-hook))
    (add-hook hook '(lambda () (smartparens-mode t) (show-paren-mode))))

  (setq c-basic-offset 4)

  (defun my-open-block-c-mode (id action context)
    (when (eq action 'insert)
      (newline)
      (newline)
      (indent-according-to-mode)
      (previous-line)
      (indent-according-to-mode)))

  (sp-local-pair (list 'c-mode 'swift-mode 'objc-mode 'c++-mode) "{" nil :post-handlers '(bare list my-open-block-c-mode))
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil))

(provide 'init-smartparens)
