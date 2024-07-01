;; User configuration file for Emacs.  Targets C/Matlab/Python/Fortran/shell
;; development in terminals.
;;
;; NOTE: This targets Emacs 25.2 and newer and should work with any OS that
;;       came out after April 2017.
;;

(let ((minver "25.2"))
  (when (version<= emacs-version minver)
    (error "Your Emacs is too old -- this config requires v%s or higher." minver)))

;; pull in any site-local configuration that needs to occur before ours.
(let ((site-file "~/.emacs.d/site.el"))
  (when (file-readable-p site-file)
    (load-file site-file)))

;; use MELPA stable for our upstream package archive.
(require 'package)
(add-to-list 'package-archives
  '("melpa-stable" . "http://stable.melpa.org/packages/") t)

;; explicitly initialize the package package so older versions of Emacs (25.2
;; does it) don't cause this to be inserted at the top of the file.
(package-initialize)

;; specify where our code and packages live.  these are all packages that
;; don't have packages in MELPA.
;;
;; NOTE: only the contents of the directories listed here are searched.
;;       load-path is not processed recursively.
;;
(setq user-paths '("~/.emacs.d/elisp"
                   "~/.emacs.d/elisp/align-f90"
                   "~/.emacs.d/elisp/matlab"))

;; add all of the user paths to the front of the search and the compatibility
;; paths to the back.  this should keep them properly shadowed when loaded on
;; systems where they're already implemented.
(mapcar (lambda (arg)
      (add-to-list 'load-path arg))
      user-paths)

;; some aspects of the configuration are influenced by the following top-level
;; parameters.

;; specify whether we use matlab.el from SourceForge or octave-mode.  by
;; default we use what is distributed with Emacs.
(setq matlab-mode-p nil)

;; the configuration is broken down into the following categories for
;; ease of maintenance.
(load-library "packages")
(load-library "functions")
(load-library "modes")
(load-library "keys")
(load-library "style")

;; save every four lines or so.
(setq auto-save-interval 300)

;; always edit the target of a symlink rather than the symlink itself.
(add-hook 'find-file-hooks 'visit-target-instead)

;; fire up a server that clients can connect to.  if we've been given a better
;; server name, use it.
(let ((user-server-name (getenv "EMACS_SERVER")))
  (when user-server-name
    (setq server-name user-server-name)))
(server-start)

;; show the time in the mode line.  we do this absolutely last as an easy
;; indicator that our configuration loaded properly.
(setq display-time-day-and-date t)
(display-time)
