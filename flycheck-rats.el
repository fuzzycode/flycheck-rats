;;; flycheck-rats.el --- Integrate RATS with flycheck

;; Copyright (c) 2019 Björn Larsson

;; Author: Björn Larsson <develop@bjornlarsson.net>
;; Maintainer: Björn Larsson <develop@bjornlarsson.net>
;; URL: https://github.com/fuzzycode/flycheck-rats
;; Version: 0.1
;; Package-Requires: ((flycheck "0.24") (emacs "24.4"))

;; This file is not part of GNU Emacs.

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

;;;; Setup

;;; Code:
(require 'cl-lib)
(require 'flycheck)

(flycheck-define-checker rats
  "A checker using RATS from CERN

See `https://github.com/fuzzycode/flycheck-rats' for more details."

  :command ("rats"
            "--noheader"
            "--nofooter"
            "--resultsonly"
            "--quiet"
            "--columns"
            source-inplace)
  :error-patterns ((info line-start (file-name) ":" line "[" column "]" ": low: " (message) line-end)
                   (warning line-start (file-name) ":" line "[" column "]" ": medium: " (message) line-end)
                   (error line-start (file-name) ":" line "[" column "]" ": high: " (message) line-end))
  :modes (c-mode c++-mode perl-mode php-mode python-mode)
  )

;;;###autoload
(defun flycheck-rats-setup ()
  "Setup flycheck-rats.

Add `rats' to `flycheck-checkers'."

  (interactive)
  (add-to-list 'flycheck-checkers 'rats t))

(provide 'flycheck-rats)

;;; flycheck-rats.el ends here
