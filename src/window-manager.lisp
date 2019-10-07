(in-package :retrostick-ng.window-manager)

(defparameter *screen-registry* nil)

(defun get-screen-by-title (title)
  (find-if (lambda (x) (string= (slot-value x 'title) title))
           *screen-registry*))

(defun build-window (title &key (x :centered) (y :centered) (w 800) (h 600) flags)
  (let ((window (make-window title :x x :y y :w w :h h :flags flags)))
    (setf *screen-registry* (cons window *screen-registry*))
    window))

(defun remove-window (screen)
  (if (member screen *screen-registry*)
      (progn
        (setf *screen-registry* (remove screen *screen-registry*))
        (destroy screen)
        )))

(defun remove-all-windows ()
  (loop while (> (length *screen-registry*) 0)
        do (remove-window (car *screen-registry*))))
