(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-light t))

(tool-bar-mode -1)
(menu-bar-mode -1)

(setq default-frame-alist '((font . "Monaco 16") (fullscreen . maximized)))

(provide 'init-appearance)
