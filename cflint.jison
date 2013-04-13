/* 
    cfscript parser

    written in jison. see: http://zaach.github.io/jison/

    TODOs: 
    - boolean expressions
    - single-line comments (stop ignoring whitespace?) 
    - handle ++ -- += -=
    - lots of other stuff
*/

/* lexical grammar */
%lex
%%

\s+                                     /* ignore whitespace (for now) */
\/\*.*\*\/                              /* multi-line comments */
[A-Z_][A-Z_\d]*\b                       return 'ALLCAPS'
[Cc][Ff][Ss][Cc][Rr][Ii][Pp][Tt]        return 'CFSCRIPT'
[Cc][Oo][Mm][Pp][Oo][Nn][Ee][Nn][Tt]    return 'COMPONENT'
[Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn]        return 'FUNCTION'
[Ii][Nn][Cc][Ll][Uu][Dd][Ee]            return 'INCLUDE'
[Vv][Aa][Rr]                            return 'VAR'
[0-9]+("."[0-9]+)?\b                    return 'NUMBER'
[\"\'].*[\"\']                          return 'STRING'
";"                                     return ';'
"{"                                     return '{'
"}"                                     return '}'
"["                                     return '['
"]"                                     return ']'
"("                                     return '('
")"                                     return ')'
"<"                                     return '<'
">"                                     return '>'
"/"                                     return '/'
"."                                     return '.'
","                                     return ','
":"                                     return ':'
"=="                                    return '=='
"!="                                    return '!='
"&&"                                    return '&&'
"||"                                    return '||'
">="                                    return '>='
"<="                                    return '<='
"="                                     return '='
[\w_][\w_\d]*                           return 'NAME'
<<EOF>>                                 return 'EOF'

/lex


%start expressions

%% /* language grammar */

expressions
    : script EOF
        {return true;}
    | component_definition EOF
        {return true;}
    ;

script
    : '<' CFSCRIPT '>' statements '<' '/' CFSCRIPT '>'
    ;

statements
    : statements statement
    | statement
    ;

statement
    : assignment ';'
    | expression ';'
    | function_definition
    | control
    ;

control
    : INCLUDE STRING ';'
    ;

block
    : '{' statements '}'
    ;

component_definition
    : COMPONENT block
    | COMPONENT component_opts block
    ;

function_definition
    : FUNCTION NAME '(' function_opts ')' block
    | FUNCTION NAME '(' ')' block
    ;

anonymous_function
    : FUNCTION '(' function_opts ')' block
    | FUNCTION '(' ')' block
    ;

function_call
    : NAME '(' function_opts ')'
    | NAME '(' expression_list ')'
    | NAME '(' ')'
    ;

component_opts
    : component_opts component_opt
    | component_opt
    ;

component_opt
    : NAME '=' STRING
    ;

function_opts
    : function_opts ',' function_opt
    | function_opt
    ;

function_opt
    : NAME '=' expression
    ;

struct_options
    : struct_options ',' struct_opt
    | struct_opt
    ;

struct_opt
    : NAME ':' expression
    | NAME '=' expression
    ;

assignment
    : VAR NAME '=' expression
    | variable '=' expression
    ;

variable
    : NAME '.' expression
    | NAME '[' expression ']'
    | '[' ']'
    | '[' expression ']'
    | '{' '}'
    | '{' struct_options '}'
    | NAME
    ;

constant
    : NUMBER
    | STRING
    ;

boolean_expression
    : expression bool expression
    ;

bool
    : '=='
    | '!='
    | '>='
    | '<='
    | '&&'
    | '||'
    ;

expression_list 
    : expression_list ',' expression
    | expression
    ;

expression
    : variable
    | constant
    | anonymous_function
    | function_call
    ;
