;; probably gonna have a main loop
;; (loop [
;;      ;; where vars I might want to define go
;;      ]
;;      [nil nil]
;;      (print! "hi!"))
(defmacro while-true (&body)
  `(while true (progn ,@body)))
(require :actions)
(define mbuttons :hidden (require :menubuttons))

;; Wrapping globals that urn does not seem to know about/ipod only stuff
(define wrapper
  :hidden
  (require "wrapper"))
(define rb (.> wrapper :rb))
(define _G (.> wrapper :_G))
;; end wrapping

(import lua/string string)


(define _print :hidden
  (require "print"))
((.> _print :clear))
((.> _print :opt :overflow) :auto)

(define mode :mutable nil)
(defun switch-mode (nmode)
  (set! mode (.> _G nmode)))

(define ps (.> rb :lcd_puts))
; stack is just a list. end of the list is the top of the stack
; area is a list with for values: '(x y width height)
;; x and y are the coordinates of the top character
;; units for x,y,w,h are in characters
; note: width limit is 54
(defun print_stack (stack area)
  ; basically, print the list straight down from the top, but start with end - height + 1
  (let* ((x (nth area 1))
         (y (nth area 2))
         (w (nth area 3))
         (h (nth area 4)))
    (with (start (- (+ 1 (n stack)) h))
          (for i start (n stack) 1
               (ps x (- i start) (string/sub (tostring (nth stack i)) 1 w))))))
(defun print_nstack_r (stack area)
  (let* ((x (nth area 1))
         (y (nth area 2))
         (w (nth area 3))
         (h (nth area 4)))
    (with (start (- (+ 1 (n stack)) h))
          (for i start (n stack) 1
               (if (> (string/len (tostring (nth stack i))) w)
                   (ps x (- i start)
                       (string/format (.. "%" w "d") (nth stack i)))
                   (ps x (- i start)
                       (string/format (.. "%1." (- w 7) "e") (nth stack i)))

                   )))))

(define stack :mutable '())
(push! stack 1)
(push! stack 2)
(push! stack 3)
(push! stack 4)
(push! stack 5)
(push! stack 6)
(push! stack 7)
(push! stack 8)
(push! stack 9)
(push! stack 10)

(define home {})
(.<! home (.> mbuttons :LEFT)
     (lambda () ((.> _print :f) :symbol)))
(.<! home (.> mbuttons :RIGHT)
     (lambda () ((.> _print :f) :number)))
(.<! home :draw
     (lambda () (progn
                  (self rb :lcd_clear_display)
                  ;(ps x y msg)
                  (for i 1 15 1 (ps 0 i "│"))
                  (for i 1 15 1 (ps 29 i "│"))
                  (for i 1 15 1 (ps 39 i "│"))
                  (ps 0 0  "┌────────────────────────────┬─────────┐")
                  (ps 0 14 "├────────────────────────────┼─────────┤")
                  (ps 0 16 "└────────────────────────────┴─────────┘")
                  (self rb :lcd_update))))

(set! mode home)

(defun menu ()
  (let* [(options (list->struct '( "cancel" "clear entry" "reset" "quit")))
         (choice (+ 1 ((.> rb :do_menu) "RPN-Ipod menu" options nil false)))
    ]
    (cond
      [(= choice 1) (switch-mode :home)]
      [(= choice 2) nil]
      [(= choice 3) nil]
      [(= choice 4) ((.> (require :os) :exit))])))



(while-true
 (let* [(action ((.> rb :get_plugin_action) -1))]
   (cond
     ((= action (.> mbuttons :EXIT)) ((.> (require :os) :exit)))
     ((= action (.> mbuttons :CANCEL)) (menu))
     ((.> mode action) ((.> mode action)))
     (true nil))
   ((.> mode :draw))))
