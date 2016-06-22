(use-package nlinum-relative
  :ensure t
  :config
  (setq nlinum-relative-redisplay-delay 0)
  (nlinum-relative-setup-evil)
  (add-hook 'prog-mode-hook 'nlinum-relative-mode))

(provide 'init-nlinum-relative)
