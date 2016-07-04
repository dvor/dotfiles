; disabling backup files
(setq make-backup-files nil)

(setq ring-bell-function 'ignore)

(setq inhibit-splash-screen t
      inhibit-startup-echo-area-message t
      inhibit-startup-message t)

(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)

;; Fixing colors for powerline. See https://github.com/milkypostman/powerline/issues/54
;(setq ns-use-srgb-colorspace nil)

(global-auto-revert-mode t)


(defun my-open-xcode-at-current-file ()
  "Open current file in Xcode pointing on current line"
  (interactive)
  (setq apscript (concat "
tell application \"Xcode\" to activate
tell application \"System Events\"
  tell process \"Xcode\"
    delay 0.3
    keystroke \"o\" using {shift down, command down}
    keystroke \""
                         (file-name-nondirectory (buffer-file-name))
                         ":"
                         (nth 1 (split-string (what-line) " "))
                         "\"
    key code {52}
  end tell
end tell
"
        ))
  (do-applescript apscript))


(provide 'init-general)
