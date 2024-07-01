;; Loads packages that are configured elsewhere.

;; load the following packages everywhere.  these are mandatory and should
;; generate an error if they're not present or cannot be loaded for some reason.
;;
;;   whitespace - highlight errant whitespace
;;   uniquify   - keep buffer names unique as needed
;;   comint     - command interpreters like Make, shell, etc
;;
(require 'whitespace)
(require 'uniquify)
(require 'comint)

;; the following packages should be used when they're present but aren't
;; showstoppers if they're not.
;;
;;   eglot   - interface to Language Server Protocol (LSP) servers to provide
;;             a richer development environment
;;   gptel   - interface to a LLM chatbot
;;   tramp   - work with remote buffers (via SSH, in a container, via sudo) as
;;             if they were local
;;   rmsbolt - code compilation and disassembly like Compiler Explorer
;;
(setq optional-packages-list '('eglot
                               'gptel
                               'rmsbolt
                               'tramp))

;; attempt to load each of the optional packages, ignoring any errors.
;; configuration for these packages are made with with-eval-after-load so we can
;; initialize a working (possibly reduced capability) environment everywhere.
(mapc (lambda (package)
        (ignore-errors
          (eval `(require ,package nil t))))
      optional-packages-list)
