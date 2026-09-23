%{
#include <stdlib.h>
#include <stdio.h>

#define if 1
#define else 2
#define int 3
#define return 4
#define void 5
#define while 6
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
%}

DIGITO [0-9]
LETRA [a-zA-Z]
OUTRO [^0-9a-zA-Z;/=\-"+""*""("")"]

%%
{DIGITO}+			return NUM;
{LETRA}({LETRA}|{DIGITO})*	return ID;
"+"				return SUM;
"-"				return SUB;
"*"				return MUL;
"/"				return DIV;
=				return IGL;
;				return PEV;
"("				return APR;
")"				return FPR;
<<EOF>>                 	return FIM;
\n
\t
[ ]+
{OUTRO}+			return ERR;
%%

int main(int argc, char *argv[])
{
  int token, i, buf[100];
  FILE *f_in;
 
  for (i=0;i<=99;i++) buf[i] = 0;
 

  if (argc == 2)
  {
    if(f_in = fopen(argv[1],"r"))  yyin = f_in;
    else  perror(argv[0]);
  }
  else  yyin = stdin;
  
  i = 0;
  while ((token=yylex())!=FIM)
  {
    buf[i] = token;
    i++;
  }

  i = 0;
  while (buf[i] != 0)
  {
    switch(buf[i])
    {
      case NUM: printf("NUM "); break;
      case ID:  printf("ID ");  break;
      case SOM: printf("+ ");   break;
      case SUB: printf("- ");   break;
      case MUL: printf("* ");   break;
      case DIV: printf("/ ");   break;
      case IGL: printf(" = ");  break;
      case PEV: printf("; \n"); break;
      case APR: printf("( ");   break;
      case FPR: printf(") ");   break;
      case ERR: printf("ERR "); break;
    }
    i++;
  }
  return(0);
}

