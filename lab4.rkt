#lang racket

(define (member? x lst)
  (cond ((null? lst) #f) ; empty list must be false
        ((equal? x (car lst)) #t) ; if x equals the an item in the list then it must be true
        (else (member? x (cdr lst)) ; recurse through the list to check for
        )
  )
)

(define (subset? lst1 lst2)
    (cond ((null? lst1) #t) ; if lst1 is an empty list then its a subset of anything
          ((null? lst2) #f) ; if lst2 isnt empty but lst1 is then it cant be a subset
          ((member? (car lst1) lst2) (subset? (cdr lst1) lst2)) ; recursively checks to see if lst1 is in lst2
          (else #f) ; if lst1 isnt in lst2 then it isnt a subset of it.
     )
)

(define (set-equal? lst1 lst2)
  (and (subset? lst1 lst2) (subset? lst2 lst1) ; if they are both subsets of of each other then thay have to be equal
  )
)
