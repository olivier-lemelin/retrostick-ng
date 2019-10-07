(in-package :retrostick-ng.image-manager)

(defparameter *graphics-registry* nil)

(defun load-image (path &key (name path))
  ;;TODO: Should check for images with same name / same path first before loading.
  (let ((image (make-image path :name name)))
    (setf *graphics-registry* (cons image *graphics-registry*))
    image))

(defun unload-image (image)
  (remove image *graphics-registry*)
  (destroy image))

(defun get-image-by-name (name)
  (find-if (lambda (x) (string= (name x) name))
           *graphics-registry*))

(defun get-image-by-path (path)
  (find-if (lambda (x) (string= (path x) path))
           *graphics-registry*))
