
#include <stdio.h>
#include <stdlib.h>

/* Tokens usados pela gramatica G2 */
#define NUM       8
#define SUM       9
#define MINUS    10
#define MULT     11
#define DIV      12
#define OPENCOL  22
#define CLOSECOL 23
#define OPENPAR  26
#define CLOSEPAR 27
#define FIM      30
#define ERR      31

/* Funcoes e variaveis fornecidas pelo Flex */
extern int yylex(void);
extern FILE *yyin;
extern int count_line;

int tok;

/* Le o proximo token do analisador lexico */
void advance(void)
{
    tok = yylex();
}

/* Confere o token esperado e consome-o */
void eat(int esperado)
{
    if (tok == esperado) {
        advance();
    } else {
        printf("Erro sintatico na linha %d: "
               "token inesperado.\n", count_line);
        exit(EXIT_FAILURE);
    }
}

/* Prototipos das funcoes do parser */
void exp(void);
void termo(void);
void fator(void);

/*
 * exp -> termo { soma termo }
 * soma -> + | -
 */
void exp(void)
{
    termo();

    while (tok == SUM || tok == MINUS) {
        eat(tok);
        termo();
    }
}

/*
 * termo -> fator { mult fator }
 * mult -> * | /
 */
void termo(void)
{
    fator();

    while (tok == MULT || tok == DIV) {
        eat(tok);
        fator();
    }
}

/*
 * fator -> ( exp ) | NUM
 */
void fator(void)
{
    switch (tok) {
        case NUM:
            eat(NUM);
            break;

        case OPENPAR:
            eat(OPENPAR);
            exp();
            eat(CLOSEPAR);
            break;

        default:
            printf("Erro sintatico na linha %d: "
                   "esperado NUM ou '('.\n", count_line);
            exit(EXIT_FAILURE);
    }
}

int main(int argc, char *argv[])
{
    if (argc > 2) {
        fprintf(stderr, "Uso: %s [arquivo.txt]\n", argv[0]);
        return EXIT_FAILURE;
    }

    if (argc == 2) {
        yyin = fopen(argv[1], "r");

        if (yyin == NULL) {
            perror("Erro ao abrir arquivo");
            return EXIT_FAILURE;
        }
    }

    advance();
    exp();

    if (tok != FIM) {
        printf("Erro sintatico na linha %d: "
               "tokens sobrando apos a expressao.\n",
               count_line);
        return EXIT_FAILURE;
    }

    printf("Expressao sintaticamente valida!\n");

    return EXIT_SUCCESS;
}
