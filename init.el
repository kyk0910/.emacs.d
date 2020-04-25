;;; init.el --- My init.el  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Yuya Kudo

;; Author: Yuya Kudo <kyk0910yuya@gmail.com>

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; My init.el.
;;; Code:

;; this enables this running method
;;   emacs -q -l ~/.debug.emacs.d/{{pkg}}/init.el
(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("org"   . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu"   . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)
    :config
    (leaf-keywords-init)))

(leaf leaf
  :config
  (leaf leaf-convert :ensure t)
  (leaf leaf-tree
    :ensure t
    :custom ((imenu-list-size . 30)
             (imenu-list-position . 'left))))

(leaf macrostep
  :ensure t
  :bind (("C-c e" . macrostep-expand)))

(leaf use-package
  :doc "A configuration macro for simplifying your .emacs"
  :req "emacs-24.3" "bind-key-2.4"
  :tag "package" "config" "speed" "startup" "dotemacs" "emacs>=24.3"
  :added "2020-04-20"
  :url "https://github.com/jwiegley/use-package"
  :emacs>= 24.3
  :ensure t)

(leaf cus-edit
  :doc "tools for customizing Emacs and Lisp packages"
  :tag "builtin" "faces" "help"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))

(leaf bind-key
  :doc "A simple way to manage personal keybindings"
  :tag "dotemacs" "config" "keybinding" "keys"
  :added "2020-04-18"
  :url "https://github.com/jwiegley/use-package"
  :ensure t)

(leaf all-the-icons
  :doc "A library for inserting Developer icons"
  :req "emacs-24.3" "memoize-1.0.1"
  :tag "lisp" "convenient" "emacs>=24.3"
  :added "2020-04-18"
  :url "https://github.com/domtronn/all-the-icons.el"
  :emacs>= 24.3
  :ensure t)

(leaf popup
  :doc "Visual Popup User Interface"
  :req "cl-lib-0.5"
  :tag "lisp"
  :added "2020-04-19"
  :ensure t)

(leaf avy
  :doc "Jump to arbitrary positions in visible text and select text quickly."
  :req "emacs-24.1" "cl-lib-0.5"
  :tag "location" "point" "emacs>=24.1"
  :added "2020-04-19"
  :url "https://github.com/abo-abo/avy"
  :emacs>= 24.1
  :ensure t)

(leaf ace-window
  :doc "Quickly switch windows."
  :req "avy-0.5.0"
  :tag "location" "window"
  :added "2020-04-19"
  :url "https://github.com/abo-abo/ace-window"
  :ensure t
  :after avy)

(leaf auto-save-buffers-enhanced
  :doc "Automatically save buffers in a decent way"
  :added "2020-04-18"
  :ensure t
  :disabled t
  :custom
  (auto-save-buffers-enhanced-interval . 1.0)
  :config
  (auto-save-buffers-enhanced t))

(leaf bind-key
  :doc "A simple way to manage personal keybindings"
  :tag "dotemacs" "config" "keybinding" "keys"
  :added "2020-04-19"
  :url "https://github.com/jwiegley/use-package"
  :ensure t)

(leaf exec-path-from-shell
  :doc "Get environment variables such as $PATH from the shell"
  :tag "environment" "unix"
  :added "2020-04-18"
  :url "https://github.com/purcell/exec-path-from-shell"
  :ensure t
  :defun (exec-path-from-shell-initialize)
  :custom
  ((exec-path-from-shell-check-startup-files . nil)
   (exec-path-from-shell-variables .  '("SHELL"
                                        "DEBFULLNAME"
                                        "DEBEMAIL"
                                        "SKKSERVER"
                                        "TEXMFHOME"
                                        "http_proxy"
                                        "GPG_KEY_ID"
                                        "GPG_AGENT_INFO"
                                        "PASSWORD_STORE_DIR"
                                        "PATH")))
  :config
  (exec-path-from-shell-initialize)
  (setq user-full-name    (concat (getenv "DEBFULLNAME"))
        user-mail-address (concat (getenv "DEBEMAIL")))
  (defconst my:d:password-store
    (if (getenv "PASSWORD_STORE_DIR")
        (expand-file-name (concat "Emacs/" (system-name))
                          (getenv "PASSWORD_STORE_DIR")))
    nil))

(leaf expand-region
  :doc "Increase selected region by semantic units."
  :added "2020-04-18"
  :ensure t
  :bind (("C-l" . er/expand-region)
         ("C-M-l" . er/contract-region)))

(leaf popwin
  :doc "Popup Window Manager."
  :tag "convenience"
  :added "2020-04-18"
  :ensure t
  :custom
  (popwin:popup-window-position 'bottom))

(leaf posframe
  :doc "Pop a posframe (just a frame) at point"
  :req "emacs-26"
  :tag "tooltip" "convenience" "emacs>=26"
  :added "2020-04-18"
  :url "https://github.com/tumashu/posframe"
  :emacs>= 26
  :ensure t)

(leaf region-bindings-mode
  :doc "Enable custom bindings when mark is active."
  :tag "convenience"
  :added "2020-04-18"
  :url "https://github.com/fgallina/region-bindings-mode"
  :ensure t
  :config
  (region-bindings-mode t)
  (region-bindings-mode-enable))

(leaf whitespace
  :doc "minor mode to visualize TAB, (HARD) SPACE, NEWLINE"
  :tag "builtin"
  :added "2020-04-18"
  :ensure t
  :custom ((whitespace-style quote
                             (face trailing tabs spaces space-mark tab-mark))
           (whitespace-display-mappings quote
                                        ((space-mark 12288
                                                     [9633])
                                         (tab-mark 9
                                                   [187 9]
                                                   [92 9])))
           (whitespace-space-regexp . "\\(　+\\)")
           (whitespace-action quote
                              (auto-cleanup))
           (whitespace-global-modes quote
                                    (not dired-mode
                                         tar-mode)))
  :require t
  :setq ((my/bg-color . "#050510"))
  :config
  (global-whitespace-mode 1)
  (defun whitespace-disable-auto-clean nil
    (interactive)
    (set
     (make-local-variable 'whitespace-action)
     nil))

  (defun whitespace-enable-auto-clean nil
    (interactive)
    (set
     (make-local-variable 'whitespace-action)
     '(auto-cleanup)))

  (set-face-attribute 'whitespace-trailing nil :background my/bg-color :foreground "DeepPink" :underline t)
  (set-face-attribute 'whitespace-tab nil :background my/bg-color :foreground "LightSkyBlue" :underline nil)
  (set-face-attribute 'whitespace-space nil :background my/bg-color :foreground "GreenYellow" :weight 'bold)
  (set-face-attribute 'whitespace-empty nil :background my/bg-color))

(leaf doom-themes
  :doc "an opinionated pack of modern color-themes"
  :req "emacs-25.1" "cl-lib-0.5"
  :tag "nova" "faces" "icons" "neotree" "theme" "one" "atom" "blue" "light" "dark" "emacs>=25.1"
  :added "2020-04-18"
  :url "https://github.com/hlissner/emacs-doom-theme"
  :emacs>= 25.1
  :ensure t
  :custom ((doom-themes-enable-bold . t)
           (doom-themes-enable-italic . t)
           (doom-themes-treemacs-enable-variable-pitch)
           (doom-themes-treemacs-theme . "doom-colors"))
  :config
  (load-theme 'doom-vibrant t)
  (doom-themes-visual-bell-config)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(leaf doom-modeline
  :doc "A minimal and modern mode-line"
  :req "emacs-25.1" "all-the-icons-2.2.0" "shrink-path-0.2.0" "dash-2.11.0"
  :tag "mode-line" "faces" "emacs>=25.1"
  :added "2020-04-18"
  :url "https://github.com/seagle0128/doom-modeline"
  :emacs>= 25.1
  :ensure t
  :hook (after-init-hook)
  :custom ((doom-modeline-height . 25)
           (doom-modeline-bar-width . 3)
           (doom-modeline-buffer-file-name-style quote truncate-upto-project)
           (doom-modeline-major-mode-icon . t)
           (doom-modeline-major-mode-color-icon . t)
           (doom-modeline-buffer-state-icon . t)
           (doom-modeline-buffer-modification-icon . t)
           (doom-modeline-enable-word-count)
           (doom-modeline-buffer-encoding . t)
           (doom-modeline-indent-info)
           (doom-modeline-checker-simple-format . t)
           (doom-modeline-vcs-max-length . 12)
           (doom-modeline-persp-name . t)
           (doom-modeline-persp-name-icon)
           (doom-modeline-lsp . t)
           (doom-modeline-github . t)
           (doom-modeline-mu4e . t)
           (doom-modeline-irc . t)
           (doom-modeline-irc-stylize quote identity)
           (doom-modeline-env-version . t)
           (doom-modeline-env-enable-python . t)
           (doom-modeline-env-enable-ruby . t)
           (doom-modeline-env-enable-perl . t)
           (doom-modeline-env-enable-go . t)
           (doom-modeline-env-enable-elixir . t)
           (doom-modeline-env-enable-rust . t)
           (doom-modeline-env-python-executable . "python")
           (doom-modeline-env-ruby-executable . "ruby")
           (doom-modeline-env-perl-executable . "perl")
           (doom-modeline-env-go-executable . "go")
           (doom-modeline-env-elixir-executable . "iex")
           (doom-modeline-env-rust-executable . "rustc")
           (doom-modeline-env-load-string . "...")
           (doom-modeline-before-update-env-hook)
           (doom-modeline-after-update-env-hook))
  :config
  (customize-set-variable 'doom-modeline-icon
                          (display-graphic-p)
                          "Customized with use-package doom-modeline")
  (customize-set-variable 'doom-modeline-minor-modes
                          (featurep 'minions)
                          "Customized with use-package doom-modeline")
  (customize-set-variable 'doom-modeline-github-interval
                          (* 30 60)
                          "Customized with use-package doom-modeline"))

(leaf xclip
  :doc "Copy&paste GUI clipboard from text terminal"
  :tag "tools" "convenience"
  :added "2020-04-18"
  :url "http://elpa.gnu.org/packages/xclip.html"
  :ensure t
  :config
  (xclip-mode t))

(leaf disable-mouse
  :doc "Disable mouse commands globally"
  :req "emacs-24.1"
  :tag "mouse" "emacs>=24.1"
  :added "2020-04-18"
  :url "https://github.com/purcell/disable-mouse"
  :emacs>= 24.1
  :ensure t
  :when window-system
  :config
  (global-disable-mouse-mode t))

(leaf minimap
  :doc "Sidebar showing a \"mini-map\" of a buffer"
  :added "2020-04-18"
  :url "http://elpa.gnu.org/packages/minimap.html"
  :ensure t
  :disabled t
  :custom ((minimap-major-modes . '(prog-mode))
           (minimap-window-location . 'right)
           (minimap-update-delay . 0.2)
           (minimap-minimum-width . 15)
           (custom-set-faces . '(minimap-active-region-background
                                 ((((background dark))
                                   (:background "#555555555555"))
                                  (t
                                   (:background "#C847D8FEFFFF")))
                                 :group 'minimap))))

(leaf hlinum
  :doc "Extension for linum.el to highlight current line number"
  :req "cl-lib-0.2"
  :tag "extensions" "convenience"
  :added "2020-04-18"
  :url "https://github.com/tom-tan/hlinum-mode/"
  :ensure t
  :config
  (hlinum-activate)
  (set-face-foreground 'linum-highlight-face "#3FC")
  (set-face-background 'linum-highlight-face "#050510"))

(leaf color
  :doc "Color manipulation library"
  :tag "builtin"
  :added "2020-04-18")

(leaf cl-lib
  :doc "Common Lisp extensions for Emacs"
  :tag "builtin"
  :added "2020-04-18")

(leaf rainbow-delimiters
  :config
  (leaf color :require t)
  (leaf cl-lib :require t)
  (leaf rainbow-delimiters
    :doc "Highlight brackets according to their depth"
    :tag "tools" "lisp" "convenience" "faces"
    :added "2020-04-18"
    :url "https://github.com/Fanael/rainbow-delimiters"
    :ensure t
    :commands rainbow-delimiters-using-stronger-colors
    :hook (prog-mode-hook
           (emacs-startup-hook . rainbow-delimiters-using-stronger-colors))
    :config
    (with-eval-after-load 'rainbow-delimiters
      (defun rainbow-delimiters-using-stronger-colors nil
        (interactive)
        (cl-loop for index from 1 to rainbow-delimiters-max-face-count do
                 (let ((face (intern
                              (format "rainbow-delimiters-depth-%d-face" index))))
                   (cl-callf color-saturate-name (face-foreground face)
                     30)))))))

(leaf volatile-highlights
  :doc "Minor mode for visual feedback on some operations."
  :tag "wp" "convenience" "emulations"
  :added "2020-04-18"
  :url "http://www.emacswiki.org/emacs/download/volatile-highlights.el"
  :ensure t
  :config
  (volatile-highlights-mode t))

(leaf anzu
  :doc "Show number of matches in mode-line while searching"
  :req "emacs-24.3"
  :tag "emacs>=24.3"
  :added "2020-04-18"
  :url "https://github.com/emacsorphanage/anzu"
  :emacs>= 24.3
  :ensure t
  :bind (("M-%" . anzu-query-replace)
         ("M-#" . anzu-query-replace-at-cursor-thing))
  :custom ((anzu-deactivate-region . t)
           (anzu-search-threshold . 100))
  :config
  (with-eval-after-load 'anzu
    (global-anzu-mode 1)))

(leaf smooth-scroll
  :doc "Minor mode for smooth scrolling and in-place scrolling."
  :tag "frames" "emulations" "convenience"
  :added "2020-04-19"
  :url "http://www.emacswiki.org/emacs/download/smooth-scroll.el"
  :ensure t
  :require t
  :custom ((smooth-scroll/vscroll-step-size . 8)
           (smooth-scroll/hscroll-step-size . 8))
  :config
  (smooth-scroll-mode t))

(leaf smooth-scrolling
  :doc "Make emacs scroll smoothly"
  :tag "convenience"
  :added "2020-04-18"
  :url "http://github.com/aspiers/smooth-scrolling/"
  :ensure t
  :disabled t
  :config
  (smooth-scrolling-mode 1))

(leaf smartparens
  :doc "Automatic insertion, wrapping and paredit-like navigation with user defined pairs."
  :req "dash-2.13.0" "cl-lib-0.3"
  :added "2020-04-18"
  :ensure t
  :custom ((sp-escape-qutoes-after-insert))
  :config
  (smartparens-global-mode t))

(leaf undo-tree
  :doc "Treat undo history as a tree"
  :tag "tree" "history" "redo" "undo" "files" "convenience"
  :added "2020-04-18"
  :url "http://www.dr-qubit.org/emacs.php"
  :ensure t
  :bind (("C-/" . undo-tree-undo)
         ("M-/" . undo-tree-redo)
         ("C-x u" . undo-tree-visualize))
  :config
  (with-eval-after-load 'undo-tree
    (global-undo-tree-mode t)))

(leaf yasnippet
  :doc "Yet another snippet extension for Emacs"
  :req "cl-lib-0.5"
  :tag "emulation" "convenience"
  :added "2020-04-18"
  :url "http://github.com/joaotavora/yasnippet"
  :ensure t
  :require t
  :bind ((yas-minor-mode-map
          ("C-x i n" . yas-new-snippet)
          ("C-x i v" . yas-visit-snippet-file)
          ("C-M-i" . yas-insert-snippet))
         (yas-keymap
          ("<tab>")))
  :custom ((yas-snippet-dirs . '("~/.emacs.d/mysnippets")))
  :config
  (yas-global-mode t))

(leaf highlight-indent-guides
  :doc "Minor mode to highlight indentation"
  :req "emacs-24"
  :tag "emacs>=24"
  :added "2020-04-18"
  :url "https://github.com/DarthFennec/highlight-indent-guides"
  :emacs>= 24
  :ensure t
  :hook (yaml-mode-hook)
  :custom ((highlight-indent-guides-auto-enabled quote t)
           (highlight-indent-guides-responsive quote t)
           (highlight-indent-guides-delay quote 0.5)
           (highlight-indent-guides-method quote character)))

(leaf display-line-numbers
  :doc "interface for display-line-numbers"
  :tag "builtin"
  :added "2020-04-19"
  :bind ("M-'" . display-line-numbers-mode)
  :hook  (prog-mode-hook . display-line-numbers-mode))

(leaf neotree
  :doc "A tree plugin like NerdTree for Vim"
  :req "cl-lib-0.5"
  :added "2020-04-18"
  :url "https://github.com/jaypei/emacs-neotree"
  :ensure t
  :bind (("\C-q" . neotree-toggle)
         (neotree-mode-map
          ("f" . neotree-change-root)
          ("+" . neotree-create-node)
          ("c" . neotree-copy-node)
          ("r" . neotree-rename-node)
          ("d" . neotree-delete-node)
          ("b" . neotree-select-up-node)))
  :custom ((neo-autorefresh)
           (neo-show-hidden-files . t)
           (neo-create-file-auto-open)
           (neo-keymap-style quote concise)
           (neo-smart-open . t)
           (neo-window-width . 50))
  :config
  (customize-set-variable 'neo-theme
                          (if (display-graphic-p)
                              'icons 'arrow)
                          "Customized with use-package neotree")
  (with-eval-after-load 'neotree
    (prefer-coding-system 'utf-8)))

(leaf treemacs
  :config
  (leaf treemacs-projectile
    :ensure t
    :after projectile treemacs)

  (leaf treemacs-icons-dired
    :ensure t
    :after dired treemacs
    :config
    (treemacs-icons-dired-mode))

  (leaf treemacs-magit
    :ensure t
    :after magit
    :commands treemacs-magit--schedule-update
    :hook ((magit-post-commit-hook . treemacs-magit--schedule-update)
           (git-commit-post-finish-hook . treemacs-magit--schedule-update)
           (magit-post-stage-hook . treemacs-magit--schedule-update)
           (magit-post-unstage-hook . treemacs-magit--schedule-update)))

  (leaf treemacs
    :ensure t
    :require t
    :bind (("M-0" . treemacs-select-window)
           ("C-x t B" . treemacs-bookmark)
           ("C-x t C-t" . treemacs-find-file)
           ("C-x t M-t" . treemacs-find-tag))
    :config
    (with-eval-after-load 'treemacs
      (progn
        (setq treemacs-collapse-dirs (if treemacs-python-executable 3 0)
              treemacs-deferred-git-apply-delay 0.5
              treemacs-display-in-side-window t
              treemacs-eldoc-display t
              treemacs-file-event-delay 5000
              treemacs-file-follow-delay 0.2
              treemacs-follow-after-init t
              treemacs-git-command-pipe ""
              treemacs-goto-tag-strategy 'refetch-index
              treemacs-indentation 2
              treemacs-indentation-string " "
              treemacs-is-never-other-window nil
              treemacs-max-git-entries 5000
              treemacs-missing-project-action 'ask
              treemacs-no-png-images nil
              treemacs-no-delete-other-windows t
              treemacs-project-follow-cleanup nil
              treemacs-persist-file (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
              treemacs-position 'left
              treemacs-recenter-distance 0.1
              treemacs-recenter-after-file-follow nil
              treemacs-recenter-after-tag-follow nil
              treemacs-recenter-after-project-jump 'always
              treemacs-recenter-after-project-expand 'on-distance
              treemacs-show-cursor t
              treemacs-show-hidden-files t
              treemacs-silent-filewatch nil
              treemacs-silent-refresh nil
              treemacs-sorting 'alphabetic-desc
              treemacs-tag-follow-cleanup t
              treemacs-tag-follow-delay 0.5
              treemacs-width 50
              treemacs-follow-mode t
              treemacs-filewatch-mode t
              treemacs-fringe-indicator-mode t)
        (pcase (cons
                (not (null (executable-find "git")))
                (not (null treemacs-python-executable)))
          (`(t . t)
           (setq treemacs-git-mode 'deferred))
          (`(t . _)
           (setq treemacs-git-mode 'simple))))
      (with-no-warnings
        (when window-system
          (when (require 'all-the-icons nil t)
            (treemacs-create-theme "centaur-colors"
              :extends "doom-colors"
              :config
              (progn
                (treemacs-create-icon
                 :icon (format " %s\t" (all-the-icons-octicon "repo" :height 1.1 :v-adjust -0.1 :face 'all-the-icons-blue))
                 :extensions (root))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-octicon "tag" :height 0.9 :v-adjust 0 :face 'all-the-icons-lblue))
                 :extensions (boolean-data))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-material "settings_input_component" :face 'all-the-icons-orange))
                 :extensions (class))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-material "palette"))
                 :extensions (color-palette))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-faicon "square-o"))
                 :extensions (constant))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-faicon "file-text-o"))
                 :extensions (document))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-material "storage" :face 'all-the-icons-orange))
                 :extensions (enumerator))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-material "format_align_right" :face 'all-the-icons-lblue))
                 :extensions (enumitem))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-faicon "bolt" :face 'all-the-icons-orange))
                 :extensions (event))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-octicon "tag" :height 0.9 :v-adjust 0 :face 'all-the-icons-lblue))
                 :extensions (field))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-faicon "search"))
                 :extensions (indexer))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-material "filter_center_focus"))
                 :extensions (intellisense-keyword))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-material "share" :face 'all-the-icons-lblue))
                 :extensions (interface))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-octicon "tag" :height 1.0 :v-adjust 0 :face 'all-the-icons-blue))
                 :extensions (localvariable))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-faicon "cube" :face 'all-the-icons-purple))
                 :extensions (method))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-material "view_module" :face 'all-the-icons-lblue))
                 :extensions (namespace))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-material "format_list_numbered"))
                 :extensions (numeric))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-material "control_point" :height 1.0 :v-adjust -0.2))
                 :extensions (operator))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-faicon "wrench"))
                 :extensions (property))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-material "format_align_center"))
                 :extensions (snippet))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-faicon "text-width"))
                 :extensions (string))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-material "settings_input_component" :face 'all-the-icons-orange))
                 :extensions (structure))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-material "format_align_center"))
                 :extensions (template))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-octicon "chevron-right" :height 0.75 :v-adjust 0.1 :face 'font-lock-doc-face))
                 :extensions (collapsed)
                 :fallback "+")
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-octicon "chevron-down" :height 0.75 :v-adjust 0.1 :face 'font-lock-doc-face))
                 :extensions (expanded)
                 :fallback "-")
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-octicon "file-binary" :v-adjust 0 :face 'font-lock-doc-face))
                 :extensions (classfile))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-faicon "folder-open" :face 'all-the-icons-blue))
                 :extensions (default-folder-opened))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-octicon "file-directory" :v-adjust 0 :face 'all-the-icons-blue))
                 :extensions (default-folder))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-faicon "folder-open" :face 'all-the-icons-green))
                 :extensions (default-root-folder-opened))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-octicon "file-directory" :v-adjust 0 :face 'all-the-icons-green))
                 :extensions (default-root-folder))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-octicon "file-binary" :v-adjust 0 :face 'font-lock-doc-face))
                 :extensions ("class"))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-octicon "file-zip" :face 'font-lock-doc-face))
                 :extensions (file-type-jar))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-faicon "folder-open" :face 'font-lock-doc-face))
                 :extensions (folder-open))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-octicon "file-directory" :v-adjust 0 :face 'font-lock-doc-face))
                 :extensions (folder))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-faicon "folder-open" :face 'all-the-icons-orange))
                 :extensions (folder-type-component-opened))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-octicon "file-directory" :v-adjust 0 :face 'all-the-icons-orange))
                 :extensions (folder-type-component))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-faicon "folder-open" :face 'all-the-icons-green))
                 :extensions (folder-type-library-opened))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-octicon "file-directory" :v-adjust 0 :face 'all-the-icons-green))
                 :extensions (folder-type-library))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-faicon "folder-open" :face 'all-the-icons-pink))
                 :extensions (folder-type-maven-opened))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-octicon "file-directory" :v-adjust 0 :face 'all-the-icons-pink))
                 :extensions (folder-type-maven))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-faicon "folder-open" :face 'font-lock-type-face))
                 :extensions (folder-type-package-opened))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-octicon "file-directory" :v-adjust 0 :face 'font-lock-type-face))
                 :extensions (folder-type-package))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-faicon "plus" :face 'font-lock-doc-face))
                 :extensions (icon-create))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-faicon "list" :face 'font-lock-doc-face))
                 :extensions (icon-flat))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-material "share" :face 'all-the-icons-lblue))
                 :extensions (icon-hierarchical))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-faicon "link" :face 'font-lock-doc-face))
                 :extensions (icon-link))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-faicon "refresh" :face 'font-lock-doc-face))
                 :extensions (icon-refresh))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-faicon "chain-broken" :face 'font-lock-doc-face))
                 :extensions (icon-unlink))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-alltheicon "java" :face 'all-the-icons-orange))
                 :extensions (jar))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-faicon "book" :v-adjust 0 :face 'all-the-icons-green))
                 :extensions (library))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-faicon "folder-open" :face 'all-the-icons-lblue))
                 :extensions (packagefolder-open))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-octicon "file-directory" :v-adjust 0 :face 'all-the-icons-lblue))
                 :extensions (packagefolder))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-octicon "package" :v-adjust 0 :face 'font-lock-doc-face))
                 :extensions (package))
                (treemacs-create-icon
                 :icon (format "%s\t" (all-the-icons-octicon "repo" :height 1.1 :v-adjust -0.1 :face 'all-the-icons-blue))
                 :extensions (java-project))))))))))

