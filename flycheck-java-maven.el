;;; flycheck-java-maven.el --- Java-Maven support in Flycheck -*- lexical-binding: t; -*-

;; Copyright (c) 2014 Jürgen Hötzel
;;
;; Author: Jürgen Hötzel <juergen@archlinux.org>
;; URL: https://github.com/juergenhoetzel/flycheck-java-maven
;; Keywords: convenience languages tools
;; Version: 0.1
;; Package-Requires: ((flycheck "0.15"))

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

;; Add a Java-Maven checker to Flycheck

;;; Code:

(require 'dash)
(require 'flycheck)

;;; Code:

(flycheck-define-checker java-maven
  "A Maven Java synax checker."
  :command ("mvn" "-f"
	    (eval (-> (locate-dominating-file default-directory  "pom.xml")
		    (file-name-as-directory)
		    (concat "pom.xml")
		    (expand-file-name)))
	    "compile")
  :error-patterns ((error line-start "[ERROR] " (file-name) ":[" line "," column "]"
			  (message) line-end)
		   (warning line-start "[WARNING] " (file-name) ":[" line "," column "]"
			    (message) line-end))
  :predicate (lambda () (and (not (buffer-modified-p)
				  (buffer-file-name))))
  :modes java-mode)

(provide 'flycheck-java-maven)
;;; flycheck-java-maven ends here

