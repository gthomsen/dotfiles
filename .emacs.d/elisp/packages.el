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
