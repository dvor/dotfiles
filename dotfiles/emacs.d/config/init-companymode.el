(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode)

  (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "<backtab>") '(lambda () (interactive) (company-complete-common-or-cycle -1)))

  (setq company-idle-delay 0)

  (setq company-backends
      '(company-elisp
         company-clang
         (company-capf
          company-dabbrev-code
          company-keywords
          company-files
          company-dabbrev
          :with company-yasnippet))))

(provide 'init-companymode)
