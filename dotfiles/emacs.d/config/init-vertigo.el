(use-package vertigo
  :ensure t
  :config
  (define-key evil-normal-state-map (kbd "SPC") 'vertigo-alt-run-command-with-digit-argument))

(provide 'init-vertigo)
