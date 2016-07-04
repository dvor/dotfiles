(require 'package)

(add-to-list 'load-path (concat user-emacs-directory "/config"))

(setq package-enable-at-startup nil)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'init-appearance)
(require 'init-companymode)
(require 'init-general)
(require 'init-helm)
(require 'init-projectile)
(require 'init-slime)
(require 'init-swift-mode)
(require 'init-smartparens)
(require 'init-highlight-chars)
(require 'init-dash)
(require 'init-exec-path-from-shell)
(require 'init-ag)
(require 'init-powerline)

(require 'init-evil-commentary)
(require 'init-evil-leader)
(require 'init-evil-numbers)
(require 'init-evil-snipe)
(require 'init-evil)

(require 'init-nlinum-relative)
(require 'init-vertigo)

