%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *msg);
extern int yylex();
%}

%token NUMBER
%token PLUS MINUS MULTIPLY DIVIDE LPAREN RPAREN

%left PLUS MINUS
%left MULTIPLY DIVIDE
%nonassoc UMINUS  // 定義負號的優先級

%%
calculation:
    calculation expression '\n' { 
        printf("ANS is %d\n\n", $2); 
    }
    | /* 空規則，允許輸入空行 */
    ;


expression:
    NUMBER { $$ = $1; }
    | expression PLUS expression { 
        printf("%d plus %d equals %d\n", $1, $3, $1 + $3); 
        $$ = $1 + $3; 
    }
    | expression MINUS expression { 
        printf("%d minus %d equals %d\n", $1, $3, $1 - $3); 
        $$ = $1 - $3; 
    }
    | expression MULTIPLY expression { 
        printf("%d multiply %d equals %d\n", $1, $3, $1 * $3); 
        $$ = $1 * $3; 
    }
    | expression DIVIDE expression { 
        if ($3 == 0) { 
            yyerror("Division by zero"); 
            $$ = 0; 
        } else { 
            printf("%d divide %d equals %d\n", $1, $3, $1 / $3); 
            $$ = $1 / $3; 
        }
    }
    | LPAREN expression RPAREN { $$ = $2; }
    | MINUS expression %prec UMINUS { 
        $$ = -$2; 
    }
    ;
%%
int main() {
    printf("Enter expressions (end with Ctrl+D):\n");
    yyparse();
    return 0;
}

void yyerror(const char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
}
