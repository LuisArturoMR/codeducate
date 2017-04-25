#lang racket
(require web-server/servlet
         web-server/servlet-env)
(define (start req)
  (response/xexpr
   `(html (head (title "Hello world!"))
          (body 
                (h1 "Proximamente...")
                (p "Proximamente plataforma de quizes para desarrolladores")))))
 
(serve/servlet start)