(use-package evil-leader
  :ensure t
  :config
  (defun my-window-split ()
    "Horizontally split window and move cursor to a new pane"
    (interactive)
    (evil-window-split)
    (evil-window-down 1))

  (defun my-window-vsplit ()
    "Vertically split window and move cursor to a new pane"
    (interactive)
    (evil-window-vsplit)
    (evil-window-right 1))

  (evil-leader/set-leader ",")
  (evil-leader/set-key
    "s" 'my-window-split
    "f" 'my-window-vsplit
    "d" 'delete-window
    "o" 'delete-other-windows
    "b" 'ibuffer
    "h" 'help-command
    "t" 'eshell
    "a" 'projectile-find-other-file
    "v" 'dash-at-point)
  (global-evil-leader-mode))

(provide 'init-evil-leader)
