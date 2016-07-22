(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  ; For some reason evil-want-C-u-scroll doesn't work, setting it manually
  (define-key evil-normal-state-map "\C-u" 'evil-scroll-up)
  :config

  (evil-mode t)

  (setq evil-emacs-state-modes (delq 'ibuffer-mode evil-emacs-state-modes))

  (define-key ibuffer-mode-map (kbd "/") 'evil-search-forward)
  (define-key ibuffer-mode-map (kbd "?") 'evil-search-backward)
  (define-key ibuffer-mode-map (kbd "n") 'evil-search-next)
  (define-key ibuffer-mode-map (kbd "N") 'evil-search-previous)
  (define-key ibuffer-mode-map (kbd "w") 'evil-forward-word-begin)
  (define-key ibuffer-mode-map (kbd "W") 'evil-forward-WORD-begin)
  (define-key ibuffer-mode-map (kbd "b") 'evil-backward-word-begin)
  (define-key ibuffer-mode-map (kbd "B") 'evil-backward-WORD-begin)
  (define-key ibuffer-mode-map (kbd "C-d") 'evil-scroll-down)
  (define-key ibuffer-mode-map (kbd "C-u") 'evil-scroll-up)

  (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
  (define-key evil-normal-state-map (kbd "C-p") 'helm-projectile-find-file)

 ; (define-key evil-insert-state-map (kbd "TAB") 'company-complete)
  )

(provide 'init-evil)
