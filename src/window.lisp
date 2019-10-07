(in-package :retrostick-ng.window)

(defclass/std window ()
  ((x y w h flags title :ri)
   (window-ref :r)))

(defmethod initialize-instance :after ((window window) &key)
  (with-slots (title x y w h flags window-ref) window
    (setf window-ref (sdl2:create-window :title title :x x :y y :w w :h h :flags flags))))

(defmethod print-object ((obj window) stream)
      (print-unreadable-object (obj stream :type t)
        (with-accessors ((title title)
                         (x x)
                         (y y)
                         (w w)
                         (h h)
                         (flags flags)
                         (window-ref window-ref))
            obj
          (format stream "title: ~a, x: ~a, y: ~a, w: ~a, h: ~a, flags: ~a, window-ref: ~a" title x y w h flags window-ref))))

(defun make-window (title &key (x :centered) (y :centered) (w 800) (h 600) flags)
  (make-instance 'window :title title :x x :y y :w w :h h :flags flags))

(defmethod destroy ((window window))
  (sdl2:destroy-window (slot-value window 'window-ref)))

(defun (setf title) (new-title window)
  (with-slots (title window-ref) window
    (setf title new-title)
    (sdl2:set-window-title window-ref new-title)))

(defmethod resize ((window window) new-w new-h)
  (with-slots (w h window-ref) window
    (setf w new-w)
    (setf h new-h)
    (sdl2:set-window-size window-ref new-w new-h)))

(defmethod move ((window window) new-x new-y)
  (with-slots (x y window-ref) window
    (setf x new-x)
    (setf y new-y)
    (sdl2:set-window-position window-ref new-x new-y)))


(defmethod get-surface ((window window))
  (with-slots (window-ref) window
    (sdl2:get-window-surface window-ref)))


(defmethod get-window ((window window))
  (with-slots (window-ref) window
    window-ref))

(defmethod update ((window window))
  (with-slots (window-ref) window
    (sdl2:update-window window-ref)))

(defmethod blit ((target window) source &key (target-rect nil) (source-rect nil))
  (sdl2:blit-surface source source-rect (get-surface target) target-rect))

(defmethod blit-window-sprite ((target window) (source spritesheet) (source-rect sdl2-ffi:sdl-rect) &key (target-rect nil))
  (sdl2:blit-surface (image-ref source) source-rect (get-surface target) target-rect))
