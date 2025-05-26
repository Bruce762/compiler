%{
#include <stdio.h>
#include <string.h>

int int_count = 0;
int float_count = 0;
int id_count = 0;
int error_count = 0;
%}
%option noyywrap
%%

[a-zA-Z][a-zA-Z0-9_]*     { printf("Identifier(ID) : %s\n", yytext); id_count++; }
[a-zA-Z][a-zA-Z0-9_]*[^\x00-\x1Fa-zA-Z0-9_\n]+.* {printf("Error : %s\n", yytext);error_count++;/*只要不符合上述就會報錯*/}

[-]?[0-9]+                { printf("Integer : %s\n", yytext); int_count++; }
[-]?[0-9]+[^0-9.\x00-\x1F\n]+.* {
    printf("Error : %s\n", yytext);
    error_count++;
}

^[-]?[0-9]+\.[0-9]+        { printf("Float : %s\n", yytext); float_count++; }
^[-]?[0-9]+\.        { printf("Error : %s\n", yytext);error_count++; }
^[-]?[0-9]+\.[^.\x00-\x1F0-9\n]+.*        {printf("Error : %s\n", yytext);error_count++;}
^[-]?[0-9]+\.[0-9]+[^.\x00-\x1F0-9\n]+.*        {printf("Error : %s\n", yytext);error_count++;}
[0-9]+\.[0-9]+\..* {printf("Error : %s\n", yytext);error_count++;}

^[^ \t\n]+[ \t]+[^ \t\n]+.*                { printf("Error : %s\n", yytext); error_count++; }
\n          { /* 忽略换行符 */ }
[ \t] {}
^[^ \-a-zA-Z0-9].* { 
    if(yytext[0]>=' ')printf("Error : %s\n", yytext);//因為會把控制符號也一起掃進去
    error_count++;
}

%%

int main() {
    yylex();
    printf("Total_Integer : %d\n", int_count);
    printf("Total_Float : %d\n", float_count);
    printf("Total_Identifier(ID) : %d\n", id_count);
    printf("Total_Error : %d\n", error_count);
    return 0;
}

