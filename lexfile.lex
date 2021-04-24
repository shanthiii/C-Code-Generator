%option noyywrap

%{

#include <stdio.h>
#include "y.tab.h"

char c;
int yyerror(char const *s);
int yylex();

%}

DIGIT  [0-9]+
NUMBER [+-]?[0-9]+|[+-]?[0-9]*"."[0-9]+
STRING \"(\\.|[^\"])*\"
BOOLEAN ["True" "False"]
ID [a-zA-Z_][0-9a-zA-Z_]*
FLOAT [0-9]+[.][0-9]*

ARITHMETIC_OPERATORS ['+' '-' '*' '/' '%']
OTHER_CHARACTERS ['=' '.' '(' ')' '{' '}' '[' ']']
TYPES ["Number" "String" "Boolean" "Return"]


%%

"begin" return BEG;
"end" return END;
"int" { strcpy(yylval.code,yytext); return DATATYPE; }
"float" {strcpy(yylval.code,yytext);  return DATATYPE;}
"char" { strcpy(yylval.code,yytext); return DATATYPE; }
"double" { strcpy(yylval.code,yytext); return DATATYPE; }
"assign" return ASSIGN;
"to" return TO;
"print" return PRINT;
"scan" return SCAN;
"read" return READ;
"," return COMMA;
"(" return OPEN;
")" return CLOSE;
"if" return IF;
"then" return THEN;
"else" return ELSE;
"endif" return ENDIF;
"endelse" return ENDELSE;
"while" return WHILE;
"while_do" return WHILE_DO;
"endwhile" return ENDWHILE;
"enddowhile" return ENDDOWHILE;
"do" return DO;
"for" return FOR;
"from" return FROM;
"repeat" return REPEAT;
"return" return RETURN;
"endfor" return ENDFOR;
"\"" return QUOTE;
"True" { strcpy(yylval.code,yytext); return BOOL; }
"false" { strcpy(yylval.code,yytext); return BOOL; }
"<=" { strcpy(yylval.code,yytext); return RELOP;}
">=" { strcpy(yylval.code,yytext); return RELOP; }
"==" { strcpy(yylval.code,yytext); return RELOP; }
"!=" { strcpy(yylval.code,yytext); return RELOP; }
"<" { strcpy(yylval.code,yytext); return RELOP; }
">" { strcpy(yylval.code,yytext); return RELOP; }
"&&" { strcpy(yylval.code,yytext); return LOGOP; }
"||" { strcpy(yylval.code,yytext); return LOGOP; }
"+" { strcpy(yylval.code,yytext); return AS; }
"-" { strcpy(yylval.code,yytext); return AS; }
"*" { strcpy(yylval.code,yytext); return MD; }
"/" { strcpy(yylval.code,yytext); return MD; }
"=" { strcpy(yylval.code,yytext); return Q; }
"start_procedure"    return START_PROCEDURE;
"end_procedure"    return END_FUNCTION;


{ID}({ID}|{DIGIT})*  {strcpy(yylval.code,yytext); return VAR; }
{ID}({ID}|{DIGIT})*/[(] { strcpy(yylval.code,yytext); return NAME_PROCEDURE;}
[0-9]+ {strcpy(yylval.code, (yytext)); return NUM; }

%%

