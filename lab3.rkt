#lang racket

;Q1
(define (member? x lst)
  (cond ((null? lst) #f) ; empty list must be false
        ((equal? x (car lst)) #t) ; if x equals the an item in the list then it must be true
        (else (member? x (cdr lst)) ; recurse through the list to check for
        )
  )
)

;Q2
(define (subset? lst1 lst2)
    (cond ((null? lst1) #t) ; if lst1 is an empty list then its a subset of anything
          ((null? lst2) #f) ; if lst2 isnt empty but lst1 is then it cant be a subset
          ((member? (car lst1) lst2) (subset? (cdr lst1) lst2)) ; recursively checks to see if lst1 is in lst2
          (else #f) ; if lst1 isnt in lst2 then it isnt a subset of it.
     )
)

;Q3
(define (set-equal? lst1 lst2)
  (and (subset? lst1 lst2) (subset? lst2 lst1) ; if they are both subsets of of each other then thay have to be equal
  )
)

;Q4
(define (union S1 S2)
  (cond ((null? S1) S2) ; if nothing in set 1 then just output what ever is in set 2
        ((member? (car S1) S2) ; determines if an item in set 1 is in set 2
        (union (cdr S1) S2)) ; if an element is in set 1 and set 2  it calls union again an moves on to remove duplicates
        (else (union (cdr S1) (cons (car S1) S2)) ; adds elements of set 1 to set 2 if they arent already there
        )
  )
) 

(define (intersect S1 S2)
  (cond ((null? S1) '()) ; if the first set is empty then there cant be any elemnts that are shared between them
        ((member? (car S1) S2) ; determines if an item in set 1 is in set 2
        (cons (car S1) (intersect (cdr S1) S2))) ; if the sets share an element then it adds it to the list and recursively calls intersect again
        (else(intersect (cdr S1) S2) ; 
        )
  )
)