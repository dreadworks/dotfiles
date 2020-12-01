;; -*- coding: utf-8 -*-

;; DEFAULT MODES
;; --------------------
(auto-fill-mode t)
(column-number-mode t)
(show-paren-mode t)
(ido-mode t)
(ido-vertical-mode t)


;; GENERAL
;; --------------------
(fset 'yes-or-no-p 'y-or-n-p)
(setq visible-bell nil)
(setq inhibit-splash-screen t)
(setq calendar-week-start-day 1)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq explicit-shell-file-name "/bin/bash")
(setq tramp-default-method "sshx")
(setq magit-last-seen-setup-instructions "1.4.0")
(setq ispell-program-name (executable-find "hunspell") ispell-dictionary "en_GB")

(setq-default show-trailing-whitespace t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default truncate-lines t)

;; disable line numbers for some modes
(dolist (mode
         '(org-mode-hook
           term-mode-hook
           shell-mode-hook))
  (add-hook mode (lambda () display-line-numbers 0)))

;; disable auto-fill-mode from some modes
(dolist (mode
         '(latex-mode-hook
           org-mode-hook))
  (add-hook mode (lambda () (auto-fill-mode 0))))

;; HELM
;; --------------------
(require 'helm-config)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)

;; ORG
;; --------------------
(when (display-graphic-p)
  (setq org-ellipsis " ▼")
  (require 'org-bullets)
  (setq org-bullets-bullet-list '("●" "●" "○" "○" "▫"))
  (add-hook 'org-mode-hook 'org-bullets-mode))

(add-hook 'org-mode-hook 'org-indent-mode)

;; EDIT SERVER
;; --------------------
(when (require 'edit-server nil :noerror)
  (setq edit-server-new-frame nil)  ;; do not open a new window
  (edit-server-start))
(add-hook 'edit-server-start-hook 'markdown-mode)

;; MULTIPLE CURSORS
;; --------------------
(require 'multiple-cursors)
(global-set-key (kbd "C-x n") 'mc/mark-next-like-this)

;; YASNIPPETS
;; --------------------
(require 'yasnippet)
(yas-global-mode t)

;; FLYSPELL
;; --------------------
(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word))

(global-set-key (kbd "C-c J") 'flyspell-buffer)
(global-set-key (kbd "C-c j") 'flyspell-check-next-highlighted-word)

;; MISC
;; --------------------
(global-set-key (kbd "C-x g") 'magit-status)
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)


;; PYTHON
;; --------------------
;;
;;   python programming
;;
(setq python-basic-offset 2)
(put 'dired-find-alternate-file 'disabled nil)

;; put this in your local .emacs
;; (custom-set-variables
;;  '(conda-anaconda-home
;;    (expand-file-name '~/Complex/conda')))

;; legacy:
;; use conda for pyvenv
;; -- this is not working, as conda overwrites its own CONDA_PREFIX
;; -- as soon as an environment is activated. It seems like there
;; -- is no canonical way to access the conda base directory... (wtf)
;; (setenv "WORKON_HOME" (concat (getenv "CONDA_PREFIX") "/envs"))
;; (pyvenv-mode 1)

(require 'python)
(elpy-enable)

(setq blacken-line-length 79)
(add-hook 'python-mode-hook 'blacken-mode)

;; use ipython as python shell
(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args "--simple-prompt -i"
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")
