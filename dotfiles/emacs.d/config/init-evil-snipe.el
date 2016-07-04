(use-package evil-snipe
  :ensure t
  :config
  (setq evil-snipe-parent-transient-map nil)
  (evil-snipe-mode 1)
  (setq evil-snipe-scope 'buffer))

(provide 'init-evil-snipe)
