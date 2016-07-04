(defface my-pl-segment1-active
  '((t (:foreground "#000000" :background "#E1B61A")))
  "Powerline first segment active face.")
(defface my-pl-segment1-inactive
  '((t (:foreground "#CEBFF3" :background "#3A2E58")))
  "Powerline first segment inactive face.")
(defface my-pl-segment2-active
  '((t (:foreground "#F5E39F" :background "#8A7119")))
  "Powerline second segment active face.")
(defface my-pl-segment2-inactive
  '((t (:foreground "#CEBFF3" :background "#3A2E58")))
  "Powerline second segment inactive face.")
(defface my-pl-segment3-active
  '((t (:foreground "#CEBFF3" :background "#3A2E58")))
  "Powerline third segment active face.")
(defface my-pl-segment3-inactive
  '((t (:foreground "#CEBFF3" :background "#3A2E58")))
  "Powerline third segment inactive face.")

(defun air--powerline-default-theme ()
  "Set up my custom Powerline with Evil indicators."
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (seg1 (if active 'my-pl-segment1-active 'my-pl-segment1-inactive))
                          (seg2 (if active 'my-pl-segment2-active 'my-pl-segment2-inactive))
                          (seg3 (if active 'my-pl-segment3-active 'my-pl-segment3-inactive))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          (powerline-current-separator)
                                                          (car powerline-default-separator-dir))))
                          (separator-right (intern (format "powerline-%s-%s"
                                                           (powerline-current-separator)
                                                           (cdr powerline-default-separator-dir))))
                          (lhs (list (let ((evil-face (powerline-evil-face)))
                                       (if evil-mode
                                           (powerline-raw (powerline-evil-tag) evil-face)
                                         ))
                                     (if evil-mode
                                         (funcall separator-left (powerline-evil-face) seg1))
                                     (powerline-buffer-id seg1 'l)
                                     (powerline-raw "[%*]" seg1 'l)
                                     (when (and (boundp 'which-func-mode) which-func-mode)
                                       (powerline-raw which-func-format seg1 'l))
                                     (powerline-raw " " seg1)
                                     (funcall separator-left seg1 seg2)
                                     (when (boundp 'erc-modified-channels-object)
                                       (powerline-raw erc-modified-channels-object seg2 'l))
                                     (powerline-major-mode seg2 'l)
                                     (powerline-process seg2)
                                     (powerline-minor-modes seg2 'l)
                                     (powerline-narrow seg2 'l)
                                     (powerline-raw " " seg2)
                                     (funcall separator-left seg2 seg3)
                                     (powerline-vc seg3 'r)
                                     (when (bound-and-true-p nyan-mode)
                                       (powerline-raw (list (nyan-create)) seg3 'l))))
                          (rhs (list (powerline-raw global-mode-string seg3 'r)
                                     (funcall separator-right seg3 seg2)
                                     (unless window-system
                                       (powerline-raw (char-to-string #xe0a1) seg2 'l))
                                     (powerline-raw "%4l" seg2 'l)
                                     (powerline-raw ":" seg2 'l)
                                     (powerline-raw "%3c" seg2 'r)
                                     (funcall separator-right seg2 seg1)
                                     (powerline-raw " " seg1)
                                     (powerline-raw "%6p" seg1 'r)
                                     (when powerline-display-hud
                                       (powerline-hud seg1 seg3)))))
                     (concat (powerline-render lhs)
                             (powerline-fill seg3 (powerline-width rhs))
                             (powerline-render rhs)))))))







(defun powerline--expand-alist (alist)
  (cl-loop for (keys . vals) in alist append
     (mapcar #'(lambda (key) (cons key vals)) keys)))

(defun powerline--build-face (fg &optional bg bold)
  `((t (:foreground ,fg
        :background ,bg
        :bold ,bold
        :overline ,(when (null powerline-default-separator) bg)
        :underline nil
        :box ,(when (eq powerline-default-separator 'utf-8) bg)))))

(defun powerline--gen-facedef (feature mode args)
  (let* ((name (format "powerline-%s-%s" feature mode))
         (doc (format "Powerline face %s" name)))
    `(defface ,(intern name)
       (quote ,(apply 'powerline--build-face args))
       ,doc)))

(defun powerline--generate-facedefs (alist)
  (cl-loop for (feature . modes) in alist append
    (cl-loop for (mode . args) in modes collect
       (powerline--gen-facedef feature mode args))))

;; Color definitions
(setf powerline-vim-colors-alist
      (let ((black "#000000")                 ; 16
            (white "#FFFFFF")                 ; 231
            
            (darkestgreen "#005F00")          ; 22
            (darkgreen "#008700")             ; 28
            (mediumgreen "#5faf00")           ; 70
            (brightgreen "#afd700")           ; 148
            
            (darkestcyan "#005f5f")           ; 23
            (mediumcyan "#87d7ff")            ; 117
            
            (darkestblue "#005f87")           ; 24
            (darkblue "#0087af")              ; 31
            
            (darkestred "#5f0000")            ; 52
            (darkred "#870000")               ; 88
            (mediumred "#af0000")             ; 124
            (brightred "#d70000")             ; 160
            (brightestred "#ff0000")          ; 196
            
            (darkestpurple "#5f00af")         ; 55
            (mediumpurple "#875fd7")          ; 98
            (brightpurple "#d7d7ff")          ; 189
            
            (brightorange "#ff8700")          ; 208
            (brightestorange "#ffaf00")       ; 214
            
            (gray0 "#121212")                 ; 233
            (gray1 "#262626")                 ; 235
            (gray2 "#303030")                 ; 236
            (gray3 "#4e4e4e")                 ; 239
            (gray4 "#585858")                 ; 240
            (gray5 "#626262")                 ; 241
            (gray6 "#808080")                 ; 244
            (gray7 "#8a8a8a")                 ; 245
            (gray8 "#9e9e9e")                 ; 247
            (gray9 "#bcbcbc")                 ; 250
            (gray10 "#d0d0d0"))               ; 252

        (powerline--expand-alist
         `((("SPLIT")
            (normal      ,white           ,gray2)
            (inactive    ,white           ,gray0)
            (insert      ,white           ,darkestblue))
           
           (("state_indicator")
            (normal       ,darkestgreen    ,brightgreen  t)
            ;;(inactive    ,gray6           ,gray2      t)
            (insert       ,darkestcyan     ,white        t)
            (visual       ,darkred         ,brightorange t)
            (replace      ,white           ,brightred    t)
            (select       ,white           ,gray5        t)
            (motion       ,brightpurple    ,mediumpurple t)
            (emacs        ,darkestcyan     ,white        t)
            (iedit        ,darkred         ,brightestred t)
            (lisp         ,brightpurple    ,mediumpurple t))
           
           (("branch" "scrollpercent" "raw" "filesize")
            (normal      ,gray9           ,gray4)
            (inactive    ,gray4           ,gray1)
            (insert      ,mediumcyan      ,darkblue))
           
           (("fileinfo" "filename")
            (normal      ,white           ,gray4        t)
            (inactive    ,gray7           ,gray1        t)
            (insert      ,white           ,darkblue     t))
           
           (("fileinfo.filepath")
            (normal      ,gray10)
            (inactive    ,gray5)
            (insert      ,mediumcyan))
           
           (("static_str")
            (normal      ,white           ,gray4)
            (inactive    ,gray7           ,gray1)
            (insert      ,white           ,darkblue))
           
           (("fileinfo.flags")
            (normal      ,brightestred    nil          t)
            (inactive    ,darkred)
            (insert      ,brightestred    nil          t))
           
           (("currenttag" "fullcurrenttag" "fileformat" "fileencoding"
             "pwd" "filetype" "rvm.string" "rvm.statusline"
             "virtualenv.statusline" "charcode" "currhigroup")
            (normal      ,gray8           ,gray2)
            (inactive    ,gray3           ,gray0)
            (insert      ,mediumcyan      ,darkestblue))
           
           (("lineinfo")
            (normal      ,gray2           ,gray10       t)
            (inactive    ,gray7           ,gray1        t)
            (insert      ,darkestcyan     ,mediumcyan   t))
           
           (("errors")
            (normal      ,brightestorange ,gray2 t)
            (insert      ,brightestorange ,darkestblue  t))
           
           (("lineinfo.line.tot")
            (normal      ,gray6)
            (inactive    ,gray5)
            (insert      ,darkestcyan))
           
           (("paste_indicator" "ws_marker")
            (normal      ,white           ,brightred    t))
           
           (("gundo.static_str.name" "command_t.static_str.name")
            (normal      ,white           ,mediumred    t)
            (inactive    ,brightred       ,darkestred   t))
           
           (("gundo.static_str.buffer" "command_t.raw.line")
            (normal      ,white           ,darkred)
            (inactive    ,brightred       ,darkestred))
           
           (("gundo.SPLIT" "command_t.SPLIT")
            (normal      ,white           ,darkred)
            (inactive    ,white           ,darkestred))
           
           (("lustyexplorer.static_str.name"
             "minibufexplorer.static_str.name"
             "nerdtree.raw.name" "tagbar.static_str.name")
            (normal      ,white           ,mediumgreen  t)
            (inactive    ,mediumgreen     ,darkestgreen t))
           
           (("lustyexplorer.static_str.buffer"
             "tagbar.static_str.buffer")
            (normal      ,brightgreen     ,darkgreen)
            (inactive    ,mediumgreen     ,darkestgreen))
           
           (("lustyexplorer.SPLIT" "minibufexplorer.SPLIT"
             "nerdtree.SPLIT" "tagbar.SPLIT")
            (normal      ,white           ,darkgreen)
            (inactive    ,white           ,darkestgreen))
           
           (("ctrlp.focus" "ctrlp.byfname")
            (normal      ,brightpurple    ,darkestpurple))

           (("ctrlp.prev" "ctrlp.next" "ctrlp.pwd")
            (normal      ,white           ,mediumpurple))
           
           (("ctrlp.item")
            (normal      ,darkestpurple   ,white         t))
           
           (("ctrlp.marked")
            (normal      ,brightestred    ,darkestpurple t))

           (("ctrlp.count")
            (normal      ,darkestpurple   ,white))

           (("ctrlp.SPLIT")
(normal ,white ,darkestpurple))))))





(defface powerline-active3 '((t (:background "#afd700"
                                             :foreground "#008700"
                                             :inherit mode-line)))
  "Powerline face 3."
  :group 'powerline)

(defface powerline-inactive3 '((t (:foreground "grey90" :background "grey30" :inherit mode-line)))
  "Powerline face 3."
  :group 'powerline)

(defun check-in-list (list elems)
  (catch 'tag
    (dolist (elem elems)
      (if (member elem list)
          (throw 'tag elem)))))

;; Get a face for the current input mode and
;; desired feature. Defaults to "powerline-FEATURE-normal"
(defun pl/get-vim-face (face)
  "Find whether or not FACE is a valid face,
and if not, try to get the corresponding 
'-normal' face "
  (let* ((face (replace-regexp-in-string "iedit-insert" "iedit" face))
         (split-face-name nil) (concat-face-name nil) ; some variables we'll use later on
         (report-wrong-prefix ; Our error reporter. Because we don't want to return nil.
          (lambda () (let ((prefix (subseq (or split-face-name (split-string face "-")) 0 2)))
                       (error "There's no vim face with the prefix: %s"
                              (mapconcat 'identity prefix "-"))))))
    
    (cond ((facep face)                 ; If our face is a FACE (even if it's not a powerline face)
           (intern face))               ; just intern the string and send it back

          ;; Otherwise.
          ;; Are we a list of only three items?  
          ;; Is the first item a string that is 'powerline'?  
          ;; Is the last element not 'normal'? (If it was valid, it would have already passed)          
          ((and (setf split-face-name (split-string face "-"))
                (string-equal (cl-first split-face-name) "powerline")
                (not (string-equal (cl-third split-face-name) "normal")))

           ;; If we passed all the tests above, then we try to create a valid
           ;; powerline-face symbol
           (progn
             (setf (cl-third split-face-name) "normal")

             ;; Re-build our string from the split pieces
             (setf concat-face-name (mapconcat 'identity split-face-name "-"))

             ;; And do one final check to make sure it's a face
             ;; before sending it off
             ;; (message "Concatenated name: %s" concat-face-name)
             (if (facep concat-face-name)
                 (intern concat-face-name)
               (report-wrong-prefix))))

          ;; Always fallthrough to the error
          (t (report-wrong-prefix)))))


(defmacro pl/vim-face (name state)
`(pl/get-vim-face (format "powerline-%s-%s" ,name ,state)))



(defun powerline-vimish-theme ()
  "Setup the default mode-line."
  ;; Populate our faces 
  (mapcar 'eval  (powerline--generate-facedefs powerline-vim-colors-alist))
  (set-face-attribute 'mode-line-inactive nil
                      :background (face-background (pl/vim-face "SPLIT" "inactive")) :underline nil
                      :overline nil :box nil)
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (harddiv-left (intern (format "powerline-%s-%s"
                                                          (powerline-current-separator)
                                                          (car powerline-default-separator-dir))))
                          (harddiv-right (intern (format "powerline-%s-%s"
                                                           (powerline-current-separator)
                                                           (cdr powerline-default-separator-dir))))
                          (softdiv-left (cl-case powerline-default-separator
                                          ((utf-8 arrow) "")
                                          ((bar nil) "|")
                                          (brace "}")
                                          (t ">")))
                          (softdiv-right (cl-case powerline-default-separator
                                          ((utf-8 arrow) "")
                                          ((bar nil) "|")
                                          (brace "{")
                                          (t "<")))
                          (editor-state (cond ((and active (boundp 'evil-mode) evil-mode)
                                               (symbol-name evil-state))
                                              (active "active")
                                              (t "inactive")))
                          (state-indicator-face (pl/vim-face "state_indicator" editor-state))
                          (vc-face              (pl/vim-face "branch" editor-state))
                          (fileinfo-face        (pl/vim-face "fileinfo" editor-state))
                          (split-face           (pl/vim-face "SPLIT" editor-state))

                          (fileformat-face      (pl/vim-face "fileformat" editor-state))
                          (fileencoding-face    (pl/vim-face "fileencoding" editor-state))
                          (filetype-face        (pl/vim-face "filetype" editor-state))

                          (scrollpercent-face   (pl/vim-face "scrollpercent" editor-state))
                          (lineinfo-face        (pl/vim-face "lineinfo" editor-state))
                          
                          (input (split-string (symbol-name buffer-file-coding-system) "-"))
                          (platform (check-in-list input '("mac" "unix" "dos")))
                          (encoding (mapconcat 'identity (delete platform input) "-"))
                          
                          ;; Left hand side
                          (lhs (list
                                (powerline-raw (format " %s " (upcase editor-state)) state-indicator-face)
                                (funcall harddiv-left state-indicator-face vc-face)
                                (when (and (buffer-file-name (current-buffer)) vc-mode)
                                  (concat
                                   (powerline-raw (downcase (format-mode-line '(vc-mode vc-mode))) vc-face 'r)
                                   (powerline-raw softdiv-left vc-face)))
                                (powerline-buffer-id fileinfo-face 'l)
                                (powerline-raw "%*" fileinfo-face 'lr)
                                (powerline-narrow fileinfo-face 'l)
                                (funcall harddiv-left fileinfo-face split-face)))

                          ;; Right Hand Side
                          (rhs (list
                                (powerline-raw global-mode-string split-face 'r)
                                (funcall harddiv-right split-face fileformat-face)
                                (concat
                                 (when (not (null platform))
                                   (concat (powerline-raw platform fileformat-face 'r)
                                           (powerline-raw softdiv-right fileformat-face)))
                                 (powerline-raw encoding fileencoding-face 'lr)
                                 (powerline-raw softdiv-right fileencoding-face))
                                (powerline-major-mode filetype-face 'lr)
                                (funcall harddiv-right filetype-face scrollpercent-face)
                                (powerline-raw "%p" scrollpercent-face 'lr)
                                (funcall harddiv-right scrollpercent-face lineinfo-face)
                                (powerline-raw "%l" lineinfo-face 'l)
                                (powerline-raw ":" lineinfo-face 'lr)
                                (powerline-raw "%c" lineinfo-face 'r))))

                     (when active
                       (set-face-attribute 'mode-line nil :underline nil :overline nil :box nil))
                     (if (and (null powerline-default-separator)
                              (null  (face-attribute 'powerline-SPLIT-normal :overline)))
                         nil
                       nil)
                     (concat (powerline-render lhs)
                             (powerline-fill split-face (powerline-width rhs))
(powerline-render rhs)))))))

(use-package powerline
  :ensure t
  :config
     ;Valid Values: alternate, arrow, arrow-fade, bar, box, brace,
   ;butt, chamfer, contour, curve, rounded, roundstub, wave, zigzag,
   ;utf-8.
  ;(setq powerline-default-separator (if (display-graphic-p) 'wave
  ;                                    nil))
  ;(air--powerline-default-theme))
  (powerline-vimish-theme))


(use-package powerline-evil
  :ensure t)

(provide 'init-powerline)
