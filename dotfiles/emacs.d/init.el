(defcustom dotemacs-cache-directory (concat user-emacs-directory ".cache/")
  "The storage location for various persistent files."
  :group 'dotemacs)

(add-to-list 'load-path (concat user-emacs-directory "/config"))

(require 'cl)
(require 'init-packages)

(let ((debug-on-error t))
  (require 'init-evil)

  (require 'init-yasnippet))
