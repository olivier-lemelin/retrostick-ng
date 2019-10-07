
(in-package :retrostick-ng.graphics-engine)


(defparameter *ticks-per-second* 40)
(defparameter *skip-ticks* (/ 1000 *ticks-per-second*))
(defparameter *max-frameskip* 20)

(defparameter *next-game-tick* (get-current-ticks))

(defparameter *window* nil)

(defparameter *is-game-running* T)
(defparameter *loops* 0)
(defparameter *loop-counter* 0)
(defparameter *loop-counter-ticks* nil)
(defparameter *update-count* 0)

(defmethod set-target-fps ((target number))
  (setf *target-fps* target))

(defun get-current-ticks ()
  (sdl2:get-ticks))

;; FIXME: Temporary function
(defun update-game ()
  nil)

(defun render-game ()
  (sdl2:fill-rect (retrostick-ng.window:get-surface *window*)
                  nil
                  (sdl2:map-rgb (sdl2:surface-format
                                 (retrostick-ng.window:get-surface *window*))
                                0 0 0))
  (retrostick-ng.window:update *window*))

;; FIXME: Make into macro with-timing-loop
(defun timing-process ()
  (setf *loops* 0)
  (loop while (and (> (get-current-ticks) *next-game-tick*)
                   (< *loops* *max-frameskip*))
        do (progn (update-game)
                  (incf *next-game-tick* *skip-ticks*)
                  (incf *loops*)
                  (incf *update-count*)))

  ;; FIXME: Move out of the macro
  (render-game)

  (incf *loop-counter*)
  (let* ((now-ticks (get-current-ticks))
         (last-ticks *loop-counter-ticks*)
         (seconds (/ (- now-ticks last-ticks) 1000))
         (fps (/ *loop-counter* seconds)))
    (if (>= now-ticks (+ last-ticks 1000))
        (progn
          (log:info "~d Frames over ~,2f seconds. (~,2f FPS)" *loop-counter* seconds fps)
          (log:info "~d Updates over ~,2f seconds. (~,2f FPS)" *update-count* seconds fps)
          (setf *loop-counter* 0)
          (setf *update-count* 0)
          (setf *loop-counter-ticks* (get-current-ticks))))))

(defun init-timing (&key (target-fps *default-target-fps*))
  (log:info "Initializing timing module...")
  (setf *target-fps* target-fps)
  (setf *current-time* (sdl2:get-ticks))
  (setf *loop-counter* 0)
  (setf *loop-counter-ticks* (get-current-ticks))
  (log:info "Current Ticks: ~d" *current-time*)
  (log:info "Aiming for ~d FPS." *target-fps*)
  (log:info "Timing Module initialized."))

(defun start ()
  (log:info "Starting Graphics Engine.")
  (setf *is-game-running* T)
  (init-timing)
  (setf *window* (retrostick-ng.window-manager::build-window "Timing test"))
  (loop while *is-game-running*
        do (timing-process))
  (retrostick-ng.window-manager:remove-all-windows))

(defun stop ()
  (setf *is-game-running* nil))

(defun start-thread ()
  (bordeaux-threads:make-thread #'start))
