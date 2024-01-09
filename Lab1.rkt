#lang racket

(car '(11 12 13 14)) 
(cdr '(11 12 13 14)) 
(car '(a b c d)) 
(cdr '(a b c d))
(car (quote (11 12 13 14))) 
(cdr (quote (a b c d)))

;TODO 1: car grabs the first item in a list amd cdr grabs the entire list except for the first item

(car '(11 12 13 14)) 
(cdr '(a b c d))

;TODO 2: the quote mark/quote form denotes a litteral item that neds to be output as text

;TODO 3:

(car '(x y z m))
(car (cdr '(y x z m)))
(car (cdr (cdr (cdr '(y z m x)))))
(car (car (cdr '((y)(x)(z)(m)))))
(car (cdr (car (cdr '((y z) (m x))))))

;TODO 4:
(cons 3 '(1 2))
;'(3 1 2)
(cons '(1 5) '(2 3))
;'((1 5) 2 3)

;Cons combines a list and an object

(list 3 '(1 2))
;'(3 (1 2))
(list '(1 5) '(2 3))
;'((1 5) (2 3))

;List creates a list of the arguments you put in

(append '(1) '(2 3))
;'(1 2 3)
(append '(1 5) '(2 3))
;'(1 5 2 3)

;Append combines 2 lists together

(cons 'x '(1 2))
(list 1 2 3 '(4 5))
;(cons '1 '2 '3 '(4 5))
;Too many arguments ^^^

;TODO 5:

(length '(a b c))
;Returns the length of the list
(reverse '(a b c))
;Reverses the order of the list
(member 'a '(a b c))
(member 'b '(a b c))
(member 'c '(a b c))
(member 'd '(a b c))
;Begins output of list from spcified member, returns false if the member is not in the list

;TODO 6:

(if (= 2 3) '(2 equals 3) '(2 does not equal 3))

;TODO 7:

(cond
[(= 20 (* 4 5))
 "foo"
 20
 'first-true-result]
[(= 20 (+ 10 10)) 'second-true-result]
[else 'else-result])
;'first-true-result
;This is given because 20 is equal to 4 * 5. Since this is true it didn't need to evaluate further as it had its answer

;TODO 8:
;double-add.rkt

(define x 10)
(define (add-one x)
 (+ x 1))
(define (double x)
 (* 2 x))
(define (double-add x)
 (double (add-one x)))
;When ran, produces 22

;TODO 9:
(define (triple x)
  (* x 3))


