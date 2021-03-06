%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define YYDEBUG 1

extern int yylex(void);

int
yyerror(char const *str)
{
    extern char *yytext;
    fprintf(stderr, "parser error near %s\n", yytext);
    return 0;
}

%}
%union {
    int     int_value;
    double  double_value;
}
%token <double_value>    DOUBLE_LITERAL
%token ADD SUB MUL DIV MOD EXPONENT CR
%type <double_value> expression term primary_expression
%%
line_list
    : line
    | line_list line
    ;
line
    : expression CR
    {
        printf(">>%lf\n", $1);
    }
expression
    : term
    | expression ADD term
    {
        $$ = $1 + $3;
    }
    | expression SUB term
    {
        $$ = $1 - $3;
    }
    ;
term
    : primary_expression
    | term MUL primary_expression 
    {
        $$ = $1 * $3;
    }
    | term DIV primary_expression
    {
        $$ = $1 / $3;
    }
    | term MOD primary_expression
    {
        $$ = ((int)$1) % ((int)$3);
    }
    | term EXPONENT primary_expression
    {
        $$ = pow($1,$3);
    }
    ;
primary_expression
    : DOUBLE_LITERAL
    ;
%%


int main(void)
{
    extern int yyparse(void);
    extern FILE *yyin;

    yyin = stdin;
    if (yyparse()) {
        fprintf(stderr, "Parse Error\n");
        exit(1);
    }
}