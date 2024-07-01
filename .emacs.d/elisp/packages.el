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
;;   gptel   - interface to a LLM chatbot
;;   tramp   - work with remote buffers (via SSH, in a container, via sudo) as
;;             if they were local
;;
(setq optional-packages-list '('gptel
                               'tramp))

;; attempt to load each of the optional packages, ignoring any errors.
;; configuration for these packages are made with with-eval-after-load so we can
;; initialize a working (possibly reduced capability) environment everywhere.
(mapc (lambda (package)
        (ignore-errors
          (eval `(require ,package nil t))))
      optional-packages-list)
