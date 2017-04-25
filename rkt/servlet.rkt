#lang racket
(require parser-tools/lex)

; set a port back one char:
(define (unget port)
  (file-position port (- (file-position port) 1)))

; count spaces:
(define space-count 0)

(define (inc-space!)
  (set! space-count (+ space-count  1)))

(define (reset-spaces!)
  (set! space-count 0))

; a lexer for measuring indentation:
(define indent-lex
  (lexer
    ; end of file:
    [(eof)      (void)]

    ; count the spaces:
    [#\space    (begin
                  (inc-space!)
                  (indent-lex input-port))]

    ; return to normal lexing:
    [any-char   (begin
                  (unget input-port)
                  (display space-count)
                  (reset-spaces!)
                  (lex input-port))]))
     

; a lexer for printing characters:
(define lex
  (lexer
    ; end:
    [(eof)       (void)]

    ; skip newline:
    [#\newline   (begin (newline)
                        (indent-lex input-port))]
   
    ; an actual character:
    [any-char    (begin (display lexeme)
                        (lex input-port))]))

