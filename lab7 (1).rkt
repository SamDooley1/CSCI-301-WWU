#lang racket


; Helpers pulled from Lab4 and updated based in TA comments
(define (member? x lst)
  (cond ((null? lst) #f) ; empty list must be false
        ((equalNumberSet? x (car lst)) #t) ; if x equals the an item in the list then it must be true
        (else (member? x (cdr lst)) ; recurse through the list to check for
        )
  )
)

(define (equalNumberSet? a b)
  (cond ((and (not (list? a)) (not (list? b)) (= a b))) ; compares if a and b are equal, if not, it moves on
        ((and (list? a) (list? b)) (set-equal? a b)) ; checks if a and b are sets, then calls "set-equal?"
        (else #f) ; if member isnt a number or set, returns false
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

;Reflexive xRx

;Need to delete the pair in L, and have the end condition check if both L and S are null
(define Reflexive?
  (lambda (L S)
    (if (and (null? L) (null? S))
        (not #f)
        (begin
          (if (null? L)
              (not #t)
              (begin
          (if (null? S)
              (not #t)
              (begin
          (if (member (list (car S) (car S)) L)
              (Reflexive? (remove (list (car S) (car S)) L) (cdr S))
              (begin
                (not #t)))))))))))

;Symmetric xRy and yRx
(define Symmetric?
  (lambda (L)
    (if (null? L)
        (not #f)
        (begin
            (if (null? (cdr L))
                    (member? (list (car(cdr(car L))) (car(car L))) L)
                                (begin
          (if (member (list (car(cdr(car L))) (car(car L))) L)
              (Symmetric? (remove* (list (car L) (list (car(car(cdr L))) (car(car L)))) L))
              (begin
                (not #t)))))))))

;Transitive xRy and yRz or xRx and xRx
(define Transitive?
  (lambda (L)
    (if (null? L)
        (not #f)
        (begin
          (cond
          ;if the members of the pair are the same, remove it
            [(eqv? (car(car L)) (car(cdr(car L)))) (Transitive? (remove (list (car(car L)) (car(car L))) L))]
            ;still need a case that handles (a b) (b a) (a a) (b b) and anything like it
            [(and (and (member (list (car(cdr(car L)))  (car(car L))) L) (member (list (car(cdr(car L))) (car(cdr(car L)))) L)) (member (list (car(car L)) (car(car L))) L)) (Transitive? (remove* (list (car L) (list (car(cdr(car L))) (car(cdr(car L))) ) (list (car(car L)) (car(car L)))  (list (car(cdr(car L)))  (car(car L)))) L))]
            ;edit this is supposed to be false
            [(member (list (car(cdr(car L))) (car(car L))) L) (not #t)]
          ;if there is no reverse, try making a pair out of (. x) (. x) and search for that, and find (x .) (. x)
            [(and (member (list (car(cdr(car L))) (car(cdr(car(cdr L))))) L) (member (list (car(car L)) (car(cdr(car(cdr L))))) L)) (Transitive? (remove* (list (car L) (list (car(car L)) (car(cdr(car(cdr L)))) ) (list (car(cdr(car L))) (car(cdr(car(cdr L)))))) L))]
          ;if none of these things work then it isn't transitive
         
            [(zero? 0)(not #t)])))))

(define Reflexive-Closure
  (lambda (L S)
    ;if the array is refelxive we end here
    (if (Reflexive? L S)
        L
        ;find the parts we need to be reflexive
        (begin
          (cond
          ;if the tuple of the first letter in S isnt in L, add it
          [(not (member (list (car S) (car S)) L))(Reflexive-Closure (append L (list(list (car S) (car S)))) S )]
          ;find ab bc andd cc and return
          [(and (member (list (car S) (car (cdr S))) L) (member (list (car (cdr S)) (car(cdr(cdr S)))) L)) (append L (list(list (car(cdr(cdr S))) (car(cdr(cdr S))) )))]

          ;move the stuff at the front of both lists to the end of the list
          [(zero? 0) (Reflexive-Closure (append (remove (car L) L) (list(car L))) (append (remove (car S) S) (list(car S))))]
          )))))
 


(define Symmetric-Closure
  (lambda (L)
    ;if the array is symmetric we end
           (if (Symmetric? L)
               L
               ;otherwise find the things we are missing to be symmetric and add them
               (begin
                 ;Look at the first element in the list, if the counterpart is in, append it to the end
                 (cond
                   [(member (list (car(cdr(car L))) (car(car L))) L) (Symmetric-Closure (append (remove (car L)L) (list(list (car(car L)) (car(cdr(car L)))))))]
                   ;if it is not, append both of them to the end of the list
                   [(zero? 0) (Symmetric-Closure (append (remove (car L) L) (list(list (car(car L)) (car(cdr(car L))) )) (list(list (car(cdr(car L))) (car(car L))) )))]
                   )))))


(define Transitive-Closure
  (lambda (L)
    
    (if (Transitive? L); end when the array is transitive
        L
        (begin
          (cond
            ((member (list (car(cdr(car L)))  (car(car L))) L) (Transitive-Closure (union L (list (list (car(car L)) (car (car L))) (list (car(cdr(car L))) (car(cdr(car L))))))))
            ((zero? 0) (Transitive-Closure (append (remove (car L) L) (list (car L)))); move the first element to the end
           )
         )
   )
)  

(Reflexive-Closure '((a a) (b b) (c c)) '(a b c))
;---> '((a a) (b b) (c c))
(Reflexive-Closure '((a a) (b b)) '(a b c))
;---> '((a a) (b b) (c c))
(Reflexive-Closure '((a a) (a b) (b b) (b c)) '(a b c))
;---> ((a a) (a b) (b b) (b c) (c c))
(Reflexive-Closure '() '(a b c))
;---> '((a a) (b b) (c c))
(Symmetric-Closure '((a a) (a b) (b a) (b c) (c b)))
;---> '((a a) (a b) (b a) (b c) (c b))
(Symmetric-Closure '((a a) (a b) (a c)))
;---> '((a a) (a b) (a c) (b a) (c a))
;(Symmetric-Closure '((a a) (b b)))
;---> '((a a) (b b))
(Symmetric-Closure '())
;---> '()
(Transitive-Closure '((a b) (b c) (a c)))
;---> '((a b) (b c) (a c))
(Transitive-Closure '((a a) (b b) (c c)))
;---> '((a a) (b b) (c c))
;(Transitive-Closure '((a b) (b a)))
;---> '((a b) (b a) (a a) (b b)))
;(Transitive-Closure '((a b) (b a) (a a)))
;---> '((a b) (b a) (a a) (b b))
(Transitive-Closure '((a b) (b a) (a a) (b b)))
;---> '((a b) (b a) (a a) (b b))
(Transitive-Closure '())
;---> '()