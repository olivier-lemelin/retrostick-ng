(in-package :retrostick-ng.utils)

(defun make-keyword (name)
  (values (intern (string-upcase name) "KEYWORD")))

(defun list-hash-table (table)
  (maphash #'(lambda (k v) (format t "~a => ~a~%" k v)) table))
