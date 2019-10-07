(defpackage retrostick-ng.utils
  (:use :common-lisp)
  (:export :make-keyword :list-hash-table))

(defpackage retrostick-ng.image
  (:use :common-lisp :defclass-std)
  (:export :image :make-image :destroy :get-dimensions :get-width :get-height :print-object))

(defpackage retrostick-ng.spritesheet
  (:use :common-lisp :defclass-std)
  (:export :spritesheet :make-spritesheet :get-sprite))

(defpackage retrostick-ng.image-manager
  (:use :common-lisp :retrostick-ng.image :retrostick-ng.spritesheet :retrostick-ng.utils)
  (:export :load-image :unload-image :get-image-by-name :get-image-by-path))

(defpackage retrostick-ng.window
  (:use :common-lisp :defclass-std :retrostick-ng.spritesheet)
  (:export :window :print-object :make-window :destroy :resize :move
           :get-surface :get-window :update :blit :blit-window-sprite))

(defpackage retrostick-ng.window-manager
  (:use :common-lisp :retrostick-ng.window)
  (:export :build-window :remove-window :get-screen-by-title :remove-all-windows))

(defpackage retrostick-ng.graphics-engine
  (:use :common-lisp)
  (:export :run))
