;; Define package repositories
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
(package-initialize)

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; TODO: this will go, moving to use-package
(defvar my-packages
  '(
    ;; https://github.com/clojure-emacs/clj-refactor.el
    clj-refactor

    ;; https://github.com/clojure-emacs/clojure-mode
    clojure-mode

    ;; extra syntax highlighting for clojure
    clojure-mode-extra-font-locking

    cider))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Setup use-package
;; https://github.com/jwiegley/use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-verbose t)
(setq use-package-always-ensure t)
(require 'use-package)

(use-package auto-package-update)

;; https://github.com/Fuco1/dired-hacks#dired-subtree
(use-package dired-subtree
  :config
  (bind-keys :map dired-mode-map
             ("i" . dired-subtree-insert)
             (";" . dired-subtree-remove)))

;; On OS X, an Emacs instance started from the graphical user
;; interface will have a different environment than a shell in a
;; terminal window, because OS X does not run a shell during the
;; login. This library works around this problem.
;; https://github.com/purcell/exec-path-from-shell
(when (memq window-system '(mac ns))
  (use-package exec-path-from-shell
    :ensure t
    :config
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-envs '("PATH"))))

(use-package magit)

(use-package no-littering)

;; https://depp.brause.cc/nov.el/
(use-package nov
  :config
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

(use-package page-break-lines)
(use-package paredit)
(use-package rainbow-delimiters)
(use-package terraform-mode)
(use-package try)

(add-to-list 'load-path "~/.emacs.d/core")
(load "navigation.el")
(load "ui.el")
(load "editing.el")
(load "misc.el")
(load "elisp-editing.el")
(load "setup-clojure.el")
(load "setup-js.el")
(load "multiple-cursors.el")

;; Dedicated file for Custom AKA Emacs generating custom code automatically
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
