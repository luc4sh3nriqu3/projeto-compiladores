%{
#include <stdlib.h>
#include <stdio.h>

#define IF 1
#define ELSE 2
#define INT 3
#define RET 4
#define VOID 5
#define WHILE 6
#define ID 7
#define NUM 8
#define SUM 9
#define MINUS 10
#define MULT 11
#define DIV 12
#define MINOR 13
#define MINE 14
#define MAJOR 15
#define MAJE 16
#define EQUAL 17
#define DIFF 18
#define ATR 19
#define EOL 20
#define COMMA 21
#define OPENCOL 22
#define CLOSECOL 23
#define OPENKEY 24
#define CLOSEKEY 25
#define OPENPAR 26
#define CLOSEPAR 27
#define OPENCOMMENT 28
#define CLOSECOMMENT 29
#define FIM 30
#define ERR 31

int count_line = 1;
%}

/* Declaração de um estado exclusivo para comentários */
%x COMMENT

DIGITO [0-9]
LETRA [a-zA-Z]

%%
"/*"            { BEGIN(COMMENT); }           /* Entra no estado de comentário */
<COMMENT>"*/"   { BEGIN(INITIAL); }           /* Sai do estado e volta ao normal */
<COMMENT>\n     { count_line++; }             /* Conta as linhas dentro do comentário */
<COMMENT>.      { /* ignora o resto */ }      /* Ignora outros caracteres no comentário */

"if"        { return IF; }
"else"      { return ELSE; }
"int"       { return INT; }
"return"    { return RET; }
"void"      { return VOID; }
"while"     { return WHILE; }

{LETRA}({LETRA}|{DIGITO})*  { return ID; }
{DIGITO}+                   { return NUM; }

"+"         { return SUM; }
"-"         { return MINUS; }
"*"         { return MULT; }
"/"         { return DIV; }
"<"         { return MINOR; }
"<="        { return MINE; }
">"         { return MAJOR; }
">="        { return MAJE; }
"=="        { return EQUAL; }
"!="        { return DIFF; }
"="         { return ATR; }
";"         { return EOL; }
","         { return COMMA; }
"{"         { return OPENCOL; }
"}"         { return CLOSECOL; }
"["         { return OPENKEY; }
"]"         { return CLOSEKEY; }
"("         { return OPENPAR; }
")"         { return CLOSEPAR; }

\n          { count_line++; }
[ \t]+      { /* ignora espacos */ }
.           { return ERR; }
<<EOF>>     { return FIM; }
%%

int main(int argc, char *argv[])
{
  int token;
  FILE *f_in;

  if (argc == 2)
  {
    if((f_in = fopen(argv[1],"r")))  yyin = f_in;
    else  perror(argv[0]);
  }
  else  yyin = stdin;
  
  /* Removemos os vetores. Agora processamos o token assim que ele é lido */
  while ((token=yylex()) != FIM)
  {
    switch(token)
    {
      case IF: printf("token: IF  line: %d\n", count_line); break;
      case ELSE: printf("token: ELSE  line: %d\n", count_line); break;
      case INT: printf("token: INT  line: %d\n", count_line); break;
      case RET: printf("token: RETURN  line: %d\n", count_line); break;
      case VOID: printf("token: VOID  line: %d\n", count_line); break;
      case WHILE: printf("token: WHILE  line: %d\n", count_line); break;
      case ID: printf("token: ID  line: %d\n", count_line); break;
      case NUM: printf("token: NUM  line: %d\n", count_line); break;
      case SUM: printf("token: SUM  line: %d\n", count_line); break;
      case MINUS: printf("token: MINUS  line: %d\n", count_line); break;
      case MULT: printf("token: MULT  line: %d\n", count_line); break;
      case DIV: printf("token: DIV  line: %d\n", count_line); break;
      case MINOR: printf("token: MINOR  line: %d\n", count_line); break;
      case MINE: printf("token: MINE  line: %d\n", count_line); break;
      case MAJOR: printf("token: MAJOR  line: %d\n", count_line); break;
      case MAJE: printf("token: MAJE  line: %d\n", count_line); break;
      case EQUAL: printf("token: EQUAL  line: %d\n", count_line); break;
      case DIFF: printf("token: DIFF  line: %d\n", count_line); break;
      case ATR: printf("token: ATR  line: %d\n", count_line); break;
      case EOL: printf("token: EOL  line: %d\n", count_line); break;
      case COMMA: printf("token: COMMA  line: %d\n", count_line); break;
      case OPENCOL: printf("token: OPENCOL  line: %d\n", count_line); break;
      case CLOSECOL: printf("token: CLOSECOL  line: %d\n", count_line); break;
      case OPENKEY: printf("token: OPENKEY  line: %d\n", count_line); break;
      case CLOSEKEY: printf("token: CLOSEKEY  line: %d\n", count_line); break;
      case OPENPAR: printf("token: OPENPAR  line: %d\n", count_line); break;
      case CLOSEPAR: printf("token: CLOSEPAR  line: %d\n", count_line); break;
      case OPENCOMMENT: printf("token: OPENCOMMENT  line: %d\n", count_line); break;
      case CLOSECOMMENT: printf("token: CLOSECOMMENT  line: %d\n", count_line); break;
      case ERR: printf("token: ERR  line: %d\n", count_line); break;
    }
  }
  
  return(0);
}