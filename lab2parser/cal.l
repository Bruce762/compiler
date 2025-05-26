%{
#include "y.tab.h"
%}
%option noyywrap
%%
[0-9]+          { yylval = atoi(yytext); return NUMBER; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MULTIPLY; }
"/"             { return DIVIDE; }
"("             { return LPAREN; }
")"             { return RPAREN; }
\n              { return '\n'; }
[ \t]         ;  // 忽略空格和換行
.               { printf("Unexpected character: %s\n\n", yytext); }
%%
