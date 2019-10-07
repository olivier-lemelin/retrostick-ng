(in-package :retrostick-ng.spritesheet)

(defclass/std spritesheet (image)
  ((sprites :r)
   (sprite-width sprite-height :ri)))

(defmethod initialize-instance :after ((spritesheet spritesheet) &key)
  (with-slots (sprites) spritesheet
    (setf sprites (cut-spritesheet spritesheet))))

(defmethod cut-spritesheet ((spritesheet spritesheet))
  (with-slots (sprite-width sprite-height image-ref) spritesheet
    (let* ((sheet-width (get-width spritesheet))
           (sheet-height (get-height spritesheet))
           (nb-sprites-horizontal (1- (floor (/ sheet-width sprite-width))))
           (nb-sprites-vertical (1- (floor (/ sheet-height sprite-height)))))
          (loop for y to nb-sprites-vertical
                collect (loop for x to nb-sprites-horizontal
                              collect (make-instance 'sprite :image image-ref
                                                             :rect (sdl2:make-rect (* sprite-width x)
                                                                                   (* sprite-height y)
                                                                                   sprite-width
                                                                                   sprite-height)))))))

(defun make-spritesheet (path width height &key (name path))
  (make-instance 'spritesheet :path path :name name :sprite-width width :sprite-height height))

(defmethod get-sprite ((spritesheet spritesheet) col row)
  (with-slots (sprites) spritesheet
    (nth col (nth row sprites))))
