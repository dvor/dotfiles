(defcustom dotemacs-cache-directory (concat user-emacs-directory ".cache/")
  "The storage location for various persistent files."
  :group 'dotemacs)

(add-to-list 'load-path (concat user-emacs-directory "/config"))

(if (fboundp 'with-eval-after-load)
    (defalias 'after-load 'with-eval-after-load)
  (defmacro after-load (feature &rest body)
    "After FEATURE is loaded, evaluate BODY."
    (declare (indent defun))
    `(eval-after-load ,feature
       '(progn ,@body))))

(require 'cl)
(require 'init-packages)

(let ((debug-on-error t))
  (require 'init-evil)
  (require 'init-slime)
;  (require 'init-company)
;  (require 'init-yasnippet)
  (require 'init-auto-complete)
  (require 'init-projectile))
