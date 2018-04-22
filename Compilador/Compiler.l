%{
  #include "y.tab.h"
  #include <string>
  #include <string.h>
  #include <stdlib.h>
  void yyerror(std::string S);
  extern int yylineno;
%}

%option yylineno

comment ;.+
tag    [a-zA-Z_][a-zA-Z0-9_]*
imme   \#-?(0x)?[0-9]+
numero [0-9]+

%%

    /*Operation Keywords*/
(a|A)(d|D)(d|D)          {yylval.id=strdup(yytext); return addition;}
(s|S)(u|U)(b|B)          {yylval.id=strdup(yytext); return subtra;}
(m|M)(u|U)(l|L)          {yylval.id=strdup(yytext); return multiple;}
(b|B)(e|E)(q|Q)          {yylval.id=strdup(yytext); return braneq;}
(b|B)(n|N)(e|E)          {yylval.id=strdup(yytext); return branne;}
(l|L)(d|D)(r|R)          {yylval.id=strdup(yytext); return load;}
(s|S)(t|T)(r|R)          {yylval.id=strdup(yytext); return store;}
(c|C)(m|M)(p|P)          {yylval.id=strdup(yytext); return comp;}
(m|M)(o|O)(v|V)          {yylval.id=strdup(yytext); return mv;}
(b|B)                    {yylval.id=strdup(yytext); return branch;}

    /*Types*/
DCB                     {yylval.id=strdup(yytext); return dcb;}
DCW                     {yylval.id=strdup(yytext); return dcw;}
DCD                     {yylval.id=strdup(yytext); return dcd;}

    /*Registers*/
(r|R)[0-9][0-5]?         {yylval.id=strdup(yytext); return reg;}

{imme}                  {yylval.id=strdup(yytext); return immediate;}

  /*Tags*/
{tag}                    {yylval.id=strdup(yytext); return label;}
  /*Comments*/
{comment}                {yylval.id=strdup(yytext); return commentary;}

{numero}                {yylval.num=atoi(yytext); return number;}

[,\[\]\n\=\!]                 {return yytext[0];}
[\t \s]                   {;}
.                  {yyerror("invalid character");}
%%
int yywrap(void){
  return 1;
}
