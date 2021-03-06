grammar estudolSemRec;

//regras que começam com letra minúscula são as regras de parser

inicio: PROGRAMA ID corpo 
        ;
corpo:  AbreChave secaoVariaveis listaComandos  FechaChave
        ; 


secaoVariaveis: VARS Doispontos  listDecVariavel  PVirg
                ;


//sem recursao
listDecVariavel:    varDec listDecVariavel1
		;
listDecVariavel1:   VIRG varDec listDecVariavel1
		        |   //ε
                        ;



varDec: tipos ID;

tipos: TipotInt | TipoReal | TipoChar
            ;

bloco:  AbreChave listaComandos FechaChave      
        ;



// sem recursão 

listaComandos:  command listaComandos1
                ;

listaComandos1:  command listaComandos1
                |  //ε
                ;

command:    singleCmd PVirg 
            | stmt
            ;

singleCmd:  ID OPAtrib cexpr
            ;

stmt:   SE AbreParentese cexpr FechaParentese bloco
        | SE AbreParentese cexpr FechaParentese bloco SENAO bloco
        | ENQUANTO AbreParentese cexpr FechaParentese bloco
        | FACA  bloco  ENQUANTO cexpr
        ;

//modificado sem recursão
cexpr:   expr cexpr1
        |expr OPIgual expr cexpr1
        |expr OPMaior expr cexpr1
        |expr OPMenor expr cexpr1
        ;

cexpr1:  OPAnd cexpr cexpr1
        |OPOr cexpr cexpr1
        |  //ε
        ;

//sem recursão:
expr:   AbreParentese cexpr FechaParentese expr1
				|ID expr1
				|INT expr1
				|CHAR expr1 
				|FLOAT expr1
				;

expr1:  OPMais expr expr1
				|OPMenos expr expr1
				|OPDiv expr expr1
				|OPMult expr expr1
				|  //ε
				;



//regras que começam com letra maiúscula são regras do lexer
INT: [0-9]+;
DIGIT: [0-9];
FLOAT: DIGIT+  DIGIT*;
DOT: '.';
ID: [a-z][a-zA-Z0-9]*;
CHAR: '\''([0-9A-Za-z]|'\\'([a-f]|[0-9]|[1-9][0-9]|'1'[0-2][0-7]))'\'';
AbreChave: '{';
FechaChave : '}';
AbreParentese: '(';
FechaParentese: ')';
PROGRAMA: 'PROGRAMA';
VARS: 'VARS';
Doispontos: ':';
TipotInt : 'INT';
TipoReal: 'REAL';
TipoChar: 'CHAR';
PVirg:  ';';
OPAtrib: ':=';
SE: 'SE';
SENAO: 'SENAO';
ENQUANTO: 'ENQUANTO';
FACA: 'FACA';
VIRG: ',';
OPAnd: 'AND';
OPOr: 'OR';
OPMaior: '>';
OPMenor: '<';
OPIgual: '==';
OPMais: '+';
OPDiv: '/';
OPMenos: '-';
OPMult: '*';
WS: [ \t\r\n]+ -> skip;