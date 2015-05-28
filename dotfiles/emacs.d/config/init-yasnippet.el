(require-package 'yasnippet)
(require 'yasnippet)

(setq yas-snippet-dirs (concat user-emacs-directory "/snippets"))
(yas/initialize)

(yas-global-mode 1)
(add-hook 'evil-mode-hook  'yas-minor-mode)

(provide 'init-yasnippet)

