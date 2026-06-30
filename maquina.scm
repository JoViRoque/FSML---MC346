;; ========================================================
;; ARQUIVO: maquina.scm
;; Interpretador FSML e Teste de Tarefa de Sistema Operacional
;; ========================================================

;; --- 1. MOTOR DA MÁQUINA ---
(define (encontrar-transicao estado evento transicoes)
  (cond ((null? transicoes) #f)
        ((and (eq? (caar transicoes) estado)
              (eq? (cadar transicoes) evento))
         (car transicoes))
        (else (encontrar-transicao estado evento (cdr transicoes)))))

(define (criar-maquina lista-estados lista-transicoes)
  (let* ((estado-inicial (car lista-estados))
         (estado-atual-val estado-inicial))
    (lambda (mensagem . argumentos)
      (cond
        [(eq? mensagem 'estado-atual) estado-atual-val]
        [(eq? mensagem 'definir-inicio)
         (set! estado-inicial (car argumentos))
         (set! estado-atual-val estado-inicial)
         estado-inicial]
        [(eq? mensagem 'resetar)
         (set! estado-atual-val estado-inicial)
         estado-atual-val]
        [(eq? mensagem 'passo)
         (let* ((evento (car argumentos))
                (trans (encontrar-transicao estado-atual-val evento lista-transicoes)))
           (if trans
               (begin (set! estado-atual-val (caddr trans)) estado-atual-val)
               "Erro: Transicao invalida!"))]
        [(eq? mensagem 'investigar)
         (let* ((estado-teste (car argumentos))
                (evento-teste (cadr argumentos))
                (trans (encontrar-transicao estado-teste evento-teste lista-transicoes)))
           (if trans
               (caddr trans)
               "Erro: Transicao nao encontrada!"))]))))

;; --- 2. WRAPPERS (COMANDOS) ---
(define (estado-atual maquina) (maquina 'estado-atual))
(define (definir-inicio maquina estado) (maquina 'definir-inicio estado))
(define (resetar maquina) (maquina 'resetar))
(define (passo maquina evento) (maquina 'passo evento))
(define (investigar maquina estado evento) (maquina 'investigar estado evento))

;; --- 3. MACRO DA SINTAXE FSML ---
(define-syntax definir-maquina
  (syntax-rules (estados transicoes PARA COM)
    [(_ nome-da-maquina
        (estados estado ...)
        (transicoes (origem PARA destino COM evento) ...))
     (define nome-da-maquina
       (criar-maquina '(estado ...) 
                      '((origem evento destino) ...)))]))

