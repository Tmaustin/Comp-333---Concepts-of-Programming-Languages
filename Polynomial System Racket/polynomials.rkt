#lang racket
;Garett Richardson
;Jamey Dogom
;Taylor Austin
;Comp 333 - 8am TR
;March 16th 2015

(define coeff   ;returns the value of the term t
  (lambda(term)
    (car term)
    )
  )

(define expon   ;returns the exponent of the term t
  (lambda(term)
    (cadr term)
    )
  )

(define printTerm  ;prints the term t in the format value x ^ exponent 
  (lambda(term)
    (cond
      ((equal? (expon term) 0) (display (coeff term)))
      (else (display (coeff term))(display "x^")(display (expon term)))
      )
    )
  )

(define printpoly ;prints the polynomial p using printTerm with a + between the terms
  (lambda(p)
    (cond
      ((equal? (cdr p) '())(printTerm (car p)))
      ((printTerm (car p))(display " + ")(printpoly (cdr p)))
      )
    )
  )

(define evalpoly ;returns the value of polynomial when x = v
  (lambda (p v)
    (cond
      [(equal? (cdr p) '()) (* (coeff (car p)) (expt v (expon (car p))))]
      [else (+ (* (coeff (car p)) (expt v (expon (car p))))(evalpoly (cdr p) v))]
      )
    )
  )

(define GT ;returns true if exponent of t1 > exponent of t2, else false
  (lambda (t1 t2)
    (> (expon t1) (expon t2))
    )
  )

(define EQExp? ;returns true if t1 and t2 have the same exponent, else false
  (lambda (t1 t2)
    (= (expon t1) (expon t2))
    )
  )  


(define simplify ;returns a polynomial equivalent to p which is simplified, in that all terms have different exponents and are listed in decreasing exponent order
  (lambda (p)
    (addEqExp (sort p GT))
    )
  )

(define addEqExp;sums up the tuples where the exponents are equal for a sorted list
  (lambda (p)
    (cond
      [(equal? p '()) '()]
      [(and (equal? (filterNotExp p) '()) (equal? (filterExp p) '()) ) p]
      [else 
       (append (list (addCoeff (filterExp p))) (addEqExp (filterNotExp p)))
       ]
      )
    )
  )
      
(define filterExp;filters out the first set of terms that have reoccurring exponents in a sorted polynomial
  (lambda (p)
    (cond
      [(equal? (length p) 1) p]
      [(equal? p '()) '()]
      [(equal? (expon (car p)) (expon (cadr p)))
       (append (list (car p)) (filterExp (cdr p)))
       ]
      [else (list (car p))]
      )
    )
  )

(define filterNotExp;filters out the set of terms that are not the first set of terms with equal exponents in a  sorted polynomial
  (lambda (p)
    (cond
      [(equal? (cdr p) '()) '()]
      [(equal? p '()) '()]
      [(equal? (expon (car p)) (expon (cadr p)))
       (filterNotExp (cdr p))
       ]
      [else
       (cdr p)
       ]
      )
    )
  )

(define addCoeff;adds all the coeffecients in a polynomial and return a term. This assumes all exponents are equal.
  (lambda (p)
    (cond
      [(equal? p '())]
      [(equal? (length p) 1) (flatten p)]
      [else (list (evalpoly p 1) (expon (car p)))]
      )
    )
  )

(define addpoly
  (lambda (p1 p2)
    (simplify (append p1 p2))
    )
  )

(define subtractpoly;returns a simplified polynomial that is the difference of p1 and p2
  (lambda (p1 p2)
    (simplify (append p1 (multiplytermpoly '(-1 0) p2)))
    )
  )

(define multiplyterms ;returns the product of the terms t1 and t2
  (lambda (t1 t2)
    (list (* (coeff t1) (coeff t2))
          (+ (expon t1) (expon t2)))))

(define multiplytermpoly    ;returns the simplified polynomial that is the product of t1 and p1
  (lambda (t1 p1)
    (simplify (map (lambda (pair) (multiplyterms t1 pair)) p1))))

(define multiplypoly
  (lambda (p1 p2)
    (cond
      [(or (equal? p1 '()) (equal? p2 '())) '()];p1 or p2 are empty, either end of recursion or bad arguments
      [(equal? (length p1) 1) (multiplytermpoly (car p1) p2)];p1 only has one element, no need for recursion
      [else
       (simplify (append (multiplytermpoly (car p1) p2) (multiplypoly (cdr p1) p2)))
       ]
      )
    )
  )