(leaf flycheck
  :doc "On-the-fly syntax checking"
  :req "dash-2.12.1" "pkg-info-0.4" "let-alist-1.0.4" "seq-1.11" "emacs-24.3"
  :tag "tools" "languages" "convenience" "emacs>=24.3"
  :added "2020-04-18"
  :url "http://www.flycheck.org"
  :emacs>= 24.3
  :ensure t
  :commands global-flycheck-mode
  :bind (("M-g M-p" . flycheck-previous-error)
         ("M-g M-n" . flycheck-next-error))
  :hook ((after-init-hook . global-flycheck-mode))
  :custom ((flycheck-find-checker-executable quote verilog-verilator))
  :config
  (add-to-list 'display-buffer-alist
               `(,(rx bos "*Flycheck errors*" eos)
                 (display-buffer-reuse-window display-buffer-in-side-window)
                 (side . bottom)
                 (reusable-frames . visible)
                 (window-height . 0.125))))

(leaf elscreen
  :doc "Emacs window session manager"
  :req "emacs-24"
  :tag "convenience" "window" "emacs>=24"
  :added "2020-04-18"
  :url "https://github.com/knu/elscreen"
  :emacs>= 24
  :ensure t
  :custom ((elscreen-tab-display-kill-screen . nil)
           (elscreen-tab-display-control . nil))
  :config
  (elscreen-start))


(leaf color-identifiers-mode
  :doc "Color identifiers based on their names"
  :req "dash-2.5.0" "emacs-24"
  :tag "languages" "faces" "emacs>=24"
  :added "2020-04-18"
  :url "https://github.com/ankurdave/color-identifiers-mode"
  :emacs>= 24
  :ensure t
  :commands global-color-identifiers-mode
  :hook ((after-init-hook . global-color-identifiers-mode)))


(leaf multiple-cursors
  :doc "Multiple cursors for Emacs."
  :req "cl-lib-0.5"
  :added "2020-04-18"
  :ensure t
  :after region-bindings-mode
  ;; 何故か動作しない(bindの評価タイミングの問題？)
  ;; :bind ((region-bindings-mode-map
  ;;         ("e" . mc/edit-lines)
  ;;         ("n" . mc/mark-next-like-this)
  ;;         ("p" . mc/mark-previous-like-this)
  ;;         ("a" . mc/mark-all-like-this)
  ;;         ("m" . mc/mark-more-like-this-extended)))
  :config
  (define-key region-bindings-mode-map "e" 'mc/edit-lines)
  (define-key region-bindings-mode-map "n" 'mc/mark-next-like-this)
  (define-key region-bindings-mode-map "p" 'mc/mark-previous-like-this)
  (define-key region-bindings-mode-map "a" 'mc/mark-all-like-this)
  (define-key region-bindings-mode-map "m" 'mc/mark-more-like-this-extended))

(leaf move-text
  :doc "Move current line or region with M-up or M-down."
  :tag "edit"
  :added "2020-04-18"
  :url "https://github.com/emacsfodder/move-text"
  :ensure t
  :bind (("M-<up>"   . move-text-up)
         ("M-<down>" . move-text-down)))

(leaf dashboard
  :doc "A startup screen extracted from Spacemacs"
  :req "emacs-25.3" "page-break-lines-0.11"
  :tag "dashboard" "tools" "screen" "startup" "emacs>=25.3"
  :added "2020-04-18"
  :url "https://github.com/emacs-dashboard/emacs-dashboard"
  :emacs>= 25.3
  :ensure t
  :custom ((dashboard-page-separator quote "\n\f\f\n")
           (dashboard-items quote
                            ((recents . 20)
                             (agenda . 10)
                             (bookmarks . 10))))
  :config
  (when (eq system-type 'gnu/linux)
    (setq dashboard-banner-logo-title (concat "GNU Emacs " emacs-version " kernel "
                                              (car (split-string
                                                    (shell-command-to-string "uname -r")))
                                              " x86_64 Debian GNU/Linux "
                                              (car (split-string
                                                    (shell-command-to-string "cat /etc/debian_version")
                                                    "_")))))
  (dashboard-setup-startup-hook))

(leaf open-junk-file
  :doc "Open a junk (memo) file to try-and-error"
  :tag "tools" "convenience"
  :added "2020-04-18"
  :url "http://www.emacswiki.org/cgi-bin/wiki/download/open-junk-file.el"
  :ensure t
  :custom ((open-junk-file-format quote "~/Dropbox/org/diary/%Y/%m/%Y-%m-%d.org")
           (open-junk-file-find-file-function quote find-file)))

(leaf cmake-mode
  :doc "major-mode for editing CMake sources"
  :req "emacs-24.1"
  :tag "emacs>=24.1"
  :added "2020-04-18"
  :emacs>= 24.1
  :ensure t
  :mode ("/CMakeLists.txt/"))

(leaf which-key
  :doc "Display available keybindings in popup"
  :req "emacs-24.4"
  :tag "emacs>=24.4"
  :added "2020-04-18"
  :url "https://github.com/justbur/emacs-which-key"
  :emacs>= 24.4
  :ensure t
  :custom ((which-key-idle-delay . '0.2))
  :hook (after-init-hook))

(leaf beacon
  :doc "Highlight the cursor whenever the window scrolls"
  :req "seq-2.14"
  :tag "convenience"
  :added "2020-04-18"
  :url "https://github.com/Malabarba/beacon"
  :ensure t
  :custom ((beacon-color . '"#553"))
  :config
  (beacon-mode 1))

(leaf symbol-overlay
  :doc "Highlight symbols with keymap-enabled overlays"
  :req "emacs-24.3" "seq-2.2"
  :tag "matching" "faces" "emacs>=24.3"
  :added "2020-04-18"
  :url "https://github.com/wolray/symbol-overlay/"
  :emacs>= 24.3
  :ensure t
  :bind (("M-r" . symbol-overlay-remove-all)
         ("M-i" . symbol-overlay-put)
         ("M-o" . symbol-overlay-mode)))

(leaf smart-hungry-delete
  :doc "smart hungry deletion of whitespace"
  :req "emacs-24.3"
  :tag "convenience" "emacs>=24.3"
  :added "2020-04-18"
  :url "https://github.com/hrehfeld/emacs-smart-hungry-delete"
  :emacs>= 24.3
  :ensure t
  :bind (("M-h" . smart-hungry-delete-backward-char))
  :config
  (smart-hungry-delete-add-default-hooks))

(leaf google-translate
  :custom ((google-translate-english-chars . "[:ascii:]’“”–"))
  :config
  (defun google-translate-enja-or-jaen (&optional string)
    (interactive)
    (setq string (cond
                  ((stringp string)
                   string)
                  (current-prefix-arg
                   (read-string "Google Translate: "))
                  ((use-region-p)
                   (buffer-substring
                    (region-beginning)
                    (region-end)))
                  (t
                   (save-excursion
                     (let (s)
                       (forward-char 1)
                       (backward-sentence)
                       (setq s (point))
                       (forward-sentence)
                       (buffer-substring s
                                         (point)))))))
    (let* ((asciip (string-match
                    (format "\\`[%s]+\\'" google-translate-english-chars)
                    string)))
      (run-at-time 0.1 nil 'deactivate-mark)
      (google-translate-translate
       (if asciip
           "en" "ja")
       (if asciip
           "ja" "en")
       string)))

  (defun chromium-translate nil
    "Open google translate with chromium."
    (interactive)
    (if (use-region-p)
        (let ((string (buffer-substring-no-properties
                       (region-beginning)
                       (region-end))))
          (deactivate-mark)
          (if (string-match
               (format "\\`[%s]+\\'" "[:ascii:]")
               string)
              (browse-url
               (concat "https://translate.google.com/?source=gtx#en/ja/"
                       (url-hexify-string string)))
            (browse-url
             (concat "https://translate.google.com/?source=gtx#ja/en/"
                     (url-hexify-string string)))))
      (let ((string (read-string "Google Translate: ")))
        (if (string-match
             (format "\\`[%s]+\\'" "[:ascii:]")
             string)
            (browse-url
             (concat "https://translate.google.com/?source=gtx#en/ja/"
                     (url-hexify-string string)))
          (browse-url
           (concat "https://translate.google.com/?source=gtx#ja/en/"
                   (url-hexify-string string)))))))

  (leaf google-translate
    :doc "Emacs interface to Google Translate."
    :added "2020-04-18"
    :ensure t
    :after region-bindings-mode
    :custom ((google-translate-output-destination . 'popup))
    ;; :bind ((region-bindings-mode-map
    ;;         ("t" . chromium-translate)
    ;;         ("T" . google-translate-enja-or-jaen))))
    :config
    (define-key region-bindings-mode-map "t" 'chromium-translate)
    (define-key region-bindings-mode-map "T" 'google-translate-enja-or-jaen)))

(leaf imenu-list
  :doc "Show imenu entries in a separate buffer"
  :req "cl-lib-0.5"
  :added "2020-04-18"
  :url "https://github.com/bmag/imenu-list"
  :ensure t
  :bind (("C-c i" . imenu-list-smart-toggle))
  :custom ((imenu-list-focus-after-activation . t)
           (imenu-list-auto-resize . t)))

(leaf mwim
  :doc "Switch between the beginning/end of line or code"
  :tag "convenience"
  :added "2020-04-18"
  :url "https://github.com/alezost/mwim.el"
  :ensure t
  :bind (("C-a" . mwim-beginning-of-code-or-line)
         ("C-e" . mwim-end-of-code-or-line)))

(leaf smerge-mode
  :doc "Minor mode to resolve diff3 conflicts"
  :tag "builtin"
  :added "2020-04-18"
  :init
  (eval-and-compile
    (with-eval-after-load 'hydra
      (defhydra smerge-hydra
        (:color pink :hint nil :post
                (smerge-auto-leave))
        "
^Move^       ^Keep^               ^Diff^                 ^Other^
^^-----------^^-------------------^^---------------------^^-------
_n_ext       _b_ase               _<_: upper/base        _C_ombine
_p_rev       _u_pper              _=_: upper/lower       _r_esolve
^^           _l_ower              _>_: base/lower        _k_ill current
^^           _a_ll                _R_efine
^^           _RET_: current       _E_diff
"
        ("n" smerge-next)
        ("p" smerge-prev)
        ("b" smerge-keep-base)
        ("u" smerge-keep-upper)
        ("l" smerge-keep-lower)
        ("a" smerge-keep-all)
        ("RET" smerge-keep-current)
        ("\C-m" smerge-keep-current)
        ("<" smerge-diff-base-upper)
        ("=" smerge-diff-upper-lower)
        (">" smerge-diff-base-lower)
        ("R" smerge-refine)
        ("E" smerge-ediff)
        ("C" smerge-combine-with-next)
        ("r" smerge-resolve)
        ("k" smerge-kill-current)
        ("ZZ"
         (lambda nil
           (interactive)
           (save-buffer)
           (bury-buffer))
         "Save and bury buffer" :color blue)
        ("q" nil "cancel" :color blue))))
  :config
  (add-hook 'find-file-hook
            #'(lambda nil
                (save-excursion
                  (goto-char (point-min))
                  (when (re-search-forward "^<<<<<<< " nil t)
                    (smerge-mode 1)))))
  (add-hook 'magit-diff-visit-file-hook
            #'(lambda nil
                (when smerge-mode
                  (smerge-hydra/body)))))

(leaf google-this
  :doc "A set of functions and bindings to google under point."
  :req "emacs-24.1"
  :tag "hypermedia" "convenience" "emacs>=24.1"
  :added "2020-04-18"
  :url "http://github.com/Malabarba/emacs-google-this"
  :emacs>= 24.1
  :ensure t
  :after region-bindings-mode
  ;; :bind ((region-bindings-mode-map
  ;;         ("g" . google-this)))
  :config
  (define-key region-bindings-mode-map "g" 'google-this))

(leaf presentation
  :doc "Display large character for presentation"
  :req "emacs-24.4" "cl-lib-0.5"
  :tag "frames" "faces" "environment" "emacs>=24.4"
  :added "2020-04-18"
  :url "https://github.com/zonuexe/emacs-presentation-mode"
  :emacs>= 24.4
  :ensure t)

(leaf eshell
  :doc "the Emacs command shell"
  :tag "builtin"
  :added "2020-04-18"
  :after company
  :custom ((eshell-hist-ignoredups . t)
           (eshell-cmpl-cycle-completions)
           (eshell-cmpl-ignore-case . t)
           (eshell-ask-to-save-history . 'always)
           (eshell-prompt-regexp . "$ "))
  :init
  (customize-set-variable 'eshell-prompt-function
                          (lambda nil
                            (format "%s %s\n%s "
                                    (all-the-icons-octicon "repo")
                                    (propertize
                                     (cdr (shrink-path-prompt default-directory))
                                     'face
                                     `(:foreground "white"))
                                    (propertize "$" 'face
                                                `(:foreground "#DAAADA"))))
                          "Customized with use-package eshell")
  :hook
  (eshell-mode . (lambda () (progn (define-key eshell-mode-map "\C-a" 'eshell-bol)))))

(leaf easy-kill
  :doc "kill & mark things easily"
  :req "emacs-24" "cl-lib-0.5"
  :tag "convenience" "killing" "emacs>=24"
  :added "2020-04-18"
  :url "https://github.com/leoliu/easy-kill"
  :emacs>= 24
  :ensure t
  :bind (([remap kill-ring-save]. easy-kill)
         ([remap mark-sexp] . easy-mark)))

(leaf mozc
  :config
  (defun mozc-mark-escape nil
    "Temporarily disable mozc-mode because of region-bindings-mode."
    (deactivate-input-method)
    (add-hook 'deactivate-mark-hook 'toggle-input-method)
    (add-hook 'input-method-activate-hook
              (lambda nil
                (remove-hook 'deactivate-mark-hook 'toggle-input-method))))
  (leaf mozc-popup
    :doc "Mozc with popup"
    :req "popup-0.5.2" "mozc-0"
    :tag "extentions" "i18n"
    :added "2020-04-18"
    :ensure t
    :require t)
  (leaf mozc
    :doc "minor mode to input Japanese with Mozc"
    :tag "input method" "multilingual" "mule"
    :added "2020-04-18"
    :ensure t
    :custom ((mozc-candidate-style . 'popup))
    :bind (("C-0" . toggle-input-method))
    :config
    (with-eval-after-load 'mozc
      (add-hook 'input-method-activate-hook
                (lambda nil
                  (add-hook 'activate-mark-hook 'mozc-mark-escape)))
      (add-hook 'input-method-inactivate-hook
                (lambda nil
                  (remove-hook 'activate-mark-hook 'mozc-mark-escape))))))

(leaf company
  :config
  (leaf company
    :doc "Modular text completion framework"
    :req "emacs-24.3"
    :tag "matching" "convenience" "abbrev" "emacs>=24.3"
    :added "2020-04-18"
    :url "http://company-mode.github.io/"
    :emacs>= 24.3
    :ensure t
    :require t
    :bind (("C-M-c" . company-complete)
           (company-active-map
            ("C-n" . company-select-next)
            ("C-p" . company-select-previous)
            ("C-s" . company-filter-candidates)
            ("C-i" . company-complete-selection)
            ([tab] . company-complete-selection))
           (company-search-map
            ("C-n" . company-select-next)
            ("C-p" . company-select-previous)))
    :custom ((company-transformers . '(company-sort-by-backend-importance))
             (company-global-modes . '(not eshell-mode))
             (company-idle-delay . 0)
             (company-echo-delay . 0)
             (company-minimum-prefix-length . 2)
             (company-selection-wrap-around . t)
             (completion-ignore-case . t)
             (company-auto-expand . t))
    :config
    (global-company-mode t)
    (with-eval-after-load 'company
      (defun my-sort-uppercase (candidates)
        (let (case-fold-search
              (re "\\`[[:upper:]]*\\'"))
          (sort candidates
                (lambda (s1 s2)
                  (and
                   (string-match-p re s2)
                   (not (string-match-p re s1)))))))

      (push 'my-sort-uppercase company-transformers)
      (defvar company-mode/enable-yas t)
      (defun company-mode/backend-with-yas (backend)
        (if (or
             (not company-mode/enable-yas)
             (and
              (listp backend)
              (member 'company-yasnippet backend)))
            backend
          (append
           (if (consp backend)
               backend
             (list backend))
           '(:with company-yasnippet))))
      (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))))

  (leaf company-quickhelp
    :doc "Popup documentation for completion candidates"
    :req "emacs-24.3" "company-0.8.9" "pos-tip-0.4.6"
    :tag "quickhelp" "documentation" "popup" "company" "emacs>=24.3"
    :added "2020-04-18"
    :url "https://www.github.com/expez/company-quickhelp"
    :emacs>= 24.3
    :ensure t
    :after company
    :config
    (company-quickhelp-mode 1))

  (leaf company-tabnine
    :doc "A company-mode backend for TabNine"
    :req "emacs-25" "company-0.9.3" "cl-lib-0.5" "dash-2.16.0" "s-1.12.0" "unicode-escape-1.1"
    :tag "convenience" "emacs>=25"
    :added "2020-04-18"
    :url "https://github.com/TommyX12/company-tabnine/"
    :emacs>= 25
    :ensure t
    :after company
    :config
    (add-to-list 'company-backends #'company-tabnine))

  (leaf company-posframe
    :doc "Use a posframe as company candidate menu"
    :req "emacs-26.0" "company-0.9.0" "posframe-0.1.0"
    :tag "matching" "convenience" "abbrev" "emacs>=26.0"
    :added "2020-04-18"
    :url "https://github.com/tumashu/company-posframe"
    :emacs>= 26.0
    :ensure t
    :after company posframe
    :when window-system
    :hook (company-mode-hook))

  (leaf company-box
    :doc "Company front-end with icons"
    :req "emacs-26.0.91" "dash-2.13" "dash-functional-1.2.0" "company-0.9.6"
    :tag "convenience" "front-end" "completion" "company" "emacs>=26.0.91"
    :added "2020-04-18"
    :url "https://github.com/sebastiencs/company-box"
    :emacs>= 26.0
    :ensure t
    :after company all-the-icons
    :when window-system
    :hook (company-mode-hook)
    :custom ((company-box-backends-colors)
             (company-box-show-single-candidate . t)
             (company-box-max-candidates . 50)
             (company-box-icons-alist quote company-box-icons-all-the-icons))
    :config
    (with-eval-after-load 'company-box
      (declare-function all-the-icons-faicon 'all-the-icons)
      (declare-function all-the-icons-fileicon 'all-the-icons)
      (declare-function all-the-icons-material 'all-the-icons)
      (declare-function all-the-icons-octicon 'all-the-icons)
      (setq company-box-icons-all-the-icons
            `((Unknown       . ,(all-the-icons-material "find_in_page" :height 0.7 :v-adjust -0.15))
              (Text          . ,(all-the-icons-faicon   "book" :height 0.68 :v-adjust -0.15))
              (Method        . ,(all-the-icons-faicon   "cube" :height 0.7 :v-adjust -0.05 :face 'font-lock-constant-face))
              (Function      . ,(all-the-icons-faicon   "cube" :height 0.7 :v-adjust -0.05 :face 'font-lock-constant-face))
              (Constructor   . ,(all-the-icons-faicon   "cube" :height 0.7 :v-adjust -0.05 :face 'font-lock-constant-face))
              (Field         . ,(all-the-icons-faicon   "tags" :height 0.65 :v-adjust -0.15 :face 'font-lock-warning-face))
              (Variable      . ,(all-the-icons-faicon   "tag" :height 0.7 :v-adjust -0.05 :face 'font-lock-warning-face))
              (Class         . ,(all-the-icons-faicon   "clone" :height 0.65 :v-adjust 0.01 :face 'font-lock-constant-face))
              (Interface     . ,(all-the-icons-faicon   "clone" :height 0.65 :v-adjust 0.01))
              (Module        . ,(all-the-icons-octicon  "package" :height 0.7 :v-adjust -0.15))
              (Property      . ,(all-the-icons-octicon  "package" :height 0.7 :v-adjust -0.05 :face 'font-lock-warning-face))
              (Unit          . ,(all-the-icons-material "settings_system_daydream" :height 0.7 :v-adjust -0.15))
              (Value         . ,(all-the-icons-material "format_align_right" :height 0.7 :v-adjust -0.15 :face 'font-lock-constant-face))
              (Enum          . ,(all-the-icons-material "storage" :height 0.7 :v-adjust -0.15 :face 'all-the-icons-orange))
              (Keyword       . ,(all-the-icons-material "filter_center_focus" :height 0.7 :v-adjust -0.15))
              (Snippet       . ,(all-the-icons-faicon   "code" :height 0.7 :v-adjust 0.02 :face 'font-lock-variable-name-face))
              (Color         . ,(all-the-icons-material "palette" :height 0.7 :v-adjust -0.15))
              (File          . ,(all-the-icons-faicon   "file-o" :height 0.7 :v-adjust -0.05))
              (Reference     . ,(all-the-icons-material "collections_bookmark" :height 0.7 :v-adjust -0.15))
              (Folder        . ,(all-the-icons-octicon  "file-directory" :height 0.7 :v-adjust -0.05))
              (EnumMember    . ,(all-the-icons-material "format_align_right" :height 0.7 :v-adjust -0.15 :face 'all-the-icons-blueb))
              (Constant      . ,(all-the-icons-faicon   "tag" :height 0.7 :v-adjust -0.05))
              (Struct        . ,(all-the-icons-faicon   "clone" :height 0.65 :v-adjust 0.01 :face 'font-lock-constant-face))
              (Event         . ,(all-the-icons-faicon   "bolt" :height 0.7 :v-adjust -0.05 :face 'all-the-icons-orange))
              (Operator      . ,(all-the-icons-fileicon "typedoc" :height 0.65 :v-adjust 0.05))
              (TypeParameter . ,(all-the-icons-faicon   "hashtag" :height 0.65 :v-adjust 0.07 :face 'font-lock-const-face))
              (Template      . ,(all-the-icons-faicon   "code" :height 0.7 :v-adjust 0.02 :face 'font-lock-variable-name-face)))))))

(leaf helm
  :config
  (leaf helm
    :doc "Helm is an Emacs incremental and narrowing framework"
    :req "emacs-24.4" "async-1.9.4" "popup-0.5.3" "helm-core-3.6.0"
    :tag "emacs>=24.4"
    :added "2020-04-18"
    :url "https://emacs-helm.github.io/helm/"
    :emacs>= 24.4
    :ensure t
    :require t
    :bind (("M-x" . helm-M-x)
           ("M-y" . helm-show-kill-ring)
           ("C-x C-f" . helm-find-files)
           ("C-x C-l" . helm-locate)
           ("C-x C-o" . helm-occur)
           ("C-x C-b" . helm-mini)
           (helm-map
            ("C-h" . delete-backward-char)
            ("<tab>" . helm-execute-persistent-action)))
    :config
    (helm-mode t))

  (leaf helm-xref
    :doc "Helm interface for xref results"
    :req "emacs-25.1" "helm-1.9.4"
    :tag "emacs>=25.1"
    :added "2020-04-18"
    :url "https://github.com/brotzeit/helm-xref"
    :emacs>= 25.1
    :ensure t
    :after helm
    :require t
    :config
    (leaf xref
      :doc "Cross-referencing commands"
      :tag "builtin"
      :added "2020-04-18"
      :after helm-xref
      :custom ((xref-show-xrefs-function quote helm-xref-show-xrefs))
      :require t))

  (leaf helm-git-grep
    :doc "helm for git grep, an incremental git-grep(1)"
    :req "helm-core-2.2.0"
    :added "2020-04-18"
    :url "https://github.com/yasuyk/helm-git-grep"
    :ensure t
    :require t))

(leaf git
  :config
  (leaf git-gutter
    :doc "Port of Sublime Text plugin GitGutter"
    :req "emacs-24.3"
    :tag "emacs>=24.3"
    :added "2020-04-21"
    :url "https://github.com/emacsorphanage/git-gutter"
    :emacs>= 24.3
    :ensure t
    :bind (("M-n" . git-gutter:next-hunk)
           ("M-p" . git-gutter:previous-hunk))
    :hook (after-init-hook . global-git-gutter-mode))

  (leaf fringe-helper
    :doc "helper functions for fringe bitmaps"
    :tag "lisp"
    :added "2020-04-21"
    :url "http://nschum.de/src/emacs/fringe-helper/"
    :ensure t)

  (leaf git-gutter-fringe
    :doc "Fringe version of git-gutter.el"
    :req "git-gutter-0.88" "fringe-helper-0.1.1" "cl-lib-0.5" "emacs-24"
    :tag "emacs>=24"
    :added "2020-04-21"
    :url "https://github.com/emacsorphanage/git-gutter-fringe"
    :emacs>= 24
    :ensure t
    :after git-gutter fringe-helper)

  ;; NOTE: git-gutter+, git-gutter-fringe+
  ;; tramp時にbufferが開かないバグがあるためdisabled
  (leaf git-gutter+
    :doc "Manage Git hunks straight from the buffer"
    :req "git-commit-0" "dash-0"
    :tag "vc" "git"
    :added "2020-04-18"
    :url "https://github.com/nonsequitur/git-gutter-plus"
    :ensure t
    :require t
    :disabled t
    :unless window-system
    :bind (("M-n" . git-gutter+-next-hunk)
           ("M-p" . git-gutter+-previous-hunk))
    :config
    (global-git-gutter+-mode t))

  (leaf git-gutter-fringe+
    :doc "Fringe version of git-gutter+.el"
    :req "git-gutter+-0.1" "fringe-helper-1.0.1"
    :added "2020-04-18"
    :url "https://github.com/nonsequitur/git-gutter-fringe-plus"
    :ensure t
    :require t
    :disabled t
    :when window-system
    :bind (("M-n" . git-gutter+-next-hunk)
           ("M-p" . git-gutter+-previous-hunk))
    :custom ((git-gutter-fr+-side quote left-fringe))
    :config
    (global-git-gutter+-mode t))

  (leaf magit
    :doc "A Git porcelain inside Emacs."
    :req "emacs-25.1" "async-20180527" "dash-20180910" "git-commit-20181104" "transient-20190812" "with-editor-20181103"
    :tag "vc" "tools" "git" "emacs>=25.1"
    :added "2020-04-18"
    :emacs>= 25.1
    :ensure t
    :bind (("C-x m" . magit-status))
    :custom ((magit-auto-revert-mode)
             (vc-handled-backends quote nil))
    :config
    (with-eval-after-load 'magit
      (eval-after-load "vc"
        '(remove-hook 'find-file-hooks 'vc-find-file-hook))))

  (leaf git-link
    :doc "Get the GitHub/Bitbucket/GitLab URL for a buffer location"
    :req "emacs-24.3"
    :tag "convenience" "sourcehut" "gitlab" "bitbucket" "github" "vc" "git" "emacs>=24.3"
    :added "2020-04-21"
    :url "http://github.com/sshaw/git-link"
    :emacs>= 24.3
    :ensure t)

  (leaf smeargle
    :doc "Highlighting region by last updated time"
    :req "emacs-24.3"
    :tag "emacs>=24.3"
    :added "2020-04-21"
    :url "https://github.com/emacsorphanage/smeargle"
    :emacs>= 24.3
    :ensure t)

  (leaf git-timemachine
    :doc "Walk through git revisions of a file"
    :req "emacs-24.3" "transient-0.1.0"
    :tag "vc" "emacs>=24.3"
    :added "2020-04-21"
    :url "https://gitlab.com/pidu/git-timemachine"
    :emacs>= 24.3
    :ensure t)

  (leaf gitignore-mode
    :doc "Major mode for editing .gitignore files"
    :tag "git" "vc" "convenience"
    :added "2020-04-18"
    :url "https://github.com/magit/git-modes"
    :ensure t)

  (leaf gitattributes-mode
    :doc "Major mode for editing .gitattributes files"
    :tag "git" "vc" "convenience"
    :added "2020-04-18"
    :url "https://github.com/magit/git-modes"
    :ensure t)

  (leaf gitconfig-mode
    :doc "Major mode for editing .gitconfig files"
    :tag "git" "vc" "convenience"
    :added "2020-04-18"
    :url "https://github.com/magit/git-modes"
    :ensure t))

(leaf docker
  :config
  (leaf docker
    :doc "Emacs interface to Docker"
    :req "dash-2.14.1" "docker-tramp-0.1" "emacs-24.5" "json-mode-1.7.0" "s-1.12.0" "tablist-0.70" "transient-0.1.0"
    :tag "convenience" "filename" "emacs>=24.5"
    :added "2020-04-21"
    :url "https://github.com/Silex/docker.el"
    :emacs>= 24.5
    :ensure t
    :after docker-tramp json-mode tablist)

  (leaf docker-tramp
    :doc "TRAMP integration for docker containers"
    :req "emacs-24" "cl-lib-0.5"
    :tag "convenience" "docker" "emacs>=24"
    :added "2020-04-21"
    :url "https://github.com/emacs-pe/docker-tramp.el"
    :emacs>= 24
    :ensure t
    :custom ((docker-tramp-use-names . t)))

  (leaf tablist
    :doc "Extended tabulated-list-mode"
    :req "emacs-24.3"
    :tag "lisp" "extensions" "emacs>=24.3"
    :added "2020-04-21"
    :emacs>= 24.3
    :ensure t)

  (leaf dockerfile-mode
    :doc "Major mode for editing Docker's Dockerfiles"
    :req "emacs-24" "s-1.12"
    :tag "emacs>=24"
    :added "2020-04-18"
    :url "https://github.com/spotify/dockerfile-mode"
    :emacs>= 24
    :ensure t
    :mode ("/Dockerfile/"))

  (leaf docker-compose-mode
    :doc "Major mode for editing docker-compose files"
    :req "emacs-24.3" "dash-2.12.0" "yaml-mode-0.0.12"
    :tag "convenience" "emacs>=24.3"
    :added "2020-04-21"
    :url "https://github.com/meqif/docker-compose-mode"
    :emacs>= 24.3
    :ensure t
    :after yaml-mode))

(leaf langage-settings
  :config
  (leaf lsp
    :config
    (leaf lsp-mode
      :doc "LSP mode"
      :req "emacs-25.1" "dash-2.14.1" "dash-functional-2.14.1" "f-0.20.0" "ht-2.0" "spinner-1.7.3" "markdown-mode-2.3" "lv-0"
      :tag "languages" "emacs>=25.1"
      :added "2020-04-19"
      :url "https://github.com/emacs-lsp/lsp-mode"
      :emacs>= 25.1
      :ensure t
      :require t
      :hook (prog-major-mode-hook function-hook lsp-prog-major-mode-enable-hook)
      :custom ((lsp-enable-snippet . t)
               (lsp-enable-indentation)
               (lsp-prefer-flymake)
               (lsp-document-sync-method quote incremental)
               (lsp-inhibit-message . t)
               (lsp-message-project-root-warning . t)
               (create-lockfiles)
               (lsp-rust-rls-command . '("rustup" "run" "nightly" "rls"))))

    (leaf lsp-ui
      :doc "UI modules for lsp-mode"
      :req "emacs-25.1" "dash-2.14" "dash-functional-1.2.0" "lsp-mode-6.0" "markdown-mode-2.3"
      :tag "lsp" "emacs>=25.1"
      :added "2020-04-19"
      :url "https://github.com/emacs-lsp/lsp-ui"
      :emacs>= 25.1
      :ensure t
      :require t
      :after lsp-mode
      :hook (lsp-mode-hook)
      :custom ((lsp-ui-doc-enable . t)
               (lsp-ui-doc-header . t)
               (lsp-ui-doc-include-signature . t)
               (lsp-ui-doc-position quote top)
               (lsp-ui-doc-max-width . 60)
               (lsp-ui-doc-max-height . 20)
               (lsp-ui-doc-use-childframe . t)
               (lsp-ui-doc-use-webkit)
               (lsp-ui-flycheck-enable . t)
               (lsp-ui-sideline-enable)
               (lsp-ui-sideline-ignore-duplicate . t)
               (lsp-ui-sideline-show-symbol . t)
               (lsp-ui-sideline-show-hover . t)
               (lsp-ui-sideline-show-diagnostics . t)
               (lsp-ui-sideline-show-code-actions . t)
               (lsp-ui-imenu-enable)
               (lsp-ui-imenu-kind-position quote top)
               (lsp-ui-peek-enable . t)
               (lsp-ui-peek-always-show . t)
               (lsp-ui-peek-peek-height . 30)
               (lsp-ui-peek-list-width . 30)
               (lsp-ui-peek-fontify quote always)))

    (leaf company-lsp
      :doc "Company completion backend for lsp-mode."
      :req "emacs-25.1" "lsp-mode-6.0" "company-0.9.0" "s-1.2.0" "dash-2.11.0"
      :tag "emacs>=25.1"
      :added "2020-04-19"
      :url "https://github.com/tigersoldier/company-lsp"
      :emacs>= 25.1
      :ensure t
      :require t
      :after lsp-mode company
      :commands company-lsp
      :custom ((company-lsp-cache-candidates)
               (company-lsp-async . t)
               (company-lsp-enable-recompletion . t)
               (company-lsp-enable-snippet . t))
      :config
      (push 'company-lsp company-backends))

    (leaf lsp-treemacs
      :doc "LSP treemacs"
      :req "emacs-25.1" "dash-2.14.1" "dash-functional-2.14.1" "f-0.20.0" "ht-2.0" "treemacs-2.5" "lsp-mode-6.0"
      :tag "languages" "emacs>=25.1"
      :added "2020-04-19"
      :url "https://github.com/emacs-lsp/lsp-treemacs"
      :emacs>= 25.1
      :ensure t
      :require t
      :after treemacs lsp-mode
      :setq ((lsp-treemacs-theme . "centaur-colors"))
      :config
      (with-eval-after-load 'ace-window
        (when (boundp 'aw-ignored-buffers)
          (push 'lsp-treemacs-symbols-mode aw-ignored-buffers)
          (push 'lsp-treemacs-java-deps-mode aw-ignored-buffers))))

    (leaf dap-mode
      :doc "Debug Adapter Protocol mode"
      :req "emacs-25.1" "dash-2.14.1" "lsp-mode-6.0" "dash-functional-1.2.0" "bui-1.1.0" "f-0.20.0" "s-1.12.0" "lsp-treemacs-0.1"
      :tag "debug" "languages" "emacs>=25.1"
      :added "2020-04-19"
      :url "https://github.com/yyoncho/dap-mode"
      :emacs>= 25.1
      :ensure t
      :after lsp-mode bui lsp-treemacs
      :commands dap-ui-mode
      :hook ((after-init . dap-mode)
             (dap-mode . dap-ui-mode)
             (dap-session-created . (lambda (&_rest) (dap-hydra)))
             (dap-terminated . (lambda (&_rest) (dap-hydra/nil)))
             (dap-stopped-hook . (lambda (arg) (call-interactively #'dap-hydra)))
             (python-mode . (lambda () (require 'dap-python)))
             (ruby-mode . (lambda () (require 'dap-ruby)))
             (go-mode . (lambda () (require 'dap-go)))
             (java-mode . (lambda () (require 'dap-java)))
             (php-mode . (lambda () (require 'dap-php)))
             (elixir-mode . (lambda () (require 'dap-elixir)))
             ((js-mode js2-mode) . (lambda () (require 'dap-chrome)))
             ((c-mode c++-mode objc-mode swift) . (lambda () (require 'dap-gdb-lldb))))))

  (leaf web-mode
    :doc "major mode for editing web templates"
    :req "emacs-23.1"
    :tag "languages" "emacs>=23.1"
    :added "2020-04-18"
    :url "http://web-mode.org"
    :emacs>= 23.1
    :ensure t
    :custom ((web-mode-engines-alist '(("php" . "/.phtml$/")
                                       ("blade" . "/.blade$/"))))
    :mode ("/.[gj]sp$/'"
           "/.as[cp]x$/'"
           "/.erb$/'"
           "/.mustache$/'"
           "/.djhtml$/'"
           "/.html$/'"))

  (leaf emmet-mode
    :doc "Unofficial Emmet's support for emacs"
    :tag "convenience"
    :added "2020-04-18"
    :url "https://github.com/smihica/emmet-mode"
    :ensure t
    :bind (("M-1" . emmet-expand-line))
    :custom ((emmet-move-cursor-between-quotes . t))
    :mode ("/.html$/" "/.xml$/" "/.launch$/")
    :config
    (with-eval-after-load 'emmet-mode
      (add-hook 'sgml-mode-hook 'emmet-mode)
      (add-hook 'emmet-mode-hook
                (lambda nil
                  (setq emmet-indentation 4)))))

  (leaf php-mode
    :doc "Major mode for editing PHP code"
    :req "emacs-24.3"
    :tag "php" "languages" "emacs>=24.3"
    :added "2020-04-18"
    :url "https://github.com/emacs-php/php-mode"
    :emacs>= 24.3
    :ensure t
    :bind ((php-mode-map
            ("C-i" . indent-region)
            ("C-." . other-window)))
    :mode ("\\.php$/"))

  (leaf js2-mode
    :doc "Improved JavaScript editing mode"
    :req "emacs-24.1" "cl-lib-0.5"
    :tag "javascript" "languages" "emacs>=24.1"
    :added "2020-04-18"
    :url "https://github.com/mooz/js2-mode/"
    :emacs>= 24.1
    :ensure t
    :mode (("/.js$/"    . js2-mode)
           ("/.jsx$/" . js2-jsx-mode)))

  (leaf htmlize
    :doc "Convert buffer text and decorations to HTML."
    :tag "extensions" "hypermedia"
    :added "2020-04-18"
    :url "https://github.com/hniksic/emacs-htmlize"
    :ensure t)

  (leaf json-mode
    :doc "Major mode for editing JSON files."
    :req "json-reformat-0.0.5" "json-snatcher-1.0.0"
    :added "2020-04-18"
    :url "https://github.com/joshwnj/json-mode"
    :ensure t
    :mode ("/.json$/"))

  (leaf markdown-mode
    :doc "Major mode for Markdown-formatted text"
    :req "emacs-24.4"
    :tag "itex" "github flavored markdown" "markdown" "emacs>=24.4"
    :added "2020-04-18"
    :url "https://jblevins.org/projects/markdown-mode/"
    :emacs>= 24.4
    :ensure t
    :bind ((markdown-mode-map
            ("<tab>" . markdown-demote)
            ("C-<tab>" . markdown-promote)))
    :mode (("/.md$/" . gfm-mode))
    :custom ((markdown-command . '"jq --slurp --raw-input '{\"text\": \"\\(.)\", \"mode\": \"gfm\"}' | curl -sS --data @- https://api.github.com/markdown")))

  (leaf yaml-mode
    :doc "Major mode for editing YAML files"
    :req "emacs-24.1"
    :tag "yaml" "data" "emacs>=24.1"
    :added "2020-04-18"
    :emacs>= 24.1
    :ensure t
    :mode ("/.yml$/" "/.yaml$/"))

  (leaf verilog-mode
    :doc "major mode for editing verilog source in Emacs"
    :tag "builtin"
    :added "2020-04-18"
    :ensure t
    :require t
    :bind ((verilog-mode-map
            ("C-;"))))

  (leaf plantuml-mode
    :doc "Major mode for PlantUML"
    :req "dash-2.0.0" "emacs-25.0"
    :tag "ascii" "plantuml" "uml" "emacs>=25.0"
    :added "2020-04-18"
    :emacs>= 25.0
    :ensure t
    :mode ("/.pu$/" "/.plantuml$/")
    :custom ((plantuml-jar-path . "/opt/plantuml/plantuml.jar")
             (plantuml-default-exec-mode quote jar)
             (plantuml-executable-path . "/usr/local/bin/plantuml")
             (plantuml-default-exec-mode quote executable)))

  (leaf nxml-mode
    :doc "a new XML mode"
    :tag "builtin" "xml" "languages" "hypermedia" "wp"
    :added "2020-04-20"
    :custom ((nxml-child-indent . 2)
             (nxml-attribute-indent . 2)
             (indent-tabs-mode . nil)
             (nxml-slash-auto-complete-flag . t)
             (tab-width . 2))
    :mode ("/.xml$/" "/.xsl$/" "/.xhtml$/" "/.page$/" "/.launch$/")
    :config
    (custom-set-faces
     '(nxml-comment-content-face ((t (:foreground "yellow4"))))
     '(nxml-comment-delimiter-face ((t (:foreground "yellow4"))))
     '(nxml-delimited-data-face ((t (:foreground "lime green"))))
     '(nxml-delimiter-face ((t (:foreground "grey"))))
     '(nxml-element-local-name-face ((t (:inherit nxml-name-face :foreground "medium turquoise"))))
     '(nxml-name-face ((t (:foreground "rosy brown"))))
     '(nxml-tag-slash-face ((t (:inherit nxml-name-face :foreground "grey"))))))

  (leaf ccls
    :doc "ccls client for lsp-mode"
    :req "emacs-25.1" "lsp-mode-4.2" "dash-0.14" "projectile-1.0.0"
    :tag "c++" "lsp" "languages" "emacs>=25.1"
    :added "2020-04-18"
    :url "https://github.com/MaskRay/emacs-ccls"
    :emacs>= 25.1
    :ensure t
    :require t
    :after lsp-mode projectile
    :custom ((ccls-executable . "/usr/local/bin/ccls")
             (ccls-sem-highlight-method quote font-lock))
    :config
    (add-hook 'c-mode-hook #'(lambda nil (require 'ccls) (lsp)))
    (add-hook 'c++-mode-hook #'(lambda nil (require 'ccls) (lsp)))
    (add-hook 'objc-mode-hook #'(lambda nil (require 'ccls) (lsp))))

  (leaf rust
    :config
    (leaf rustic
      :doc "Rust development environment"
      :req "emacs-26.1" "xterm-color-1.6" "dash-2.13.0" "s-1.10.0" "f-0.18.2" "projectile-0.14.0" "markdown-mode-2.3" "spinner-1.7.3" "let-alist-1.0.4" "seq-2.3" "ht-2.0"
      :tag "languages" "emacs>=26.1"
      :added "2020-04-18"
      :emacs>= 26.1
      :ensure t
      :commands rustic-mode
      :custom ((rustic-lsp-server . 'rls)
               (rustic-rls-pkg . 'lsp-mode))
      :config
      (cl-delete-if (lambda (element) (equal (cdr element) 'rust-mode)) auto-mode-alist)
      (cl-delete-if (lambda (element) (equal (cdr element) 'rustic-mode)) auto-mode-alist)
      (add-to-list 'auto-mode-alist '("\\.rs$" . rustic-mode)))

    (leaf toml-mode
      :doc "Major mode for editing TOML files"
      :req "emacs-24" "cl-lib-0.5"
      :tag "toml" "data" "emacs>=24"
      :added "2020-04-18"
      :url "https://github.com/dryman/toml-mode.el"
      :emacs>= 24
      :ensure t
      :mode ("/.toml$/"))

    (leaf racer
      :doc "code completion, goto-definition and docs browsing for Rust via racer"
      :req "emacs-25.1" "rust-mode-0.2.0" "dash-2.13.0" "s-1.10.0" "f-0.18.2" "pos-tip-0.4.6"
      :tag "tools" "rust" "matching" "convenience" "abbrev" "emacs>=25.1"
      :added "2020-04-18"
      :url "https://github.com/racer-rust/emacs-racer"
      :emacs>= 25.1
      :ensure t)

    (leaf cargo
      :doc "Emacs Minor Mode for Cargo, Rust's Package Manager."
      :req "emacs-24.3" "rust-mode-0.2.0" "markdown-mode-2.4"
      :tag "tools" "emacs>=24.3"
      :added "2020-04-18"
      :emacs>= 24.3
      :ensure t
      :after rust-mode markdown-mode
      :commands cargo-minor-mode
      :hook ((rust-mode-hook . cargo-minor-mode)))

    (leaf flycheck-rust
      :doc "Flycheck: Rust additions and Cargo support"
      :req "emacs-24.1" "flycheck-28" "dash-2.13.0" "seq-2.3" "let-alist-1.0.4"
      :tag "convenience" "tools" "emacs>=24.1"
      :added "2020-04-18"
      :url "https://github.com/flycheck/flycheck-rust"
      :emacs>= 24.1
      :ensure t
      :after flycheck rustic-mode
      :hook ((quote-hook . flycheck-rust-setup)
             (flycheck-mode-hook-hook . flycheck-rust-setup))))
  (leaf org
    :config
    (leaf org
      :doc "Outline-based notes management and organizer"
      :tag "builtin"
      :added "2020-04-18"
      :mode ("/.org$/")
      :custom ((org-image-actual-width)
               (org-directory quote "~/Dropbox/org")
               (org-default-notes-file quote "notes.org")
               (org-agenda-files quote
                                 ("~/Dropbox/org" "~/Dropbox/org/diary"))
               (org-todo-keywords quote
                                  ((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))
               (org-log-done quote time)
               (org-startup-truncated)
               (org-use-speed-commands . t)
               (org-enforce-todo-dependencies . t)
               (org-capture-templates quote
                                      (("t" "Todo" entry
                                        (file+headline "~/Dropbox/org/gtd.org" "INBOX")
                                        "* TODO %?\n %i\n %a")
                                       ("s" "Schedule" entry
                                        (file "~/Dropbox/org/schedule.org")
                                        "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
                                       ("n" "Note" entry
                                        (file+headline "~/Dropbox/org/notes.org" "Notes")
                                        "* %?\nEntered on %U\n %i\n %a")))
               (org-latex-pdf-process quote
                                      ("platex -shell-escape %f" "platex -shell-escape %f" "dvipdfmx %b.dvi"))))

    (leaf org-bullets
      :doc "Show bullets in org-mode as UTF-8 characters"
      :added "2020-04-18"
      :url "https://github.com/integral-dw/org-bullets"
      :ensure t
      :hook (org-mode-hook))

    (leaf org-pomodoro
      :doc "Pomodoro implementation for org-mode."
      :req "alert-0.5.10" "cl-lib-0.5"
      :added "2020-04-18"
      :url "https://github.com/lolownia/org-pomodoro"
      :ensure t
      :after org-agenda
      :custom ((org-pomodoro-ask-upon-killing . t)
               (org-pomodoro-format . "⏳%s")
               (org-pomodoro-short-break-format . "%s")
               (org-pomodoro-long-break-format . "⏳%s")
               (org-pomodoro-start-sound-p . t)
               (org-pomodoro-start-sound . "~/.emacs.d/sound/strange_bell.wav")
               (org-pomodoro-finished-sound . "~/.emacs.d/sound/poka.wav")
               (org-pomodoro-short-break-sound . "~/.emacs.d/sound/guitar7.wav"))
      :custom-face ((org-pomodoro-mode-line quote
                                            ((t
                                              (:foreground "#ff5555"))))
                    (org-pomodoro-mode-line-break quote
                                                  ((t
                                                    (:foreground "#50fa7b")))))
      :config
      (add-hook 'org-pomodoro-started-hook
                #'(lambda nil
                    (notifications-notify :title "org-pomodoro" :body "Let's focus for 25 minutes!" :app-icon "~/.emacs.d/img/PC.png")))
      (add-hook 'org-pomodoro-finished-hook
                #'(lambda nil
                    (notifications-notify :title "org-pomodoro" :body "Well done! Take a break." :app-icon "~/.emacs.d/img/coffee.gif"))))))

(leaf global-settings
  :config
  (leaf encoding-and-font
    :custom ((coding-system-for-read  . 'utf-8)
             (coding-system-for-write . 'utf-8))
    :config
    (set-locale-environment nil)
    (set-language-environment "Japanese")
    (set-terminal-coding-system 'utf-8)
    (set-keyboard-coding-system 'utf-8)
    (set-buffer-file-coding-system 'utf-8)
    (set-default-coding-systems 'utf-8)
    (prefer-coding-system 'utf-8)
    (set-face-attribute 'default nil :family "Cica" :height 120)
    (setq default-input-method "japanese-mozc"))

  (leaf if-window-system
    :when window-system
    :config
    (menu-bar-mode -1)
    (tool-bar-mode -1)
    (scroll-bar-mode -1)
    (set-frame-parameter nil 'fullscreen 'maximized)
    (when window-system
      (progn
        (set-face-background 'default "#252530")
        (set-face-background 'fringe "#252530"))))

  (leaf key-bindings
    :config
    (defun my/insert-tab ()
      (interactive)
      (insert "\t"))

    (defun my/untabify ()
      (interactive)
      (untabify (point-min) (point-max)))

    (defun my/tabify ()
      (interactive)
      (tabify (point-min) (point-max)))

    (defun my/other-window-backwords ()
      (interactive)
      (other-window -1))

    (defun my/shrink-window-vertically (arg)
      (interactive)
      (shrink-window arg))

    (defun my/enlarge-window-vertically (arg)
      (interactive)
      (shrink-window -arg))

    (defun my/open-org-diary ()
      (interactive)
      (elscreen-create)
      (open-junk-file))

    (defhydra hydra-org-menu
      (:color amaranth :hint nil)
      "
                                                          ┳━━━━━┳
                                                          ┃ Org ┃
      ┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━┻
        [_d_] my/open-org-diary
        [_a_] org-agenda
        [_c_] org-capture
        [_p_] org-pomodoro
      ┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻
      "
      ("d"   my/open-org-diary :color blue)
      ("a"   org-agenda        :color blue)
      ("c"   org-capture       :color blue)
      ("p"   org-pomodoro      :color blue)
      ("q"   nil "quit"        :color blue)
      ("C-q" nil "quit"        :color blue))

    (defhydra hydra-git-menu
      (:color amaranth :hint nil)
      "
                                                          ┳━━━━━┳
                                                          ┃ Git ┃
      ┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━┻
        [_m_] magit-status     [_t_] git-timemachine
        [_b_] magit-blame      [_d_] git-gutter:popup-hunk
        [_g_] helm-git-grep    [_r_] git-gutter:revert-hunk
        [_l_] git-link
      ┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻
      "
      ("m"       magit-status             :color blue)
      ("b"       magit-blame              :color blue)
      ("g"       helm-git-grep            :color blue)
      ("l"       git-link                 :color blue)
      ("t"       git-timemachine          :color blue)
      ("d"       git-gutter:popup-hunk    :color blue)
      ("r"       git-gutter:revert-hunk   :color blue)
      ("q"       nil "quit"               :color blue)
      ("C-q"     nil "quit"               :color blue))

    (defhydra hydra-lsp-menu
      (:color amaranth :hint nil)
      "
                                                                                                                           ┳━━━━━┳
                                                                                                                           ┃ LSP ┃
      ┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━┻
        [_l_] lsp                              [_c_] lsp-rename                [_R_] lsp-workspace-folders-remove  [_<f5>_] dap-debug
        [_d_] lsp-ui-peek-find-definitions     [_e_] lsp-treemacs-errors-list  [_L_] lsp-lens-mode                 [_H_]    dap-hydra
        [_r_] lsp-ui-peek-find-references      [_f_] lsp-format-buffer         [_S_] lsp-ui-sideline-mode
        [_i_] lsp-ui-peek-find-implementation  [_s_] lsp-describe-session
      ┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻
      "
      ("l"    lsp                             :color blue)
      ("d"    lsp-ui-peek-find-definitions    :color blue)
      ("r"    lsp-ui-peek-find-references     :color blue)
      ("i"    lsp-ui-peek-find-implementation :color blue)
      ("c"    lsp-rename                      :color blue)
      ("e"    lsp-treemacs-errors-list        :color blue)
      ("s"    lsp-describe-session            :color blue)
      ("f"    lsp-format-buffer               :color blue)
      ("R"    lsp-workspace-folders-remove    :color blue)
      ("L"    lsp-lens-mode                   :color blue)
      ("S"    lsp-ui-sideline-mode            :color blue)
      ("<f5>" dap-debug                       :color blue)
      ("H"    dap-hydra                       :color blue)
      ("q"    nil "quit"                      :color blue)
      ("C-q"  nil "quit"                      :color blue))

    (defhydra hydra-my-main-menu
      (:color amaranth :hint nil)
      "
                                                                                                                                    ┳━━━━━━┳
                                                                                                                                    ┃ Main ┃
      ┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━┻
              ^[_p_]^       |  [_0_] delete-window           [_C-c_] elscreen-create       [_I_] zoom-in        [_<up>_]    v-shrink   |  [_o_] Org
               ^^↑^^        |  [_1_] delete-other-windows    [_C-p_] elscreen-previous     [_O_] zoom-out       [_<down>_]  v-enlarge  |  [_g_] Git
         [_b_] ←   → [_f_]  |  [_2_] split-window-below      [_C-k_] elscreen-kill         [_r_] revert-buffer  [_<left>_]  h-shrink   |  [_l_] LSP
               ^^↓^^        |  [_3_] split-window-right      [_C-b_] elscreen-find-and-go  [_s_] eshell         [_<right>_] h-enlarge  |
              ^[_n_]^       |  [_4_] kill-buffer-and-window  [_C-s_] elscreen-split        [_b_] helm-mini                           ^^|
      ┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻
      "
      ("f"       windmove-right                   :color red)
      ("b"       windmove-left                    :color red)
      ("n"       windmove-down                    :color red)
      ("p"       windmove-up                      :color red)
      ("<up>"    my/shrink-window-vertically      :color red)
      ("<down>"  my/enlarge-window-vertically     :color red)
      ("<left>"  shrink-window-horizontally       :color red)
      ("<right>" enlarge-window-horizontally      :color red)
      ("0"       delete-window                    :color red)
      ("1"       delete-other-windows             :color red)
      ("2"       split-window-below               :color red)
      ("3"       split-window-right               :color red)
      ("4"       kill-buffer-and-window           :color red)
      ("5"       make-frame-command               :color red)
      ("C-c"     elscreen-create                  :color red)
      ("C-p"     elscreen-previous                :color red)
      ("C-k"     elscreen-kill                    :color red)
      ("C-b"     elscreen-find-and-goto-by-buffer :color red)
      ("C-s"     elscreen-split                   :color red)
      ("I"       text-scale-increase              :color red)
      ("O"       text-scale-decrease              :color red)
      ("r"       revert-buffer                    :color red)
      ("s"       eshell                           :color red)
      ("b"       helm-mini                        :color red)
      ("o"       hydra-org-menu/body              :color blue)
      ("g"       hydra-git-menu/body              :color blue)
      ("l"       hydra-lsp-menu/body              :color blue)
      ("d"       hydra-docker-menu/body           :color blue)
      ("q"       nil "quit"                       :color blue)
      ("C-q"     nil "quit"                       :color blue))

    (define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))
    (define-key region-bindings-mode-map (kbd "c") 'kill-ring-save)
    (define-key region-bindings-mode-map (kbd "x") 'kill-region)
    (define-key region-bindings-mode-map (kbd "i") 'align)
    (define-key region-bindings-mode-map (kbd ";") 'comment-dwim)
    (define-key global-map (kbd "C-x C-z") nil)
    (define-key global-map (kbd "<tab>")   nil)
    (define-key global-map (kbd "<tab>")   'indent-according-to-mode)
    (define-key global-map (kbd "M-.")     'other-window)
    (define-key global-map (kbd "C-i")     'indent-region)
    (define-key global-map (kbd "C-j")     'newline-and-indent)
    (define-key global-map (kbd "C-t")     'my/insert-tab)
    (define-key global-map (kbd "<f6>")    'my/untabify)
    (define-key global-map (kbd "<f7>")    'my/tabify)
    (define-key global-map (kbd "C-o")     'hydra-my-main-menu/body))

  (leaf others
    :custom ((c-default-style         . '((c++-mode . "stroustrup")))
             (ring-bell-function      . 'ignore) ;; エラー音を無効化する
             (inhibit-startup-message . t) ;; スタートアップメッセージを表示しない
             (kill-whole-line         . t) ;; 行の先頭でC-kを押すとその行ごと削除する
             (make-backup-files       . nil) ;; バックアップファイルを作成しない
             (auto-save-default       . nil) ;; オートセーブファイルを作成しない
             (c-basic-offset          . 4)
             (tab-width               . 4)
             (indent-tabs-mode        . nil))
    :config
    (blink-cursor-mode 0) ;; カーソルの点滅を無効化
    (transient-mark-mode t) ;; 選択範囲を強調する
    (set-face-background 'region "#808040")
    (global-hl-line-mode t) ;; カーソル行を強調する
    (show-paren-mode 1) ;; 対応する括弧を強調する
    (set-default 'truncate-lines t) ;; 文字を折り返さない
    (column-number-mode  t) ;; 行番号，列番号，関数名をモードラインに表示する
    (line-number-mode    t)
    (which-function-mode -1)
    (fset 'yes-or-no-p 'y-or-n-p)   ;; "yes or no"を"y or n"に
    (c-set-offset 'cpp-macro '0)    ;; マクロのインデント
    (c-set-offset 'case-label '+))) ;; case文のインデント

(provide 'init)

;; Local Variables:
;; indent-tabs-mode: nil
;; End:

;;; init.el ends here
