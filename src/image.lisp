(in-package :retrostick-ng.image)

(defclass/std image ()
  ((name)
   (image-ref path :ri)))

(defmethod initialize-instance :after ((image image) &key)
  (with-slots (image-ref path name) image
    (setf image-ref (sdl2-image:load-image path))))

(defun make-image (path &key (name path))
  (make-instance 'image :path path :name name))

(defmethod destroy (obj)
  (sdl2:free-surface (image-ref obj)))

(defmethod get-dimensions (image)
  (with-slots (image-ref) image
    (list (sdl2:surface-width image-ref)
          (sdl2:surface-height image-ref))))

(defmethod get-width (image)
  (with-slots (image-ref) image
    (sdl2:surface-width image-ref)))

(defmethod get-height (image)
  (with-slots (image-ref) image
    (sdl2:surface-height image-ref)))

(defmethod print-object ((obj image) stream)
      (print-unreadable-object (obj stream :type t)
        (with-accessors ((name name)
                         (path path)
                         (image-ref image-ref))
            obj
          (format stream "name: ~a, path: ~a, image-ref: ~a" name path image-ref))))
