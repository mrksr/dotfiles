
(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
     (auto-completion
      :variables
      auto-completion-enable-snippets-in-popup t
      auto-completion-return-key-behavior nil
      auto-completion-tab-key-behavior 'cycle
      auto-completion-private-snippets-directory "~/.spacemacs.d/snippets/"
      auto-completion-enable-help-tooltip 'manual
      :disabled-for org erc)
     better-defaults
     (c-c++
      :variables
      c-c++-enable-clang-support t
      c-c++-default-mode-for-headers 'c++-mode)
     command-log
     emacs-lisp
     (evil-snipe
      :variables
      evil-snipe-enable-alternate-f-and-t-behaviors t)
     git
     latex
     markdown
     org
     python
     ranger
     shell
     spell-checking
     syntax-checking
     typography
     (version-control
      :variables
      version-control-global-margin t
      version-control-diff-tool 'diff-hl)
     )
   dotspacemacs-additional-packages '(base16-theme)
   dotspacemacs-excluded-packages '()
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update t
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-lists '(recents projects)
   dotspacemacs-startup-recent-list-size 5
   dotspacemacs-themes '(monokai
                         base16-tomorrow-night
                         leuven
                         zenburn)

   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("DeJaVu Sans Mono"
                               :size 15
                               :weight normal
                               :powerline-scale 1.2
                               )
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-command-key ":"
   dotspacemacs-remap-Y-to-y$ nil
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-use-ido nil
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-enable-paste-micro-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-mode-line-unicode-symbols nil
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers t
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup 'changed
   ))

(defun dotspacemacs/user-init ()
  )

(defun dotspacemacs/user-config ()
  (load-theme 'base16-tomorrow-night) ; Switch to proper theme
  (global-linum-mode) ; Show line numbers by default

  (define-key evil-normal-state-map (kbd "<escape>") 'evil-search-highlight-persist-remove-all)

  (define-key evil-normal-state-map (kbd "ö") 'helm-mini)
  (define-key evil-normal-state-map (kbd "ä") 'projectile-find-file)

  (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

  (advice-add 'TeX-master-file :before #'TeX-set-master-file)
  (add-to-list 'TeX-view-program-selection '(output-pdf "Zathura"))

  (setq undo-tree-auto-save-history t
        undo-tree-history-directory-alist
        `(("." . ,(concat spacemacs-cache-directory "undo"))))
  (unless (file-exists-p (concat spacemacs-cache-directory "undo"))
    (make-directory (concat spacemacs-cache-directory "undo")))
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3380a2766cf0590d50d6366c5a91e976bdc3c413df963a0ab9952314b4577299" default)))
 '(evil-want-Y-yank-to-eol nil)
 '(package-selected-packages
   (quote
    (org gitignore-mode magit-popup yapfify uuidgen py-isort org-projectile org-download mwim live-py-mode link-hint github-search flyspell-correct-helm flyspell-correct eyebrowse evil-visual-mark-mode evil-unimpaired evil-ediff eshell-z dumb-jump column-enforce-mode f with-editor undo-tree s py-yapf bracketed-paste iedit smartparens flycheck projectile helm helm-core markdown-mode magit git-commit hydra monokai-theme xterm-color ws-butler window-numbering which-key volatile-highlights vi-tilde-fringe use-package typo toc-org spacemacs-theme spaceline solarized-theme smooth-scrolling smeargle shell-pop restart-emacs ranger rainbow-delimiters quelpa pyvenv pytest pyenv-mode popwin pip-requirements persp-mode pcre2el paradox page-break-lines orgit org-repo-todo org-present org-pomodoro org-plus-contrib org-bullets open-junk-file neotree multi-term move-text mmm-mode markdown-toc magit-gitflow magit-gh-pulls macrostep lorem-ipsum linum-relative leuven-theme info+ indent-guide ido-vertical-mode hy-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation help-fns+ helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-gitignore helm-flyspell helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag google-translate golden-ratio gnuplot github-clone github-browse-file gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gist gh-md flycheck-pos-tip flx-ido fill-column-indicator fasd fancy-battery expand-region exec-path-from-shell evil-visualstar evil-tutor evil-surround evil-snipe evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-jumper evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-args evil-anzu eval-sexp-fu eshell-prompt-extras esh-help elisp-slime-nav disaster diff-hl define-word cython-mode company-statistics company-quickhelp company-c-headers company-auctex company-anaconda command-log-mode cmake-mode clean-aindent-mode clang-format buffer-move base16-theme auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile auctex-latexmk aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((class color) (min-colors 257)) (:foreground "#F8F8F2" :background "#272822")) (((class color) (min-colors 89)) (:foreground "#F5F5F5" :background "#1B1E1C"))))
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))

(defun TeX-find-master-file ()
  "Finds the master file for TeX/LaTeX project by searching for '{file-name}.latexmain' in the good directories"

  (let (foundFiles (currPath (expand-file-name "./")) foundFile)
    (while (and (not foundFiles) (not (equal currPath "/")))
      (setq foundFiles (directory-files currPath t ".*\.latexmain"))
      (setq currPath (expand-file-name (concat currPath "../"))))
    (and
     (setq foundFile (car foundFiles))
     (setq foundFile (file-name-sans-extension foundFile)); removing .latexmain extension
     (file-exists-p foundFile)
     foundFile))
  )

(defun TeX-set-master-file (&optional ignore1 ignore2 ignore3)
  "Finds the master file by means of TeX-find-master-file and sets TeX-master to its value"
  (setq TeX-master (or (TeX-find-master-file) TeX-master))
  )
