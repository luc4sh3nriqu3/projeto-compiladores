%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);

extern int count_line;
extern char *yytext;
extern FILE *yyin;
%}

%token FIM 0
%token IF ELSE INT RET VOID WHILE
%token ID NUM
%token SUM MINUS MULT DIV
%token MINOR MINE MAJOR MAJE EQUAL DIFF ATR
%token EOL COMMA
%token OPENCOL CLOSECOL OPENKEY CLOSEKEY OPENPAR CLOSEPAR
%token OPENCOMMENT CLOSECOMMENT
%token ERR

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%start programa

%%

/* 1 */
programa
    : declaracao_lista
    ;

/* 2 */
declaracao_lista
    : declaracao_lista declaracao
    | declaracao
    ;

/* 3 */
declaracao
    : var_declaracao
    | fun_declaracao
    ;

/* 4 */
var_declaracao
    : tipo_especificador ID EOL
    | tipo_especificador ID OPENKEY NUM CLOSEKEY EOL
    ;

/* 5 */
tipo_especificador
    : INT
    | VOID
    ;

/* 6 */
fun_declaracao
    : tipo_especificador ID OPENPAR params CLOSEPAR composto_decl
    ;

/* 7 */
params
    : param_lista
    | VOID
    ;

/* 8 */
param_lista
    : param_lista COMMA param
    | param
    ;

/* 9 */
param
    : tipo_especificador ID
    | tipo_especificador ID OPENKEY CLOSEKEY
    ;

/* 10 */
composto_decl
    : OPENCOL local_declaracoes statement_lista CLOSECOL
    ;

/* 11 */
local_declaracoes
    : local_declaracoes var_declaracao
    | /* vazio */
    ;

/* 12 */
statement_lista
    : statement_lista statement
    | /* vazio */
    ;

/* 13 */
statement
    : expressao_decl
    | composto_decl
    | selecao_decl
    | iteracao_decl
    | retorno_decl
    ;

/* 14 */
expressao_decl
    : expressao EOL
    | EOL
    ;

/* 15 */
selecao_decl
    : IF OPENPAR expressao CLOSEPAR statement %prec LOWER_THAN_ELSE
    | IF OPENPAR expressao CLOSEPAR statement ELSE statement
    ;

/* PROVISORIO: substituir pelas regras 16 em diante */
iteracao_decl
    : WHILE OPENPAR expressao CLOSEPAR statement
    ;

retorno_decl
    : RET EOL
    | RET expressao EOL
    ;

expressao
    : ID
    | NUM
    ;

%%

void yyerror(const char *s)
{
    if (yychar == ERR)
        return;
    fprintf(stderr, "ERRO SINTÁTICO: %s LINHA: %d\n", yytext, count_line);
}

int main(int argc, char *argv[])
{
    if (argc < 2) {
        printf("Uso: %s entrada.txt\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");

    if (yyin == NULL) {
        perror("Erro ao abrir arquivo de entrada");
        return 1;
    }

    int resultado = yyparse();

    fclose(yyin);

    return resultado;
}