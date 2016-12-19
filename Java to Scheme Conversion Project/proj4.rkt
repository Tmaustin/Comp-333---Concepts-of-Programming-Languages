#lang racket
;Jamey Dogom
;Taylor Austin
;Comp 333 - Tue / Thu 8am
;April 20th 2015
(define nextchar "")
(define pos 0)
(define tokenList '())

(define parse
  (lambda (inputstring)
    (reset)
    (set! tokenList (removeSpaces (string->list inputstring)))
    (start)
    )
  )
(define reset
  (lambda ()
    (set! nextchar "")
    (set! pos 0)
    (set! tokenList '())
    )
  )
(define removeSpaces
  (lambda (list)
    (filter (lambda (x) (not (equal? #\space x)))list)
    )
  )

(define syntaxError
  (lambda ()
    (raise-user-error
     "Syntax error at token position: " (- pos 1)
     "with next character: " nextchar)
    )
  )

(define start
  (lambda ()
    (getchar)
    (S)
    )
  )

(define getchar
  (lambda ()
    (cond 
      ((empty? tokenList) error)
      (else (set! nextchar (car tokenList))
            (set! tokenList (cdr tokenList))
            (printf "getChar:  ~a  ~a\n" pos nextchar) 
            (set! pos (+ pos 1))
            )
      )
    )
  )

(define S
  (lambda ()
    (E)
    (match #\$)
    )
  )

(define E
  (lambda ()
    (T)
    (cond 
      ((equal? nextchar #\+)(match #\+)(E))
      ((equal? nextchar #\-)(match #\-)(E))
      )
    )
  )

(define T
  (lambda ()
    (F)
    (cond
      ((equal? nextchar #\*)(match #\*)(T))
      ((equal? nextchar #\/)(match #\/)(T))
      )
    )
  )

(define F
  (lambda ()
    (cond
      ((char-numeric? nextchar)(match nextchar ))
      ((char-alphabetic? nextchar)(match nextchar ))
      ((equal? nextchar #\()(match #\()(E)(match #\)))
      (else (syntaxError))
      )
    )
  )

(define match
  (lambda (item)
    (cond
      ((equal? nextchar item)
       (if (not (equal? nextchar #\$)) (getchar) (void)))
      (else (syntaxError))
      )
    )
  )

