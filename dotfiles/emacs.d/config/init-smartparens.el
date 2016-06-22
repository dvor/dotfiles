(use-package smartparens
  :ensure t
  :config
  (dolist (hook (list
                 'emacs-lisp-mode-hook
                 'swift-mode-hook
                 'objc-mode
                 'lisp-mode-hook))
    (add-hook hook '(lambda () (smartparens-mode t) (show-paren-mode))))

  (defun my-open-block-c-mode (id action context)
    (when (eq action 'insert)
      (message "wqqq!")
      (newline)
      (newline)
      (indent-according-to-mode)
      (previous-line)
      (indent-according-to-mode)))

  (sp-local-pair (list 'c-mode 'swift-mode) "{" nil :post-handlers '(bare list my-open-block-c-mode))
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil))

(provide 'init-smartparens)
