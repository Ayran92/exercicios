%option noyywrap nodefault yylineno

%{

#include "e1.tab.h"
int confirm = 0;

%}

%%

"//".*                { /* void */      }

const                 { return CONST;   }
int                   { return INT;     }
return                { return RETURN;  }
void                  { return VOID;    } 


[0-9]+                { return NUM;     }

[a-zA-Z][a-zA-Z0-9_]* { return ID;      }


"+"                   { return PLUS;    }
"-"                   { return MINUS;   }
"*"                   { return MULT;    }
"/"                   { return DIV;     }
"="                   { return IQUAL;   }
";"                   { return SEMIC;   }
"("                   { return OPENP;   }
")"                   { return CLOSEP;  }
"{"                   { return OPENC;   }
"}"                   { return CLOSEC;  }

\n                    {                 }
" "*                  {                 }
[\t\r]+               {   /* void */    }

.                     { confirm = 1; return ERRO;  } 

%%
/*int main() {
    int token;

    char *token_name[17] = {"CONST", "ID","VOID", "RETURN","MULT", "DIV", "IQUAL", "SEMIC", "OPENP", "CLOSEP", "INT", "MINUS", "NUM", "PLUS", "OPENC", "CLOSEC", "ERRO"};

    while ((token = yylex())) {
       fprintf(stdout,"token code: %d", token);
       fprintf(stdout,", token class: %s", token_name[token-258]);
       fprintf(stdout,", lexeme: %s\n", yytext);
    }
    
}*/