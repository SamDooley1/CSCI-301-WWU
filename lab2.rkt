#lang racket
#|
(require racket/trace)

(define (mystery L)
  (if (null? L)
      L
      (append (mystery (cdr L))
              (list (car L)))))

;1. the function reverses the contents of a list

(trace mystery)

;2. the updated function seems to trace every
;   iteration of the list between the original
;   and the final reversed one.

 (mystery '(1 2 3))
|#

;Question 1- Genlist funtion
(define (gen-list x y)
    (if (> x y) ;if x>y output an empty set
        '()
        (cons x (gen-list (+ x 1) y);Construct a list of concurent numbers from x to y
        )
    )
)

;Question 2- Sum funtion
(define (sum lst)
  (if (null? lst) 0 ;for empty lists
      (+ (car lst) (sum (cdr lst) ;grabs the first element and then recursively adds the remainder of the list
                   )
      )
  )
)

;Question 3- Retieve First function
(define (retrieve-first-n n lst)
  (cond ((or (< n 1) (null? lst)) '()) ;for empty or negative lists
        (else (cons (car lst) (retrieve-first-n (- n 1) (cdr lst))) ;recursively constructs a list up to the n value of the input list
       )
   )
)

;Question 4- Pair Sum function
(define (pair-sum? lst n)
  (cond ((or (null? lst) (null? (cdr lst))) #f) ;if the list is empty or only has 1 element then it is automatically false
        ((= (+ (car lst) (car(cdr lst))) n) #t) ;checks for adjecent values that add up to the specified sum
        (else (pair-sum? (cdr lst) n)) ;continues through the rest of the list to trigger false if no values add to the specified sum
  ) 
)

;Question 5- Change the Mystery funtion
(define (mystery-tail L)
  (define (acc L result) ;creates the accumulator
    (if (null? L) ;checks if L is empty
        result
        (acc (cdr L) (cons (car L) result)) ;uses the accumulator to reverse the list
    )
  )
  (acc L '()) ;sets the default values for the accumulator
) 
