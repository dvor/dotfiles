(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode)

  (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "<backtab>") '(lambda () (interactive) (company-complete-common-or-cycle -1)))

  (define-key evil-insert-state-map (kbd "TAB") 'company-complete-common-or-cycle)

  (setq company-idle-delay 0)

  (setq company-dabbrev-downcase nil)
  (setq company-dabbrev-ignore-case nil)

  (setq company-backends
      '(company-elisp
        (
         ;; company-clang
          company-dabbrev-code
          company-dabbrev
          ;; company-capf
          ;; company-keywords
          company-files
          :with company-yasnippet))))

(provide 'init-companymode)
