;; probably gonna have a main loop
;; (loop [
;;      ;; where vars I might want to define go
;;      ]
;;      [nil nil]
;;      (print! "hi!"))
(defmacro while-true (&body)
  `(while true (progn ,@body)))
(require :actions)

;; Wrapping globals that urn does not seem to know about/ipod only stuff
(define wrapper
  :hidden
  (require "wrapper"))
(define rb (.> wrapper :rb))
(define _G (.> wrapper :_G))
;; end wrapping


(define _print :hidden
  (require "print"))
(define home {})
(.<! home (.> (.> rb :actions) :PLA_UP)
     (lambda () ((.> _print :f) :menu)))


(define mode :mutable home)
(defun switch-mode (nmode)
  (set! mode (.> _G nmode)))

(while-true
 (let* [(action ((.> rb :get_plugin_action) -1))]
   (cond
     ((= action (.> (.> rb :actions) :PLA_EXIT)) ((.> (require :os) :exit)))
     (true ((.> mode action))))))
