%{
//GLC para gerar parser para calculadora simples
#include <stdio.h>
#define YYDEBUG 1    //Para exibir na tela os passos da análise sintática quando o parser é executado
void yyerror(char *);
extern "C"
{
  int yylex(void);
  void abrirArq();
}
%}

%start entrada
%token NUM ERRO FIMLIN

//Para mostrar o valor semântico to token quando for debugar o parser
%printer { fprintf (yyoutput, "’%d’", $$); } NUM

%%

%%

int main()
{
}

void yyerror(char * msg)
{
}

