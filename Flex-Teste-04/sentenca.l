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

%option noyywrap

%x COMMENT

DIGITO [0-9]
LETRA [a-zA-Z]

%%

"/*"            { BEGIN(COMMENT); }
<COMMENT>"*/"   { BEGIN(INITIAL); }
<COMMENT>\n     { count_line++; }
<COMMENT>.      { }
<COMMENT><<EOF>> { return ERR; }

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
.           { return ERR; }

<<EOF>>     { return FIM; }

%%