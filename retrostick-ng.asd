(defsystem "retrostick-ng"
  :version "0.1.0"
  :author "Olivier Lemelin"
  :license "Hello"
  :depends-on (#:sdl2 #:sdl2-image #:defclass-std #:log4cl #:log4slime)
  :serial t
  :components ((:module "src"
                :components
                ((:file "defpackage")
                 (:file "utils")
                 (:file "image")
                 (:file "spritesheet")
                 (:file "image-manager")
                 (:file "window")
                 (:file "window-manager")
                 (:file "graphics-engine"))))
  :description "2D Game Engine.")
