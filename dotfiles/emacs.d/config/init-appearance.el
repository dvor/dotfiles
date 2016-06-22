(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-light t))

(tool-bar-mode -1)
(menu-bar-mode -1)

(set-default-font "Monaco 16")
(custom-set-variables '(initial-frame-alist (quote ((fullscreen . maximized)))))

(provide 'init-appearance)
