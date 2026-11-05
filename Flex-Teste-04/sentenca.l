%{
#include <stdlib.h>
#include <stdio.h>
#include "parser.tab.h"

int count_line = 1;
%}

%option noyywrap

%x COMMENT

DIGITO [0-9]
LETRA [a-zA-Z]

%%

"/*"            { BEGIN(COMMENT); }
<COMMENT>"*/"   { BEGIN(INITIAL); }
<COMMENT>\n     { count_line++; }
<COMMENT>.      { }
<COMMENT><<EOF>> { fprintf(stderr, "ERRO LÉXICO: /* LINHA: %d\n", count_line); return ERR; }

"if"        { return IF; }
"else"      { return ELSE; }
"int"       { return INT; }
"return"    { return RET; }
"void"      { return VOID; }
"while"     { return WHILE; }

{LETRA}({LETRA}|{DIGITO})*  { return ID; }
{DIGITO}+                   { return NUM; }

"<="        { return MINE; }
">="        { return MAJE; }
"=="        { return EQUAL; }
"!="        { return DIFF; }
"+"         { return SUM; }
"-"         { return MINUS; }
"*"         { return MULT; }
"/"         { return DIV; }
"<"         { return MINOR; }
">"         { return MAJOR; }
"="         { return ATR; }
";"         { return EOL; }
","         { return COMMA; }
"{"         { return OPENCOL; }
"}"         { return CLOSECOL; }
"["         { return OPENKEY; }
"]"         { return CLOSEKEY; }
"("         { return OPENPAR; }
")"         { return CLOSEPAR; }

\r\n        { count_line++; }
\n          { count_line++; }
\r          { count_line++; }
[ \t]+      { }
.           { fprintf(stderr, "ERRO LÉXICO: %s LINHA: %d\n", yytext, count_line); return ERR; }

<<EOF>>     { return FIM; }

%%