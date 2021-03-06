%{
#include <stdio.h>

/* Bisonが書きだすヘッダファイル名 */
#include "SampleCalc.tab.h"

#define YY_SKIP_YYWRAP 1

int
yywrap(void)
{
    return 1;
}
%}
%%
"+"     return ADD;
"-"     return SUB;
"*"     return MUL;
"/"     return DIV;
"%"     return MOD;
"**"    return EXPONENT;
"\n"    return CR;
[1-9][0-9]* {
    double temp;
    sscanf(yytext, "%lf", &temp);
    yylval.double_value = temp;
    return DOUBLE_LITERAL;
}
[0-9]*\.[0-9]* {
    double temp;
    sscanf(yytext, "%lf", &temp);
    yylval.double_value = temp;
    return DOUBLE_LITERAL;
}
[ \t] ;
%%