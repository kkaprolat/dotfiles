;; General Options
;; Not loading ~bind-key~ early caused error messages, so do that right away.

;; [[file:config.org::*General Options][General Options:1]]
(require 'bind-key)
;; General Options:1 ends here


;; Since I use ~use-package~ for all my packages and don't want to repeat ~:ensure t~ everywhere, I set the following:

;; [[file:config.org::*General Options][General Options:2]]
(require 'use-package-ensure)
(setq use-package-always-ensure t)
;; General Options:2 ends here

;; Interface Theme
;; For the overall theme, I use catppuccin.
;; This has to be loaded early since I use some of it's variables occasionally.
;; Note that when reinstalling via Emacs, it couldn't install ~catppuccin-theme~ for some reason.
;; Installing that via ~M-x package-install~ fixed that.

;; [[file:config.org::*Interface Theme][Interface Theme:1]]
(use-package catppuccin-theme
  :init
;; Interface Theme:1 ends here


;; The two ~t~ parameters when loading it are necessary for customization.

;; [[file:config.org::*Interface Theme][Interface Theme:2]]
(load-theme 'catppuccin t t)
;; Interface Theme:2 ends here


;; And I want to use the moccha flavor.

;; [[file:config.org::*Interface Theme][Interface Theme:3]]
(setq catppuccin-flavor 'mocha)
(catppuccin-reload)
)
;; Interface Theme:3 ends here



;; Furthermore, the whole interface should be slightly transparent.
;; Unfortunately, this also makes the menu bar transparent.

;; [[file:config.org::*Interface Theme][Interface Theme:4]]
(set-frame-parameter nil 'alpha-background 85)
(add-to-list 'default-frame-alist '(alpha-background . 85))
;; Interface Theme:4 ends here

;; Cleanliness
;; First of all, as all options should only ever be in this file, all customizations should be saved to ~/tmp~ to be easily discarded.

;; [[file:config.org::*Cleanliness][Cleanliness:1]]
(setq custom-file (make-temp-name "/tmp/"))
;; Cleanliness:1 ends here



;; I also dislike Emacs' cluttering of directories with backup files (i.e. files ending with ~~~).
;; Instead, all these files should be moved to a single directory.

;; [[file:config.org::*Cleanliness][Cleanliness:2]]
(setq backup-directory-alist '(("." . "~/.cache/emacs_backups")))
;; Cleanliness:2 ends here

;; Package Setup
;; For some settings it is also useful to know whether we are running under NixOS.
;; This can be tested by checking whether ~NIX_PATH~ is set in ~initial-environment~ or ~process-environment~.

;; [[file:config.org::*Package Setup][Package Setup:1]]
(defvar my/running-under-nix (if (seq-find (lambda (x) (string-prefix-p "NIX_PATH" x)) initial-environment)
                                 t
                               nil)
  "Whether the editor runs in a Nix environment, making some package operations unnecessary.")
;; Package Setup:1 ends here




;; For example, when not using NixOS, most packages have to be retrieved from MELPA.
;; As such, that configuration is added here.

;; [[file:config.org::*Package Setup][Package Setup:2]]
(when (not my/running-under-nix)
     (require 'package)
     (add-to-list 'package-archives
                  '("melpa" . "https://melpa.org/packages/") t)
     (package-initialize)
)
;; Package Setup:2 ends here



;; Furthermore, since Nix automatically installs every package requested, and since I don't like repeating src_emacs-lisp[]{:ensure t} all over the place, I set ~use-package-always-ensure~.

;; [[file:config.org::*Package Setup][Package Setup:3]]
(when (not my/running-under-nix)
  (require 'use-package-ensure)
  (setq use-package-always-ensure t)
  )
;; Package Setup:3 ends here

;; Performance
;; Setting the garbage collection threshold higher (100MB in this case) may fix some performance problems.

;; [[file:config.org::*Performance][Performance:1]]
(setq gc-cons-threshold (* 100 1024 1024))
;; Performance:1 ends here



;; When using ~doom-modeline~, some issues can be fixed with the following.

;; [[file:config.org::*Performance][Performance:2]]
(setq inhibit-compacting-font-caches t)
;; Performance:2 ends here



;; When using LSP, this is required to read large data blobs (1MB).

;; [[file:config.org::*Performance][Performance:3]]
(setq read-process-output-max (* 1024 1024))
;; Performance:3 ends here

;; Indentation
;; By default, indent with two spaces.

;; [[file:config.org::*Indentation][Indentation:1]]
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq standard-indent 2)
;; Indentation:1 ends here

;; Encoding
;; Always use UTF-8.

;; [[file:config.org::*Encoding][Encoding:1]]
(set-charset-priority 'unicode)
(prefer-coding-system 'utf-8-unix)
;; Encoding:1 ends here

;; Dired
;; Dired should be automatically refreshed when files are changed.

;; [[file:config.org::*Dired][Dired:1]]
(setq dired-do-revert-buffer t)
;; Dired:1 ends here

;; "Console-Like"
;; Since I want to use Emacs mostly as a "console-like" native application, I always want to be prompted in the minibuffer and not in dialog boxes.

;; [[file:config.org::*"Console-Like"]["Console-Like":1]]
(setq use-dialog-box nil)
;; "Console-Like":1 ends here



;; Also, no tool bar or scroll bar.

;; [[file:config.org::*"Console-Like"]["Console-Like":2]]
;(when (window-system)
  (tool-bar-mode -1)
  (setq tool-bar-mode nil)
  (scroll-bar-mode -1)
  (setq scroll-bar-mode nil)
;; "Console-Like":2 ends here



;; At some point, I may also remove the menu bar on top.

;; [[file:config.org::*"Console-Like"]["Console-Like":3]]
; (menu-bar-mode -1)
; (setq menu-bar-mode nil)
;)
;; "Console-Like":3 ends here

;; Scrolling
;; I like smooth scrolling with my mouse or trackpad.

;; [[file:config.org::*Scrolling][Scrolling:1]]
(pixel-scroll-precision-mode)
(setq pixel-scroll-precision-interpolate-page t)
;; Scrolling:1 ends here



;; While this breaks in evil mode, it can still be used for animations using [[https://codeberg.org/ideasman42/emacs-scroll-on-jump][scroll-on-jump]].

;; [[file:config.org::*Scrolling][Scrolling:2]]
(use-package scroll-on-jump
  :custom
  (scroll-on-jump-duration 0.6)
  (scroll-on-jump-curve 'linear)
  )
;; Scrolling:2 ends here

;; Windows
;; Speaking of the mouse, I want windows to be switched automatically when hovering with the mouse.

;; [[file:config.org::*Windows][Windows:1]]
(setq mouse-autoselect-window t)
;; Windows:1 ends here



;; Furthermore, the help window should be selected immediately, as I probably want to close it after reading.

;; [[file:config.org::*Windows][Windows:2]]
(setq help-window-select t)
;; Windows:2 ends here

;; Line Numbers
;; Display line numbers in most relevant modes:

;; [[file:config.org::*Line Numbers][Line Numbers:1]]
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'org-mode-hook  'display-line-numbers-mode)
(dolist (mode '(pdf-view-mode-hook
                term-mode-hook
                eshell-mode-hook
                vterm-mode-hook
                imenu-list-minor-mode-hook
                imenu-list-major-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode -1))))
;; Line Numbers:1 ends here



;; This actually causes weird behaviour when scrolling, as the width automatically changes with the needed number size.
;; This can be fixed using the following [[https://emacs.stackexchange.com/questions/55165/uneven-line-numbers-with-display-line-numbers][snippet from StackExchange]].

;; [[file:config.org::*Line Numbers][Line Numbers:2]]
(defun display-line-numbers-equalize ()
  "Equalize Line Number Width"
  (setq display-line-numbers-width (length (number-to-string (line-number-at-pos (point-max)))))
  )
(add-hook 'find-file-hook 'display-line-numbers-equalize)
;; Line Numbers:2 ends here



;; Display line and column number in the mode line.

;; [[file:config.org::*Line Numbers][Line Numbers:3]]
(column-number-mode)
;; Line Numbers:3 ends here

;; Lines
;; Always wrap lines, as I don't like scrolling horizontally.

;; [[file:config.org::*Lines][Lines:1]]
(global-visual-line-mode)
;; Lines:1 ends here



;; The current line should be highlighted in programming and text mode.

;; [[file:config.org::*Lines][Lines:2]]
(require 'hl-line)
(add-hook 'prog-mode-hook #'hl-line-mode)
(add-hook 'text-mode-hook #'hl-line-mode)
;; Lines:2 ends here

;; Minibuffer
;; Retain minibuffer history.

;; [[file:config.org::*Minibuffer][Minibuffer:1]]
(savehist-mode)
;; Minibuffer:1 ends here

;; Miscellaneous
;; Sentences should obviously only end with one space after the period.

;; [[file:config.org::*Miscellaneous][Miscellaneous:1]]
(setq sentence-end-double-space nil)
;; Miscellaneous:1 ends here



;; I cannot fix any issues with native compilation as I don't own any of the plugins I use.
;; As such, these warnings are disabled.

;; [[file:config.org::*Miscellaneous][Miscellaneous:2]]
(setq native-comp-async-report-warnings-errors 'silent)
;; Miscellaneous:2 ends here



;; The clipboard should stay in the kill ring before replacing it.

;; [[file:config.org::*Miscellaneous][Miscellaneous:3]]
(setq save-interprogram-paste-before-kill t)
;; Miscellaneous:3 ends here

;; Fonts and Faces
;; As the default font, /Iosevka/ in Size 11 is sufficient.

;; [[file:config.org::*Fonts and Faces][Fonts and Faces:1]]
(set-face-attribute 'default nil :font "Iosevka-11")
(add-to-list 'default-frame-alist '(font . "Iosevka-11"))
;; Fonts and Faces:1 ends here



;; Additionally, comments should be italic.

;; [[file:config.org::*Fonts and Faces][Fonts and Faces:2]]
(set-face-attribute 'font-lock-comment-face nil :slant 'italic)
;; Fonts and Faces:2 ends here



;; Furthermore, the default highlighting for line numbers was too dim for my taste, so let's change it to Catppuccin's ~overlay2~.
;; The current line should furthermore be bold and yellow.

;; [[file:config.org::*Fonts and Faces][Fonts and Faces:3]]
(set-face-attribute 'line-number nil :foreground (alist-get 'overlay2 catppuccin-mocha-colors))
(set-face-attribute 'line-number-current-line nil :foreground (alist-get 'lavender catppuccin-mocha-colors) :weight 'heavy)
;; Fonts and Faces:3 ends here



;; I also like ligatures.
;; Using the [[https://github.com/mickeynp/ligature.el][ligature]] package allows setting specific ligatures for specific modes.
;; Note, that since we use the treesitter modes (configured later), these have to be specified here instead of the default ones.
;; The ~www~ ligature should be used everywhere, and other ligatures should be language-specific.
;; Possible ligatures are taken from the [[https://typeof.net/Iosevka/][Iosevka website]].
;; I omitted the ~/*~ and ~*/~ ligatures, as they look bad in my opinion.

;; [[file:config.org::*Fonts and Faces][Fonts and Faces:4]]
(use-package ligature
  :config
  (ligature-set-ligatures 't '("www"))

  (ligature-set-ligatures 'python-ts-mode  '("<=" "=>" ">=" "__"  "==" "!="  "->" "<-"))
  (ligature-set-ligatures 'c-ts-mode       '("<<=" "<=" ">=" ">>=" "::" ":::" "==" "!="
                                             "*="  "++"))
  (ligature-set-ligatures 'js-ts-mode       '("->" "->>" "-->" "--->" "<<=" "<=" "=>"
                                              "=>>" "==>" "===>" ">=" ">>=" "<->" "<=>"
                                              "::" ":::" "__" "</" "</>" "/>" "~~>" "=="
                                              "!=" "<>" "===" "!==" "!===" "*=" "<|" "<|>"
                                              "|>" "++" "+++" "<!--" "<!---"))
  (global-ligature-mode t)
  )
;; Fonts and Faces:4 ends here

;; Modeline
;; I like the look of [[https://github.com/seagle0128/doom-modeline][doom-modeline]], which requires [[https://github.com/rainstormstudio/nerd-icons.el][nerd-icons]].
;; Also, I enable a bunch of interesting information in the modeline.

;; [[file:config.org::*Modeline][Modeline:1]]
(use-package doom-modeline
  :custom
  (doom-modeline-support-imenu t)
  (doom-modeline-height 35)
  (doom-modeline-minor-modes t)
  (doom-modeline-enable-word-count t)
  (doom-modeline-indent-info t)
  (doom-modeline-check-simple-format t)
  (doom-modeline-time t)
  (doom-modeline-time-icon nil)
  (doom-modeline-time-live-icon nil)
  (doom-modeline-time-analogue-clock nil)
  :init (doom-modeline-mode 1)
  )
(use-package nerd-icons)
;; Modeline:1 ends here



;; Even with the Nerd Font correctly installed, some icons such as 💡 are not displayed.
;; Unfortunately, that icon is used in the mode line.
;; We can set a fallback, however:

;; [[file:config.org::*Modeline][Modeline:2]]
(setq lsp-modeline-code-action-fallback-icon " ")
;; Modeline:2 ends here



;; Further information has to be enabled with minor modes.
;; The file size:

;; [[file:config.org::*Modeline][Modeline:3]]
(size-indication-mode)
;; Modeline:3 ends here


;; The time, with an attempt to hide the CPU information:

;; [[file:config.org::*Modeline][Modeline:4]]
(setq display-time-24hr-format t)
(setq display-time-default-load-average nil)
(display-time-mode)
;; Modeline:4 ends here



;; Over time, minor modes started cluttering up my modeline.
;; This can be fixed by using e.g. [[https://github.com/tarsius/minions][minions]], which ~doom-modeline~ explicitly supports.

;; [[file:config.org::*Modeline][Modeline:5]]
(use-package minions
  :init
  (minions-mode)
  )
;; Modeline:5 ends here

;; Dashboard
;; Using [[https://github.com/emacs-dashboard/emacs-dashboard][emacs-dashboard]], the dashboard can be improved a bit.

;; [[file:config.org::*Dashboard][Dashboard:1]]
(use-package dashboard
:custom
(dashboard-banner-logo-title "Hallo Kay!")
(dashboard-center-content t)
(dashboard-navigation-cycle t)
(dashboard-heading-shorcut-format " [%s]")  ; yes, it is shor_cut, not shor*t*cut
(dashboard-display-icons-p t)
(dashboard-icon-type 'nerd-icons)
(dashboard-set-heading-icons t)
(dashboard-set-file-icons t)
(dashboard-startup-banner "/home/kay/Pictures/Header.webp")
(dashboard-banner-ascii
;; Dashboard:1 ends here


;; I use the following ASCII art image:

;; [[file:config.org::*Dashboard][Dashboard:2]]
"
blablablub
blubbediblub
"
;; Dashboard:2 ends here

;; [[file:config.org::*Dashboard][Dashboard:3]]
)
:config
(add-hook 'dashboard-mode-hook (lambda () (setq-local mode-line-format nil)))
(add-to-list 'doom-modeline-mode-alist '(dashboard-mode . 'nil)) ; disable the doom modeline on the dashboard
(dashboard-setup-startup-hook)
;; Dashboard:3 ends here


;; Interestingly, using ~emacs-dashboard~ causes ~emacs --daemon~ to not work.
;; This can be fixed by setting the following (see Issue [[https://github.com/emacs-dashboard/emacs-dashboard/issues/373][#373]])

;; [[file:config.org::*Dashboard][Dashboard:4]]
:hook (server-after-make-frame . dashboard-refresh-buffer)
)
;; Dashboard:4 ends here

;; Basic Evil
;; Since I'm a long-time Neovim user, I use evil mode in Emacs.
;; Also, as I installed ~scroll-on-jump~ above, hints for jump commands are added to ensure smooth jumping.
;; This does not work for ~G~ for some reason.

;; Additionally, I use ~Space~ as my leader key.
;; This has to be set for both ~normal~ and ~visual~ mode.

;; [[file:config.org::*Basic Evil][Basic Evil:1]]
(use-package evil
  :custom
  (evil-want-integration t)  ;; these are necessary for evil-collection
  (evil-want-keybinding nil)
  :init
  (evil-mode 1)
  :config
  (scroll-on-jump-advice-add evil-undo)
  (scroll-on-jump-advice-add evil-redo)
  (scroll-on-jump-advice-add evil-jump-item)
  (scroll-on-jump-advice-add evil-jump-forward)
  (scroll-on-jump-advice-add evil-jump-backward)
  (scroll-on-jump-advice-add evil-ex-search-next)
  (scroll-on-jump-advice-add evil-ex-search-previous)
  (scroll-on-jump-advice-add evil-forward-paragraph)
  (scroll-on-jump-advice-add evil-backward-paragraph)
  (scroll-on-jump-advice-add evil-goto-mark)
  (scroll-on-jump-advice-add evil-next-line)
  (scroll-on-jump-advice-add evil-previous-line)

  ;; Actions that themselves scroll
  (scroll-on-jump-with-scroll-advice-add evil-goto-line)
  (scroll-on-jump-with-scroll-advice-add evil-scroll-down)
  (scroll-on-jump-with-scroll-advice-add evil-scroll-up)
  (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-center)
  (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-top)
  (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-bottom)
  (scroll-on-jump-with-scroll-advice-add recenter-top-bottom)
  (scroll-on-jump-with-scroll-advice-add evil-goto-first-line)

  ;; set Space as leader key
  (evil-set-leader (list 'normal 'visual) (kbd "SPC"))
  )
;; Basic Evil:1 ends here

;; Keybinds
;; Since many packages don't support ~Evil~ by default, [[https://github.com/emacs-evil/evil-collection][evil-collection]] defines keymaps defined by the community for a lot of modes.

;; [[file:config.org::*Keybinds][Keybinds:1]]
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init)
  )
;; Keybinds:1 ends here



;; Apparently, this sometimes clashes with my choice of ~SPC~ for leader, but we'll see.

;; For ~org-mode~, I'll use [[https://github.com/Somelauw/evil-org-mode][evil-org]].

;; [[file:config.org::*Keybinds][Keybinds:2]]
(use-package evil-org
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys)
  )
;; Keybinds:2 ends here

;; Avy
;; In Neovim, I used [[https://github.com/ggandor/leap.nvim][ggandor/leap.nvim]] for jumping around.
;; In Emacs, this functionality is provided by [[https://github.com/abo-abo/avy][avy]].
;; We can jump everywhere (other windows, not other frames) with ~s~, make all text grey for easier jumping and change some colors.

;; [[file:config.org::*Avy][Avy:1]]
(use-package avy
  :custom
  (avy-style 'pre)
  (avy-all-windows t)
  (avy-background t)
  :config
  (avy-setup-default)
  (define-key evil-normal-state-map (kbd "s") 'avy-goto-char-2)
  :custom-face
  (avy-lead-face
   ((t
     :foreground ,(alist-get 'green catppuccin-mocha-colors)
     :background nil
     :bold t
     )))
  (avy-lead-face-0
   ((t
     :foreground ,(alist-get 'red catppuccin-mocha-colors)
     :background nil
     :bold t
     )))
  (avy-background-face
   ((t
     :foreground ,(alist-get 'overlay1 catppuccin-mocha-colors)))
   )
  )
;; Avy:1 ends here

;; Surround
;; Similar to Neovim's ~kylechui/nvim-surround~, I want to use ~evil-surround~ in Emacs.

;; [[file:config.org::*Surround][Surround:1]]
(use-package evil-surround
  :config
  (global-evil-surround-mode 1)
  )
;; Surround:1 ends here

;; Consult

;; [[file:config.org::*Consult][Consult:1]]
(use-package consult
  :bind (
         ("<leader> f f" . consult-find)
         ("<leader> f r" . consult-ripgrep)
         ("<leader> f p" . consult-register)
         )
  :custom
  (consult-async-min-input 0)
  )
;; Consult:1 ends here



;; The additional package [[https://github.com/gagbo/consult-lsp][consult-lsp]] can be used to query for symbols.

;; [[file:config.org::*Consult][Consult:2]]
(use-package consult-lsp
  :bind (
         ("<leader> f S" . consult-lsp-symbols)
         ("<leader> f s" . consult-lsp-file-symbols)
         ))
;; Consult:2 ends here

;; Vertico
;; Vertico changes the completion UI.
;; # TODO not completion UI but the line on the bottom...

;; [[file:config.org::*Vertico][Vertico:1]]
(use-package vertico
  :custom
  (vertico-resize t)  ; always resize the UI if necessary (i.e. grow or shrink)
  (vertico-cycle t)
  :init
  (vertico-mode)
  )
;; Vertico:1 ends here


;; The README of the package further recommends using savehist to keep the history.
;; This is not the default, unfortunately.

;; [[file:config.org::*Vertico][Vertico:2]]
(use-package savehist
  :init
  (savehist-mode)
  )
;; Vertico:2 ends here

;; Marginalia
;; Marginalia adds additional information to results in Vertico.

;; [[file:config.org::*Marginalia][Marginalia:1]]
(use-package marginalia
  :init
  (marginalia-mode)
  )
;; Marginalia:1 ends here

;; Orderless
;; Orderless makes searching easier, as one can search for multiple components which can match using different criteria.
;; While using [[https://github.com/oantolin/orderless?tab=readme-ov-file#style-dispatchers]["Style Dispatchers"]] to directly specify which component does what is possible, using simple searches is sufficient for the time being.

;; [[file:config.org::*Orderless][Orderless:1]]
(use-package orderless
  :custom
  (completion-styles '(orderless))
  (orderless-matching-styles
   '(orderless-regexp  ; search with regex; since simple searches are also valid regex, this is fine
     orderless-flex    ; fuzzy matching
                                        ;basic
     )
   )
  )
;; Orderless:1 ends here

;; Comments
;; In Neovim I originally used [[https://github.com/scrooloose/nerdcommenter][nerdcommenter]], though only a subset of its functionality.
;; However, I found the built-in Emacs functionality for comments lacking, and binding to ~<leader> c c~ did not work how I expected.
;; As such, I use [[https://github.com/redguardtoo/evil-nerd-commenter][evil-nerd-commenter]] as replacement.

;; [[file:config.org::*Comments][Comments:1]]
(use-package evil-nerd-commenter
:bind (
("<leader> c SPC" . evilnc-comment-or-uncomment-lines) ; also works in visual mode

)
  )
;; Comments:1 ends here

;; Programming Languages
;; Brackets, braces, etc. should be automatically completed:

;; [[file:config.org::*Programming Languages][Programming Languages:1]]
(electric-pair-mode 1)
;; Programming Languages:1 ends here

;; Additional Modes
;; Emacs does not ship with a lua mode by default, so I install that.

;; [[file:config.org::*Additional Modes][Additional Modes:1]]
(use-package lua-mode
  :custom
  (lua-indent-level 2)
  )
;; Additional Modes:1 ends here

;; Treesitter
;; First of all, I use ~treesit-auto~ to highlight all languages with treesitter, if possible.
;; This may be removed in Emacs 30, as this is the default there.

;; [[file:config.org::*Treesitter][Treesitter:1]]
(use-package treesit-auto
  :config
  (global-treesit-auto-mode)
  )
;; Treesitter:1 ends here



;; Nix seems to be unsupported by the previous package, so we install ~nix-ts-mode~.
;; However, this requires the nix treesitter grammar, which seems to not work under Arch Linux.
;; Alas, I'll switch to NixOS soon.

;; [[file:config.org::*Treesitter][Treesitter:2]]
(use-package nix-ts-mode
  :mode "\\.nix\\'"
  )
;; Treesitter:2 ends here

;; Completion (company)
;; Completions should be detailed, though I have to test what this actually changes.

;; [[file:config.org::*Completion (company)][Completion (company):1]]
(setq completions-detailed t)
;; Completion (company):1 ends here



;; For autocompletion, I use [[https://company-mode.github.io][company-mode]].
;; I also tried [[https://github.com/minad/corfu][corfu]] but it didn't play well with yasnippet.

;; First, I want suggestions immediately, both in time and in characters.

;; [[file:config.org::*Completion (company)][Completion (company):2]]
(use-package company
  :custom
  (company-idle-delay 0)
  (company-minimum-prefix-length 1)
;; Completion (company):2 ends here



;; Completion should wrap around after the last result.

;; [[file:config.org::*Completion (company)][Completion (company):3]]
(company-selection-wrap-around t)
;; Completion (company):3 ends here



;; There are also some visual improvements here.

;; [[file:config.org::*Completion (company)][Completion (company):4]]
(company-tooltip-align-annotations t)
(company-tooltip-flip-when-above t)
;; Completion (company):4 ends here



;; And completions should not be downcased when using dabbrev, as the capitalization of a word is usually fixed.

;; [[file:config.org::*Completion (company)][Completion (company):5]]
(company-dabbrev-downcase nil)
;; Completion (company):5 ends here



;; Furthermore, backends have to be configured.
;; They are all grouped into a single list, as I want to always get all possible completions.

;; [[file:config.org::*Completion (company)][Completion (company):6]]
(company-backends '((
;; Completion (company):6 ends here



;; The following completions are used.
;; Note that ~:with~ uses backends even if other backends have results and ~:separate~ keeps the order given here.
;; This means that any snippets come first, and then any other completions, e.g. from LSP.
;; - always include snippets

;; [[file:config.org::*Completion (company)][Completion (company):7]]
company-yasnippet
;; Completion (company):7 ends here


;; - "language-aware editing based on source code parsers" -- not needed since we use LSP

;; [[file:config.org::*Completion (company)][Completion (company):8]]
;;;; company-semantic
;; Completion (company):8 ends here


;; - for CMakeLists.txt -- usually not needed

;; [[file:config.org::*Completion (company)][Completion (company):9]]
;;;; company-cmake
;; Completion (company):9 ends here


;; - the completion-at-point-function -- needed for e.g. LSP and always required

;; [[file:config.org::*Completion (company)][Completion (company):10]]
:with company-capf
;; Completion (company):10 ends here


;; - used for Clang -- not needed

;; [[file:config.org::*Completion (company)][Completion (company):11]]
;;;; company-clang
;; Completion (company):11 ends here


;; - for completing relative and absolute files -- I disabled this as it is very slow and locks up Emacs

;; [[file:config.org::*Completion (company)][Completion (company):12]]
;;;; company-files
;; Completion (company):12 ends here


;; - looks for all symbols in the current buffer that aren't in comments or strings -- we use LSP

;; [[file:config.org::*Completion (company)][Completion (company):13]]
;;;; company-dabbrev-code
;; Completion (company):13 ends here


;; - for GNU Global

;; [[file:config.org::*Completion (company)][Completion (company):14]]
;;;; company-gtags
;; Completion (company):14 ends here


;; - for etags -- we use LSP

;; [[file:config.org::*Completion (company)][Completion (company):15]]
;;;; company-etags
;; Completion (company):15 ends here


;; - for programming language keywords -- we use LSP

;; [[file:config.org::*Completion (company)][Completion (company):16]]
;;;; company-keywords
;; Completion (company):16 ends here


;; - for Oddmuse wikis like EmacsWiki -- not needed

;; [[file:config.org::*Completion (company)][Completion (company):17]]
;;;; company-oddmuse
;; Completion (company):17 ends here


;; - completes words typed in the current file

;; [[file:config.org::*Completion (company)][Completion (company):18]]
:with company-dabbrev
;; Completion (company):18 ends here


;; - completes mail addresses and such -- probably doesn't hurt to have even if I don't use email in Emacs

;; [[file:config.org::*Completion (company)][Completion (company):19]]
:with company-bbdb
;; Completion (company):19 ends here


;; - keep any results in /this/ order

;; [[file:config.org::*Completion (company)][Completion (company):20]]
:separate
)))
;; Completion (company):20 ends here



;; Last, we just enable completion everywhere and setup selection of results with ~TAB~.

;; [[file:config.org::*Completion (company)][Completion (company):21]]
:init
(global-company-mode)
(company-tng-configure-default)
)
;; Completion (company):21 ends here



;; I want to see documentation quickly when choosing a completion.
;; For this, I use [[https://github.com/company-mode/company-quickhelp][company-quickhelp]].

;; [[file:config.org::*Completion (company)][Completion (company):22]]
(use-package company-quickhelp
  :init
  (company-quickhelp-mode)
  )
;; Completion (company):22 ends here

;; LSP
;; LSP is very useful for supporting a lot of functionality for many languages.

;; For showing the signature help in a so-called /posframe/, we have to install that package first.

;; [[file:config.org::*LSP][LSP:1]]
(use-package posframe)
;; LSP:1 ends here



;; Then we can configure ~lsp-mode~.
;; Its major prefix is ~<leader> s~ in this case.
;; All language servers should be downloaded by the OS package manager, so disable that functionality.

;; [[file:config.org::*LSP][LSP:2]]
(use-package lsp-mode
  :custom
  (lsp-keymap-prefix "<leader> s")
  (lsp-enable-suggest-server-download nil)
  (lsp-signature-function 'lsp-signature-posframe)

  ;; Python
  (lsp-pylsp-plugins-autopep8-enabled nil)
  (lsp-pylsp-plugins-black-enabled nil)
  (lsp-pylsp-plugins-flake8-enabled t)
  (lsp-pylsp-plugins-flake8-max-line-length 90)
  (lsp-pylsp-plugins-jedi-completion-enabled t)
  (lsp-pylsp-plugins-jedi-definition-enabled t)
  (lsp-pylsp-plugins-jedi-hover-enabled t)
  (lsp-pylsp-plugins-jedi-references-enabled t)
  (lsp-pylsp-plugins-jedi-signature-help-enabled t)
  (lsp-pylsp-plugins-jedi-symbols-enabled t)
  (lsp-pylsp-plugins-mccabe-enabled t)
  (lsp-pylsp-plugins-pyflakes-enabled t)
  :hook (
         (python-ts-mode . lsp)
         (js-ts-mode     . lsp)
         (lua-mode       . lsp)
         (lsp-mode       . lsp-enable-which-key-integration)
         )
  )
;; LSP:2 ends here



;; For a better UI, we install ~lsp-ui~.
;; Though I'm not sure this is activated by default?

;; [[file:config.org::*LSP][LSP:3]]
(use-package lsp-ui
  :commands lsp-ui-mode
  )
;; LSP:3 ends here



;; Last, LSP overrides ~company-backends~ unless ~lsp-completion-provider~ is set to ~:none~:

;; [[file:config.org::*LSP][LSP:4]]
(setq lsp-completion-provider :none)
;; LSP:4 ends here

;; Snippets
;; There are a variety of snippet engines available.
;; I'm using [[][yasnippet]] and the associated [[][collection]] of snippets.
;; https://kristofferbalintona.me/posts/202202270056/

;; [[file:config.org::*Snippets][Snippets:1]]
(use-package yasnippet
  :init
  (yas-global-mode)
  )

(use-package yasnippet-snippets)
;; Snippets:1 ends here

;; LaTeX
;; Even after university I still occasionally write documents using LaTeX.
;; The relevant configuration is from:
;; - [[https://michaelneuper.com/posts/efficient-latex-editing-with-emacs/][Michael Neuper]].
;; - [[https://tex.stackexchange.com/questions/106130/set-up-synctex-with-emacs-docview]]

;; The built-in PDF viewer is a little barebones and doesn't support e.g. synctex.
;; I attempted to replace it with [[https://github.com/vedang/pdf-tools][pdf-tools]].
;; The necessary ~epdfinfo~ server is supplied when installing from NonGNU ELPA or MELPA, but I don't know what happens under NixOS.

;; [[file:config.org::*LaTeX][LaTeX:1]]
(use-package pdf-tools
  :config
  (pdf-tools-install))
;; LaTeX:1 ends here



;; Emacs provides some nice out-of-box options for LaTeX, so the following keybinds are relevant:

;; [[file:config.org::*LaTeX][LaTeX:2]]
(define-key evil-normal-state-map (kbd "<leader> l l") (lambda() (interactive) (save-buffer) (TeX-command-run-all nil)))
(define-key evil-normal-state-map (kbd "<leader> l v") (lambda () (interactive) (save-buffer) (TeX-view)))
(define-key evil-normal-state-map (kbd "<leader> l s") (lambda () (interactive) (save-buffer) (pdf-sync-forward-search)))
;; TODO PDF clean
;; TODO continuous compilation
;; LaTeX:2 ends here



;; Everybody seems to use AUCTeX, so let's install that.

;; [[file:config.org::*LaTeX][LaTeX:3]]
(use-package auctex
  :custom
;; LaTeX:3 ends here



;; There are some interesting options for ~auctex~:

;; [[file:config.org::*LaTeX][LaTeX:4]]
(TeX-auto-save t)
(TeX-parse-self t)
(TeX-save-query nil) ;; obviously we want to compile when I ask it to, and this usually creates files, duh.
(TeX-source-correlate-method '( ;; technically this is the default
                               (dvi . source-specials)
                               (pdf . synctex)
                               ))
(TeX-source-correlate-mode t)
(TeX-view-program-selection '(
                              ((output-dvi has-no-display-manager) "dvi2tty")
                              ((output-dvi style-pstricks) "dvips and gv")
                              (output-dvi "xdvi")
                              (output-pdf "PDF Tools")
                              (output-html "xdg-open")
                              ))
;; LaTeX:4 ends here



;; Additionally, ~LaTeX-math-mode~ offers inserting some characters more easily using ~`~ and ~reftex-mode~ helps with the ToC.

;; [[file:config.org::*LaTeX][LaTeX:5]]
:hook
(LaTeX-mode . LaTeX-math-mode)
(reftex-mode . LaTeX-math-mode)
;; LaTeX:5 ends here


;; I also found that AUCTeX uses a variable-width font for headings and such, which I don't like.

;; [[file:config.org::*LaTeX][LaTeX:6]]
:custom-face
(font-latex-sectioning-5-face
 ((t
   :inherit fixed-pitch
   :foreground ,(alist-get 'yellow catppuccin-mocha-colors)
   )))
)
;; LaTeX:6 ends here



;; [[*Visuals][Similar]] to ~org-mode~, I'd like to see pretty symbols when I'm not in insert mode.

;; [[file:config.org::*LaTeX][LaTeX:7]]
(add-hook 'evil-insert-state-entry-hook (lambda () (prettify-symbols-mode -1)))
(add-hook 'evil-insert-state-exit-hook  (lambda () (prettify-symbols-mode t)))
;; LaTeX:7 ends here

;; Lilypond
;; When having ~lilypond~ installed at the system level, we just have to ~require~ it.

;; [[file:config.org::*Lilypond][Lilypond:1]]
(require 'lilypond-mode)
(add-to-list 'auto-mode-alist '("\\.ly\\'" . LilyPond-mode))
(setq LilyPond-pdf-command "zathura")
;; Lilypond:1 ends here

;; Git
;; Since I use Git quite often, I want to see its highlighting on the left.
;; In Neovim I used [[https://github.com/lewis6991/gitsigns.nvim][gitsigns.nvim]] for that.
;; In Emacs, I use [[https://github.com/dgutov/diff-hl][diff-hl]].

;; [[file:config.org::*Git][Git:1]]
(use-package diff-hl
  :config
  (global-diff-hl-mode)
  )
;; Git:1 ends here

;; Magit
;; Magit is another interesting package for managing git in Emacs.

;; [[file:config.org::*Magit][Magit:1]]
(use-package magit)
;; Magit:1 ends here



;; For integration with ~diff-hl~, we have to add the following hooks:

;; [[file:config.org::*Magit][Magit:2]]
(add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
;; Magit:2 ends here

;; Fonts
;; For some time I tried to use variable-pitch fonts in org-mode.
;; However, this caused visual issues with autocompletion or line numbers.

;; [[file:config.org::*Fonts][Fonts:1]]
; (add-hook 'org-mode-hook 'variable-pitch-mode)
;; Fonts:1 ends here

;; Visuals
;; Let's hide any annoying markup markers first.
;; Also, entities like ~\pi~ should be shown in UTF-8.
;; This may be weird when using subscripts like in ~snake_case~, so we set ~org-use-sub-superscripts~ to ~{}~.
;; Furthermore, we use ~…~ instead of ~...~ for folded headings.

;; [[file:config.org::*Visuals][Visuals:1]]
(setq org-hide-emphasis-markers t)
(setq org-pretty-entities t)
(setq org-use-sub-superscripts "{}")
(setq org-ellipsis "…")
;; Visuals:1 ends here



;; Sometimes I embed images.
;; To be able to set the width if desired, the following has to be set:

;; [[file:config.org::*Visuals][Visuals:2]]
(setq org-image-actual-width nil)
;; Visuals:2 ends here



;; Since editing text with ~org-hide-emphasis-markers~ set to true is harder, we want to disable it in insert mode.
;; While this was supposed to work with ~org-appear~, it did not for me.
;; As such, I just wrote my own hooks.

;; [[file:config.org::*Visuals][Visuals:3]]
(add-hook 'evil-insert-state-entry-hook (lambda () (visible-mode t)))
(add-hook 'evil-insert-state-exit-hook  (lambda () (visible-mode -1)))
;; Visuals:3 ends here



;; Automatically indenting text according to the outline is also useful.

;; [[file:config.org::*Visuals][Visuals:4]]
(setq org-startup-indented t)
;; Visuals:4 ends here



;; Furthermore, we can replace the dashes of lists with dots.
;; While I still use ~org-modern~ below, bullets are not correctly applied in my case.

;; [[file:config.org::*Visuals][Visuals:5]]
(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•")))
                           ))
                        )
;; Visuals:5 ends here



;; Similarly, heading markers can be replaced.
;; I originally used ~org-bullets~ for this, but ~org-superstar-mode~ seems more current.
;; However, ~org-modern~ does all of this and more, so I used that eventually.

;; [[file:config.org::*Visuals][Visuals:6]]
; (use-package org-superstar
;   :config
;   (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
; )
;; Visuals:6 ends here



;; ~org-modern~ is used like so:

;; [[file:config.org::*Visuals][Visuals:7]]
(use-package org-modern
  :config
  (global-org-modern-mode)
  )
;; Visuals:7 ends here

;; Org-Roam
;; [[https://github.com/org-roam/org-roam][Org-roam]] is a way of non-hierarchical note-taking (Zettelkasten).

;; [[file:config.org::*Org-Roam][Org-Roam:1]]
(use-package org-roam
  :custom
  (org-roam-directory (file-truename "~/Documents/Notizen"))
  (org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  :config (org-roam-db-autosync-mode)
  :bind (
         ("<leader> r c" . org-roam-capture)
         ("<leader> r f" . org-roam-node-find)
         )
  )
;; Org-Roam:1 ends here



;; For a visualization of notes similar to Obsidian, I use [[https://github.com/org-roam/org-roam-ui][org-roam-ui]].

;; [[file:config.org::*Org-Roam][Org-Roam:2]]
(use-package org-roam-ui
  :after org-roam
  :custom
  (org-roam-ui-sync-theme t)
  (org-roam-ui-follow t)
  (org-roam-ui-update-on-save t)
  (org-roam-ui-open-on-start t)
  )
;; Org-Roam:2 ends here

;; Org-Download
;; I sometimes want to easily add pictures from the internet to my notes.
;; This can be accomplished with [[https://github.com/abo-abo/org-download][org-download]].

;; [[file:config.org::*Org-Download][Org-Download:1]]
(use-package org-download)
;; Org-Download:1 ends here

;; Which-Key
;; In neovim I used ~folke/which-key.nvim~ which makes finding new functionality easier.
;; A similar package exists for Emacs, which is included in Emacs starting with v30.

;; [[file:config.org::*Which-Key][Which-Key:1]]
(use-package which-key
  :config
  (which-key-mode)
  ;; this does not work with `<leader>`
  (which-key-add-key-based-replacements
    "SPC f"     "Find..."
    "SPC f f"   "file"
    "SPC f p"   "register"
    "SPC f r"   "line (ripgrep)"
    "SPC f s"   "symbols (file)"
    "SPC f S"   "symbols (project)"

    "SPC c"     "Comment..."
    "SPC c SPC" "toggle"

    "SPC l"     "LaTeX..."
    "SPC l l"   "compile"
    "SPC l v"   "view"
    "SPC l s"   "forward search"

    "SPC r"     "Org-Roam..."
    "SPC r c"   "capture"
    "SPC r f"   "find note"

    "SPC s"     "LSP..."
    "SPC s ="     "format..."
    "SPC s = ="     "buffer"
    "SPC s = r"     "region"

    "SPC s F"     "folders..."
    "SPC s F a"     "add"
    "SPC s F b"     "blocklist remove"
    "SPC s F r"     "remove"

    "SPC s G"     "peek..."
    "SPC s G g"     "definitions"
    "SPC s G r"     "references"

    "SPC s T"     "toggle..."
    "SPC s T D"     "modeline diagnostics"
    "SPC s T L"     "trace IO"
    "SPC s T S"     "sideline mode"
    "SPC s T a"     "modeline code actions"
    "SPC s T b"     "breadcrumbs"
    "SPC s T d"     "documentation"
    "SPC s T h"     "symbol highlighting"
    "SPC s T l"     "LSP Lens"
    "SPC s T s"     "automatic signatures"

    "SPC s a"     "LSP x..."
    "SPC s a a"     "lsp-execute-code-action"
    "SPC s a h"     "lsp-document-highlight"
    "SPC s a l"     "lsp-avy-lens"

    "SPC s g"     "goto..."
    "SPC s g g"     "definitions"
    "SPC s g r"     "references"

    "SPC s h"     "quickhelp..."
    "SPC s h g"     "glance documentation"
    "SPC s h h"     "show documentation"
    "SPC s h s"     "type signature"

    "SPC s r"     "refactor..."
    "SPC s r o"     "organize imports"
    "SPC s r r"     "rename"

    "SPC s w"     "LSP..."
    "SPC s w D"     "disconnect"
    "SPC s w d"     "show session information"
    "SPC s w q"     "shutdown"
    "SPC s w r"     "restart"
    "SPC s w s"     "start"

    )
  :custom
  (which-key-prefix-prefix "") ;; unfortunately, one cannot set a suffix like ...
  )
;; Which-Key:1 ends here
