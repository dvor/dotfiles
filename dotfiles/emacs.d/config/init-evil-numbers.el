(use-package evil-numbers
  :ensure t
  :config
  (define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C-x") 'evil-numbers/dec-at-pt)
  (define-key evil-visual-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
  (define-key evil-visual-state-map (kbd "C-x") 'evil-numbers/dec-at-pt))

(provide 'init-evil-numbers)
