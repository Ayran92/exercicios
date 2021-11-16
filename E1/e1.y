%{

#include <stdio.h>

extern int yylex();
extern char* yytext;
extern int yylineno;
extern int confirm;
#define YYERROR_VERBOSE 1


void yyerror(const char* msg) {
      if (confirm == 1) {
            printf("=============================================================\nError Lexico na linha -> %d\nChar desconhecido -> %s\n=============================================================\n",yylineno, yytext);
      }
      else {
            fprintf(stderr, "%d=============================================================\nError Sintatico na linha -> %d\nError -> %s\n=============================================================\n", confirm,yylineno, msg);
      }
}
%}

%token CONST
%token ID
%token VOID
%token RETURN
%token MULT
%token DIV
%token IQUAL
%token SEMIC
%token OPENP
%token CLOSEP
%token INT
%token MINUS
%token NUM
%token PLUS
%token OPENC
%token CLOSEC
%token ERRO
%start program
%%

program: declaration-list compound-stmt;

declaration-list: declaration-list declaration
                | declaration
                ;

declaration: var-declaration
           | const-declaration
           ;

var-declaration: type-specifier ID SEMIC;

type-specifier: INT 
              | VOID
              ;

const-declaration: CONST type-specifier ID IQUAL NUM SEMIC;

/*======================================================================*/

compound-stmt: OPENC local-declarations statement-list CLOSEC;

local-declarations: local-declarations var-declaration
                  | /*empty*/
                  ;

statement-list: statement-list statement
              | /*empty*/
              ;

statement: expression-stmt 
         | return-stmt
         ;

expression-stmt: expression SEMIC | SEMIC;

return-stmt: RETURN SEMIC | RETURN expression;


/*======================================================================*/
expression: ID IQUAL additive-expression;

additive-expression: additive-expression addop term
                   | term
                   ;

addop: PLUS
     | MINUS
     ;

term: term mulop factor
    | factor
    ;

mulop: MULT
     | DIV
     ;

factor: OPENP expression CLOSEP
      | ID 
      | NUM 
      | OPENP additive-expression CLOSEP
      ;


%%

int main() {
     if (yyparse() == 0) {
           printf("=============================================================\nSem erros Lexicos ou Sintaticos!\n=============================================================\n");
     }
}