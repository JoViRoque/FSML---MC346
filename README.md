# DSL `<FSML - Finite State Machine Language>`

## Descrição Resumida da DSL

>Contextualização da linguagem: Máquinas de Estado são um dos conceitos mais fundamentais, elegantes e subestimados da ciência da computação e da engenharia.
Em termos simples, uma máquina de estado é um modelo matemático que descreve o comportamento de um sistema. Esse sistema só pode estar em um único estado por vez, e muda de estado através de transições disparadas por eventos.


>Motivação: Projetar e validar máquinas de estados à mão é um processo chato e demorado. Por causa disso, essa etapa essencial do planejamento costuma ser ignorada, o que resulta em sistemas mal testados e cheios de falhas na lógica.

>Relevância: A FSML é uma linguagem simples criada dentro do Scheme. A FSML automatiza essa criação diretamente em código de forma simples e rápida. Ela elimina o trabalho manual, permitindo que o desenvolvedor simule e teste o comportamento da máquina instantaneamente.

## Slides

https://github.com/JoViRoque/FSML---MC346/blob/a891226f5b1a0747748d1331f21223b00e55ac45/Apresenta%C3%A7%C3%A3o%20FSML.pdf

---

## Sintaxe da Linguagem

A FSML é uma linguagem declarativa que se divide em duas partes: o bloco estrutural de **Definição** e os comandos de **Operação (API)**.

### 1. Bloco de Definição (`definir-maquina`)
Cria uma nova instância de máquina de estados. A sintaxe exige que você liste os estados válidos e as regras de transição usando as palavras-chave exclusivas `PARA` e `COM`. 
* **Nota:** Por padrão, o primeiro estado listado no bloco `(estados ...)` torna-se o ponto de partida inicial da máquina.

```scheme
(definir-maquina <nome-da-maquina>
  (estados <estado_1> <estado_2> ... <estado_n>)
  (transicoes
    (<estado-origem> PARA <estado-destino> COM <evento>)
    ...))
```

---

## Gramática da Linguagem

A gramática da FSML foi modelada utilizando o formalismo **EBNF (Extended Backus-Naur Form)**. Escolheu-se essa abordagem pela clareza acadêmica e por sua perfeita adequação a linguagens homoicônicas, como o Scheme, onde a sintaxe textual mapeia diretamente a árvore de sintaxe abstrata através de S-expressions.

```ebnf
(* Regra Principal - Definição da DSL *)
DeclaracaoMaquina ::= '(' 'definir-maquina' Identificador BlocoEstados BlocoTransicoes ')'

(* Blocos Estruturais *)
BlocoEstados      ::= '(' 'estados' Identificador { Identificador } ')'
BlocoTransicoes   ::= '(' 'transicoes' { RegraTransicao } ')'
RegraTransicao    ::= '(' Identificador 'PARA' Identificador 'COM' Identificador ')'

(* Funções de Operação (API da Linguagem) *)
ComandoExpressao  ::= CmdEstadoAtual | CmdPasso | CmdInvestigar | CmdResetar | CmdDefInício

CmdEstadoAtual    ::= '(' 'estado-atual' Identificador ')'
CmdPasso          ::= '(' 'passo' Identificador LiteralSimbolo ')'
CmdInvestigar     ::= '(' 'investigar' Identificador LiteralSimbolo LiteralSimbolo ')'
CmdResetar        ::= '(' 'resetar' Identificador ')'
CmdDefInício      ::= '(' 'definir-inicio' Identificador LiteralSimbolo ')'

(* Elementos Léxicos *)
LiteralSimbolo    ::= "'" Identificador
Identificador     ::= Letra { Letra | Digito | '_' | '-' }
Letra             ::= [a-zA-Z]
Digito            ::= [0-9]
```

---

## Notebook

https://github.com/JoViRoque/FSML---MC346/blob/d344ea4a5337fd7d3aee716724c790955f1bd470/FSML.ipynb

---

## Exemplos Selecionados

Como caso de uso principal, modelou-se o **Ciclo de Vida de uma Tarefa em um Sistema Operacional de Tempo Real (RTOS)**. O autômato possui os estados `ready` (pronto), `running` (em execução) e `blocked` (bloqueado por recurso).

### Código de Inicialização da Máquina
```scheme
(definir-maquina tarefa-so
  (estados ready running blocked)
  (transicoes
    (ready   PARA running COM obter_prioridade)
    (running PARA ready   COM perder_prioridade)
    (running PARA blocked COM aguardar_recurso)
    (blocked PARA ready   COM desbloqueio_normal)
    (blocked PARA running COM desbloqueio_prioritario)))
```

---

## Discussão

A implementação da FSML provou que a ideia central de um autômato pode ser devidamente representada em uma DSL, aproveitando conceitos poderosos do paradigma funcional como **Macros Higiênicos (`syntax-rules`)** e **Closures**. No entanto, essa jornada trouxe desafios sintáticos claros. A natureza da linguagem Scheme exige uma adaptação à sua estrutura rigorosa e, inevitavelmente, ao uso massivo de parênteses encadeados `( ... )`, o que pode tornar a leitura inicial um pouco intimidadora para quem está acostumado com linguagens imperativas tradicionais.
A FSML demonstra que, para resolver problemas específicos, **às vezes a simplicidade é muito mais importante do que a robustez excessiva**. Em vez de inflar o sistema com estruturas de objetos redundantes, uma DSL simples e direta resolve o problema de forma limpa.

---

## Conclusão

Para fins práticos e didáticos, o desenvolvimento deste projeto foi extremamente interessante e enriquecedor. Ele me forçou a sair da zona de conforto da POO e a enxergar como os paradigmas funcional e sintático podem trabalhar juntos.

* **Principais Desafios:** A adaptação ao ecossistema do Scheme e a gestão visual de seus múltiplos parênteses.
* **Lições Aprendidas:** Nem sempre a complexidade de uma linguagem ou framework é algo positivo. Forçar um paradigma (como POO) a resolver problemas que se alinham melhor com abordagens declarativas gera códigos inchados. Aprendemos que limitar o escopo e focar em uma sintaxe minimalista entrega uma solução mais elegante.

---

# Trabalhos Futuros

Se houvesse mais tempo para o desenvolvimento da FSML, o foco total seria sair do escopo puramente textual e partir para a **visualização gráfica**:

1. **Interface Visual Interativa:** A nossa real intenção para o futuro do projeto seria criar uma camada visual (uma GUI ou aplicação web) onde o usuário pudesse desenhar os estados e transições na tela, gerando o código Scheme por trás, ou vice-versa. Máquinas de estados fazem muito mais sentido quando podemos **visualizá-las graficamente**.

---
# Referências Bibliográficas

1. Santanchè, André, “Notas de Aula MC346.” 2026.  
2. Bacurau, R. Moreira, “Notas de Aula ES670.” 2026.
3. Dybvig, R. Kent. *The Scheme Programming Language*. 4th Edition. MIT Press, 2009.
4. Free Software Foundation. *GNU Guile Reference Manual*. Disponível em: <https://www.gnu.org/software/guile/manual/>.
5. Notas de Aula da Disciplina de Paradigmas de Programação (Seção: Abstração com Macros e Scheme)
