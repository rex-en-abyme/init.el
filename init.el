(require 'package)

;; insert file name from helm buffer into current buffer: `C-c <tab>`
;; Flight things:
;; C-h P: Check source code for package
;; Look up something in the manual: `C-h S` (M-x info-lookup-symbol)

;; Going through helm-intro



;; Commands to get used to, Bookmarks:
;; `C-x r m` - Add Bookmark
;; `C-x r b` - Show Bookmarks


;; TODOs
;; - [ ] I keep losing my cursor position
;; - [ ] research info-look-more-mode
;; - [ ] research redshank-mode
;; - [ ] Add eldoc mode, which shows fn args, etc.
;; - [ ] Anytime a new window pops up, as with C-h f, move point to said new window (like it does with C-x g for `Magit')
;; - [ ] M-d backwards region
;; - [X] M-n & M-N don't retain cursor position
;; - [ ] M-n & M-N don't work with a multiline region, fix it


;; VimGolf



;;------------------------Notes:------------------------------;;
;; Helm Buffer List. Kill from buffer list ;; M-D ;;
;; Have word/etc. at point be passed directly to forward-search
;; (C-h r  || C-h i) --> Emacs Lisp docs
;; C-h C-a --> about-emacs
;; Read a single Emacs Lisp expression in the minibuffer, evaluate it,
;;  and then print the value in the echo area use: `M-:`
;; To show current major mode evaluate the varaible: `major-mode`
;; M-m back-to-indentation (C-a for indented code)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; > elisp source code already lived here:                  ;;
;; "/usr/local/Cellar/emacs/24.5/share/emacs/24.5/lisp/"    ;;
;; > C source code linking:                                 ;;
;; Downloaded source corresponding to `emacs-version' from: ;;
;; https://ftp.gnu.org/pub/gnu/emacs/, and unpacked here:   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(setq source-directory "/usr/local/Cellar/emacs/24.5/downloaded_c_src/emacs-24.5/")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; You can use a ‘load’ command to evaluate a complete file and thereby ;;
;; install all the functions and variables in the file into Emacs.  For ;;
;; example:   (load "~/emacs/slowsplit")                                ;;
;;            (load-library) <-- interactive (library == file           ;;
;;            (load-file)    <-- this too                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Instead of specifying the exact location of the extension file, ;;
;; you can specify that directory as part of Emacs’s ‘load-path’.  ;;
;; Then, when Emacs loads a file, it will search that directory as ;;
;; well as its default list of directories. The default list is    ;;
;; specified in ‘paths.h’ when Emacs is built.                     ;;
;; (setq load-path (cons "~/emacs" load-path))                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; `autoload' - lazy evaluation of a source file
;; But what is `add-to-list'?


(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For rtant compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))


(package-initialize)


(exec-path-from-shell-initialize)


;; https://www.emacswiki.org/emacs/NoTabs
(setq-default indent-tabs-mode nil)


;; Disable aggressive default auto-save and backup configs
(setq backup-inhibited t)
(setq auto-save-default nil)


;; CLISP (!sbcl)
;; see: http://abizern.org/2013/03/31/setting-up-for-lisp-on-os-x/
;; and: http://www.jonathanfischer.net/modern-common-lisp-on-osx/
;; and: http://www.lothlorien.com/kf6gpe/?p=24
;; from running (ql:quickload "quicklisp-slime-helper")
(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
;; also have sbcl, so...
(setq slime-default-lisp 'clisp)
(setq inferior-lisp-program "/usr/local/bin/clisp")
(require 'slime)
(slime-setup)


;; Getting Started: https://magit.vc/manual/magit/Getting-started.html#Getting-started
(global-set-key (kbd "C-x g") 'magit-status)


;; constantly read buffer from file ;; (global-auto-revert-mode 1)
;; better way seems to be 'g' (refresh) from buffer list,


;; https://github.com/jixiuf/dired-filetype-face (improves many things but only file names)
(require 'dired-filetype-face)





;; minimal gui ux
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)

;; Disable scroll-bar-mode in new frames as well
;; http://emacs.stackexchange.com/questions/23773/disable-scrollbar-on-new-frame#answer-23785
(defun wrx/disable-scroll-bars (frame)
  (modify-frame-parameters frame
                           '((vertical-scroll-bars . nil)
                             (horizontal-scroll-bars . nil))))
(add-hook 'after-make-frame-functions 'wrx/disable-scroll-bars)






(global-anzu-mode +1)
(anzu-mode +1)









;; https://github.com/zk-phi/indent-guide
(require 'indent-guide)
(indent-guide-global-mode)

;; smooth & slow scroll settings (from Andrew Summers on Elixir slack emacs channel)
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-scroll-amount '(5 ((shift) . 1)))



;; https://github.com/justbur/emacs-which-key
(which-key-mode)



;; (global-linum-mode t)
;; (global-hl-line-mode 1) ; turn on highlighting current line
;; (require 'blank-mode)
;; highlight w/ linum mode
;; (require 'hlinum)
;; (hlinum-activate)

;; Linum(ber)s too large
;; See: http://unix.stackexchange.com/questions/7507/emacs-text-scale-adjust-causes-line-numbers-column-to-incrementally-shrink-and-d#answer-238465
(eval-after-load "linum"
  '(set-face-attribute 'linum nil :height 100))






;;autoloading paredit-mode prevents it from being diminished
;;(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)












(require 'powerline)

;; TODO not sure what `add-to-list' does, or if it's needed with melpa packages
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/moe-theme.el/")
;;(add-to-list 'load-path "~/.emacs.d/moe-theme.el/")


(require 'moe-theme)
(moe-dark)


;; Customize Powerline


(powerline-default-theme)
(powerline-moe-theme)
(moe-theme-set-color 'green)


















;; HideShow, see emacswiki
(add-hook 'prog-mode-hook #'hs-minor-mode)
(global-set-key (kbd "C-c <right>") 'hs-show-block)
(global-set-key (kbd "C-c <left>") 'hs-hide-block)





















(show-paren-mode t)
(setq show-paren-style 'expression)

;; Prevent addn of `#coding: utf-8` to line 1 of all ruby files
;; http://stackoverflow.com/questions/6453955/how-do-i-prevent-emacs-from-adding-coding-information-in-the-first-line#answer-6454077
(setq ruby-insert-encoding-magic-comment nil)

;; Rainbow Delimeters
(require 'rainbow-delimiters)
;; (global-rainbow-delimiters-mode)
(add-hook 'ruby-mode-hook 'rainbow-delimiters-mode)
(add-hook 'c-mode-common-hook 'rainbow-delimiters-mode)
(add-hook 'python-mode-hook 'rainbow-delimiters-mode)
(add-hook 'shell-mode-hook 'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)






;; server
(require 'elnode)


;; neotree https://github.com/jaypei/emacs-neotree
(require 'neotree)
(setq neo-window-width 50)
(setq neo-persist-show nil)


;; alchemist
(require 'alchemist)




















(require 'multiple-cursors)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)







;; See: https://github.com/hrs/dotfiles/blob/master/emacs.d/configuration.org

(require 'org-bullets)
(add-hook 'org-rmode-hook (lambda () (org-bullets-mode 1)))

;; See: http://stackoverflow.com/questions/27129338/inline-images-in-org-mode#answer-27130349
(setq org-startup-with-inline-images t)

;; From https://www.youtube.com/watch?v=lsYdK0C2RvQ
;; (Embedding Code Snippets In Org Mode)
;;(require 'org-latex)
;;(setq org-export-latex-listings 'minted)
;;(add-to-list 'org-export-latex-package-alist '("" "minted"))
;; I think only needed this for syntax highlighting
(setq org-src-fontify-natively t)

;; See http://stackoverflow.com/questions/11670654/how-to-resize-images-in-org-mode#answer-38477233
;; TODO Note: doesn't seem to be doing anything
(setq org-image-actual-width nil)





















;; helm https://github.com/emacs-helm/helm
;; (require 'helm) -> helm-core
;; Also see: http://tuhdo.github.io/helm-intro.html
(require 'helm)
(require 'helm-config)
(require 'helm-swoop)
;;WIFIB9803D
;;4L4IH9AKUQRYP5YN
;;Dz8&bdGjGEvK

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z") 'helm-select-action) ; list actions using C-z


(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)
;; pass along search query (from -> to)
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)

(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-unset-key (kbd "C-x C-b")) ;; Rm in favor of 'helm-buffers-list

(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)

(global-set-key (kbd "C-x r b") 'helm-bookmarks)
(global-set-key (kbd "C-x m") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; This [[http://tuhdo.github.io/helm-intro.html#sec-17][tutorial]] explains
;; Helm has an interface for browsing both local and global mark-rings: 
(global-set-key (kbd "C-x C-x") 'helm-mark-ring)
;; and `helm-all-mark-rings'

;; http://tuhdo.github.io/helm-projectile.html
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(global-set-key (kbd "M-O") 'helm-projectile-find-file)

(global-set-key (kbd "M-?") 'comment-region)

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' .
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)


(helm-mode 1)
(helm-autoresize-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 2)
 '(custom-safe-themes
   (quote
    ("603a9c7f3ca3253cb68584cb26c408afcf4e674d7db86badcfe649dd3c538656" default)))
 '(helm-ag-base-command "ag --nocolor --nogroup --ignore-case")
 '(helm-ag-command-option "--all-text")
 '(helm-ag-insert-at-point (quote symbol))
 '(helm-follow-mode-persistent t)
 '(initial-buffer-choice "~/.emacs.d/init.el")
 '(js2-basic-offset 2)
 '(web-mode-code-indent-offset 2)
 '(web-mode-enable-auto-indentation nil)
 '(web-mode-markup-indent-offset 2))









;; ace-window
(global-set-key (kbd "M-p") 'ace-window)
;; ace-window uses avy behind the scenes,
;; use avy for in-file tree based navigation
(global-set-key (kbd "C-c j") 'avy-goto-word-or-subword-1)
(global-set-key (kbd "s-.") 'avy-goto-word-or-subword-1)
(global-set-key (kbd "s-w") 'ace-window)






(require 'company)

;;To use company-mode in all buffers:
(add-hook 'after-init-hook 'global-company-mode)
;;To see or change the list of enabled back-ends,
;;type M-x customize-variable RET company-backends

;; expand-region https://github.com/magnars/expand-region.el
;;(require 'expand-region)


;;(global-set-key (kbd "M-N") 'er/contract-region);;TODO Change

;;----------;;
;; elscreen ;;
;;----------;;
;; For help on how to use elscreen, try \C-z ?.
;;(elscreen-start)

(require 'helm-company)
;; https://github.com/manuel-uberti/helm-company
(autoload 'helm-company "helm-company") ;; Not necessary if using ELPA package
(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-:") 'helm-company)
     (define-key company-active-map (kbd "C-:") 'helm-company)))






















;; (web-mode-set-content-type "jsx")


;; http://cha1tanya.com/2015/06/20/configuring-web-mode-with-jsx.html
;; favor js2-mode over javascript-mode ;;
(require 'js2-mode)
;;(add-to-list 'auto-mode-alist `(,(rx ".js" string-end) . js2-mode))
;; ^ turned off for web-mode

;;(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
;;(autoload 'jsx-mode "jsx-mode" "JSX mode" t)



;; See: http://www.cyrusinnovation.com/initial-emacs-setup-for-reactreactnative/
(setq web-mode-markup-indent-offset 2
      web-mode-css-indent-offset 2
      web-mode-code-indent-offset 2)
(setq js-indent-level 2)




(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-content-types-alist
      '(("jsx" . "\\.js[x]?\\'")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq web-mode-content-types-alist                 ;;
;;   '(("json" . "/some/path/.*\\.api\\'")            ;;
;;     ("xml"  . "/other/path/.*\\.api\\'")           ;;
;;     ("jsx"  . "/some/react/path/.*\\.js[x]?\\'"))) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


















(require 'highlight-thing)
(global-highlight-thing-mode)




























;; See: http://emacs.stackexchange.com/questions/169/how-do-i-reload-a-file-in-a-buffer#answer-171
(defun wrx/revert-buffer-no-confirm ()
    "Revert buffer without confirmation."
    (interactive)
    (revert-buffer t t))

(global-set-key (kbd "M-F") 'wrx/revert-buffer-no-confirm)









;; TODO Do not hijack the clip-board spot
(defun wrx/duplicate-line-or-region (beg end)
  "Implements functionality of JetBrains' `Command-d' shortcut for `duplicate-line'.
   BEG & END correspond point & mark, smaller first
   `use-region-p' explained: 
   http://emacs.stackexchange.com/questions/12334/elisp-for-applying-command-to-only-the-selected-region#answer-12335"
  (interactive "r")
  (if (use-region-p)
      (wrx/duplicate-region-in-buffer beg end)
    (wrx/duplicate-line-in-buffer)))

(defun wrx/duplicate-region-in-buffer (beg end)
  "copy and duplicate context of current active region
   |------------------------+----------------------------|
   |        before          |           after            |
   |------------------------+----------------------------|
   | first <MARK>line here  | first line here            |
   | second item<POINT> now | second item<MARK>line here |
   |                        | second item<POINT> now     |
   |------------------------+----------------------------|
   TODO: Acts funky when point < mark"
  (set-mark-command nil)
  (insert (buffer-substring beg end))
  (setq deactivate-mark nil))

(defun wrx/duplicate-line-in-buffer ()
  "Duplicate current line, maintaining column position.
   |--------------------------+--------------------------|
   |          before          |          after           |
   |--------------------------+--------------------------|
   | lorem ipsum<POINT> dolor | lorem ipsum dolor        |
   |                          | lorem ipsum<POINT> dolor |
   |--------------------------+--------------------------|
   TODO: Save history for `Cmd-Z'
   Context: 
   http://stackoverflow.com/questions/88399/how-do-i-duplicate-a-whole-line-in-emacs#answer-551053"
  (setq columns-over (current-column))
  (save-excursion
    (kill-whole-line)
    (yank)
    (yank))
  (right-char columns-over)
  (next-line))

(global-set-key (kbd "M-D") 'wrx/duplicate-line-or-region)












(defun wrx/move-line-or-region-up (beg end)
  "BEG & END correspond point & mark, smaller first
   `use-region-p' explained: 
   http://emacs.stackexchange.com/questions/12334/elisp-for-applying-command-to-only-the-selected-region#answer-12335"
  (interactive "r")
  (if (use-region-p)
      (wrx/move-region-up beg end)
    (wrx/move-line-up)))

(defun wrx/move-region-up ()
  "asd asd asd"
  (interactive)
  (print "WRX?MOVE_REGION_UP"))

(defun wrx/move-line-up ()
  "asd"
  (interactive)
  (setq chars-over (current-column))
  (transpose-lines 1)
  (forward-line -2)
  (right-char chars-over))


(defun wrx/move-line-or-region-down (beg end)
  "BEG & END correspond point & mark, smaller first
   `use-region-p' explained: 
   http://emacs.stackexchange.com/questions/12334/elisp-for-applying-command-to-only-the-selected-region#answer-12335"
  (interactive "r")
  (if (use-region-p)
      (wrx/move-region-down beg end)
    (wrx/move-line-down)))

(defun wrx/move-region-down (beg end)
  "thang"
  (interactive)
  (print "WRX?MOVE_REGION_DOWN"))

(defun wrx/move-line-down ()
  "Doesn't keep cursor position (often goes to another line)"
  (interactive)
  (setq chars-over (current-column))
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  ;; (save-excursion)
  ;; (next-line)
  (forward-char chars-over))


(global-set-key (kbd "M-N") 'wrx/move-line-or-region-up)
(global-set-key (kbd "M-n") 'wrx/move-line-or-region-down)












;; (defun wrx/duplicate-line-old (arg)
;;   "Duplicate current line, leaving point in lower line.
;;    Implementation: http://stackoverflow.com/questions/88399/how-do-i-duplicate-a-whole-line-in-emacs#answer-998472
;;    Note: Doesn't yank by region, only individual line"
;;   (interactive "*p")
;;   ;; save the point for undo
;;   (setq buffer-undo-list (cons (point) buffer-undo-list))
;;   ;; local variables for start and end of line
;;   (let ((bol (save-excursion (beginning-of-line) (point)))
;;         eol)
;;     (save-excursion
;;       ;; don't use forward-line for this, because you would have
;;       ;; to check whether you are at the end of the buffer
;;       (end-of-line)
;;       (setq eol (point))
;;       ;; store the line and disable the recording of undo information
;;       (let ((line (buffer-substring bol eol))
;;             (buffer-undo-list t)
;;             (count arg))
;;         ;; insert the line arg times
;;         (while (> count 0)
;;           (newline)         ;; because there is no newline in 'line'
;;           (insert line)
;;           (setq count (1- count)))
;;         )
;;       ;; create the undo information
;;       (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list)))
;;     ) ; end-of-let
;;   ;; put the point in the lowest line and return
;;   (next-line arg))
























(defun wrx/move-text-internal (arg)
   (cond
    ((and mark-active transient-mark-mode)
     (if (> (point) (mark))
            (exchange-point-and-mark))
     (let ((column (current-column))
              (text (delete-and-extract-region (point) (mark))))
       (forward-line arg)
       (move-to-column column t)
       (set-mark (point))
       (insert text)
       (exchange-point-and-mark)
       (setq deactivate-mark nil)))
    (t
     (beginning-of-line)
     (when (or (> arg 0) (not (bobp)))
       (forward-line)
       (when (or (< arg 0) (not (eobp)))
            (transpose-lines arg))
       (forward-line -1)))))

(defun wrx/move-text-down (arg)
   "Move region (transient-mark-mode active) or current line
  arg lines down."
   (interactive "*p")
   (move-text-internal arg))

(defun wrx/move-text-up (arg)
   "Move region (transient-mark-mode active) or current line
  arg lines up."
   (interactive "*p")
   (move-text-internal (- arg)))






















;; Rebind goto-line
(global-set-key (kbd "M-L") 'goto-line)

;; EOF


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )







(require 'whitespace)
(setq whitespace-line-column 100) ;; limit line length
(setq whitespace-style '(face lines-tail))

(add-hook 'prog-mode-hook 'whitespace-mode)

;; Only show whitespace in whitelisted major-mode's:
(add-hook 'show-trailing-whitespace 'js2-mode)
(add-hook 'show-trailing-whitespace 'elixir-mode)
(add-hook 'show-trailing-whitespace 'ruby-mode)
(add-hook 'show-trailing-whitespace 'markdown-mode)
(add-hook 'show-trailing-whitespace 'yaml-mode)




(global-visual-line-mode 1) ;; 1 for on, 0 for off.
(global-prettify-symbols-mode +1)




;; https://github.com/myrjola/diminish.el
(require 'diminish)
(diminish 'alchemist-phoenix-mode)
(diminish 'alchemist-mode)
(diminish 'auto-revert-mode)
(diminish 'company-mode)
(diminish 'helm-mode)
(diminish 'indent-guide-mode)
(diminish 'paredit-mode)
(diminish 'projectile-global-mode)
(diminish 'projectile-mode)
(diminish 'whitespace-mode)
(diminish 'which-key-mode)


;; https://www.reddit.com/r/emacs/comments/3wynaj/spacemacs_helmag_is_not_ignoring_files/
(setq helm-ag-use-agignore t)
(setq helm-ag-command-option " -U")

(beacon-mode 1)
(setq beacon-push-mark 35)
(setq beacon-color "#666600")

;; from comments here:
;; http://endlessparentheses.com/leave-the-cursor-at-start-of-match-after-isearch.html
;; https://www.emacswiki.org/emacs/ZapToISearch
(defun isearch-exit-other-end (rbeg rend)
  "Exit isearch, but at the other end of the search string.
  This is useful when followed by an immediate kill."
  (interactive "r")
  (isearch-exit)
  (goto-char isearch-other-end))

(define-key isearch-mode-map [(control return)] 'isearch-exit-other-end)



