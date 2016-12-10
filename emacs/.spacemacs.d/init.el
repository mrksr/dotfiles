(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
     (auto-completion
      :variables
      auto-completion-enable-snippets-in-popup t
      auto-completion-enable-sort-by-usage t
      auto-completion-return-key-behavior 'complete
      auto-completion-tab-key-behavior 'cycle
      auto-completion-enable-help-tooltip t
      :disabled-for org erc
      )
     better-defaults
     bibtex
     (c-c++
      :variables
      c-c++-enable-clang-support t
      c-c++-default-mode-for-headers 'c++-mode
      )
     docker
     emacs-lisp
     (evil-snipe
      :variables
      evil-snipe-enable-alternate-f-and-t-behaviors t
      )
     git
     (latex
      :variables
      latex-enable-auto-fill t
      latex-enable-folding q
      )
     lua
     markdown
     nginx
     org
     (python
      :variables
      python-sort-imports-on-save t
      )
     (ranger
      :variables
      ranger-override-dired t
      )
     semantic
     shell-scripts
     (spell-checking
      :variables
      spell-checking-enable-by-default nil
      )
     (syntax-checking
      :variables
      syntax-checking-enable-by-default nil
      )
     systemd
     (version-control
      :variables
      version-control-global-margin t
      version-control-diff-tool 'diff-hl
      vc-follow-symlinks t
      )
     yaml
     )
   dotspacemacs-additional-packages '(base16-theme)
   dotspacemacs-excluded-packages '()
   dotspacemacs-delete-orphan-packages t))


(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update t
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 0
   dotspacemacs-startup-lists '(projects recents)
   dotspacemacs-startup-recent-list-size 5
   dotspacemacs-themes '(sanityinc-tomorrow-night
                         junio
                         twilight-anti-bright
                         ujelly
                         base16-default-dark
                         zenburn
                         monokai)
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
   dotspacemacs-persistent-server t
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup 'changed
   ))


(defun dotspacemacs/user-init ()
  )


(defun dotspacemacs/user-config ()
  (progn
    ;; Behaviour
    ;; Show line numbers by default
    (global-linum-mode t)
    ;; Wrap at word boundaries
    (global-visual-line-mode t)

    ;; Always substitute globally
    (setq-default evil-ex-substitute-global t)

    ;; Scroll one line at a time (less "jumpy" than defaults)
    (setq mouse-wheel-scroll-amount '(4 ((shift) . 1)))
    (setq mouse-wheel-progressive-speed nil)
    (setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

    ;; Disable smartparens
    (remove-hook 'prog-mode-hook #'smartparens-mode)
    (spacemacs/toggle-smartparens-globally-off)

    ;; Show gitgutter on left hand side
    (setq diff-hl-side 'left)

    ;; Default to Unix encoding
    (setq default-buffer-file-coding-system 'utf-8-unix)
    )

  (progn
    ;; Keybindings
    (define-key evil-normal-state-map (kbd "<escape>") 'evil-search-highlight-persist-remove-all)

    (define-key evil-normal-state-map (kbd "ö") 'helm-mini)
    (define-key evil-normal-state-map (kbd "ä") 'projectile-find-file)

    (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
    (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
    (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
    (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

    (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
    (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

    (define-key evil-insert-state-map (kbd "C-l") 'hippie-expand)

    (define-key evil-normal-state-map (kbd "C-+") 'spacemacs/scale-up-font)
    (define-key evil-normal-state-map (kbd "C--") 'spacemacs/scale-down-font)
    (define-key evil-normal-state-map (kbd "C-0") 'spacemacs/reset-font-size)

    ;; Paste in visual mode does not override default register
    (defun evil-paste-after-from-0 ()
      (interactive)
      (let ((evil-this-register ?0))
        (call-interactively 'evil-paste-after)))
    (define-key evil-visual-state-map "p" 'evil-paste-after-from-0)
    )

  (progn
    ;; Layers
    ;; TeX master file
    (advice-add 'TeX-master-file :before #'TeX-set-master-file)
    (with-eval-after-load 'tex
      (add-to-list 'TeX-view-program-selection '(output-pdf "Zathura"))
      )

    (with-eval-after-load 'company
      (define-key company-active-map (kbd "C-w") 'evil-delete-backward-word)
      )
    (with-eval-after-load 'helm
      (define-key helm-map (kbd "C-w") 'evil-delete-backward-word)
      )
    )

  (progn
    ;; Auto undo
    (setq undo-tree-auto-save-history t
          undo-tree-history-directory-alist
          `(("." . ,(concat spacemacs-cache-directory "undo"))))
    (unless (file-exists-p (concat spacemacs-cache-directory "undo"))
      (make-directory (concat spacemacs-cache-directory "undo")))

    (add-hook 'find-file-hook 'undo-tree-load-history-hook)
    (add-hook 'find-file-hook 'global-undo-tree-mode-check-buffers)
    )
  )


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
