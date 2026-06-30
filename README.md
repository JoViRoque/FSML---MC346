# DSL `<FSML - Finite State Machine Language>`

## Descrição Resumida da DSL

>Contextualização da linguagem: Máquinas de Estado são um dos conceitos mais fundamentais, elegantes e subestimados da ciência da computação e da engenharia.
Em termos simples, uma máquina de estado é um modelo matemático que descreve o comportamento de um sistema. Esse sistema só pode estar em um único estado por vez, e muda de estado através de transições disparadas por eventos.


>Motivação: Projetar e validar máquinas de estados à mão é um processo chato e demorado. Por causa disso, essa etapa essencial do planejamento costuma ser ignorada, o que resulta em sistemas mal testados e cheios de falhas na lógica.

>Relevância: A FSML é uma linguagem simples criada dentro do Scheme. A FSML automatiza essa criação diretamente em código de forma simples e rápida. Ela elimina o trabalho manual, permitindo que o desenvolvedor simule e teste o comportamento da máquina instantaneamente.

## Slides

> Coloque aqui o link para o PDF da apresentação final.

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
## Notebook

https://github.com/JoViRoque/FSML---MC346/blob/d344ea4a5337fd7d3aee716724c790955f1bd470/FSML.ipynb

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
## Discussão

> Discussão dos resultados. Relacionar os resultados com a proposta inicial apresentada na introdução.
>
> A discussão dos resultados também pode ser feita opcionalmente na seção de Resultados, na medida em que os resultados são apresentados. Aspectos importantes a serem discutidos: Por que seu modelo alcançou (ou não) um bom resultado? É possível tirar conclusões dos resultados? Quais? Há indicações de direções para estudo? São necessários trabalhos mais profundos?

## Conclusão

> Destacar as principais conclusões obtidas no desenvolvimento do projeto.
>
> Destacar os principais desafios enfrentados.
>
> Principais lições aprendidas.

# Trabalhos Futuros

> O que poderia ser melhorado se houvesse mais tempo?
>
> Quais possíveis desdobramentos este projeto pode ter?

# Referências Bibliográficas

# Referências Bibliográficas

1. Santanchè, André, “Notas de Aula MC346.” 2026.  
2. Bacurau, R. Moreira, “Notas de Aula ES670.” 2026.
3. Dybvig, R. Kent. *The Scheme Programming Language*. 4th Edition. MIT Press, 2009.
4. Free Software Foundation. *GNU Guile Reference Manual*. Disponível em: <https://www.gnu.org/software/guile/manual/>.
5. Notas de Aula da Disciplina de Paradigmas de Programação (Seção: Abstração com Macros e Scheme)
