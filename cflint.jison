/* 
    cfscript parser

    written in jison. see: http://zaach.github.io/jison/

    TODOs: 
    - control statements
    - match exact whitespace (tabs, spaces)
    - handle ++ -- += -=
    - lots of other stuff
*/

/* lexical grammar */
%lex
%%

\s+                                     /* ignore whitespace (for now) */
\/\/.*\b                                return 'COMMENT_LINE'
\/\*.*\*\/                              return 'COMMENT_LINES'
[A-Z_][A-Z_\d]*\b                       return 'ALLCAPS'
[Cc][Ff][Ss][Cc][Rr][Ii][Pp][Tt]        return 'CFSCRIPT'
[Cc][Oo][Mm][Pp][Oo][Nn][Ee][Nn][Tt]    return 'COMPONENT'
[Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn]        return 'FUNCTION'
[Rr][Ee][Tt][Uu][Rr][Nn]                return 'RETURN'
[Ii][Nn][Cc][Ll][Uu][Dd][Ee]            return 'INCLUDE'
[Vv][Aa][Rr]                            return 'VAR'
[Tt][Rr][Uu][Ee]                        return 'TRUE'
[Ff][Aa][Ll][Ss][Ee]                    return 'FALSE'
[0-9]+("."[0-9]+)?\b                    return 'NUMBER'
[\"\'].*[\"\']                          return 'STRING'
'+'                                     return '+'
'-'                                     return '-'
'*'                                     return '*'
"/"                                     return '/'
";"                                     return ';'
"{"                                     return '{'
"}"                                     return '}'
"["                                     return '['
"]"                                     return ']'
"("                                     return '('
")"                                     return ')'
"<"                                     return '<'
">"                                     return '>'
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


%start cfscript

%% /* language grammar */

cfscript
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
    | COMMENT_LINE
    | COMMENT_LINES
    ;

control
    : INCLUDE STRING ';'
    | RETURN expression ';'
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
    | FUNCTION NAME '(' item_list ')' block
    | FUNCTION NAME '(' ')' block
    ;

anonymous_function
    : FUNCTION '(' function_opts ')' block
    | FUNCTION '(' ')' block
    ;

function_call
    : NAME '(' function_opts ')'
    | NAME '(' item_list ')'
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
    : NAME '=' item
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
    : NAME '.' item
    | NAME '[' expression ']'
    | '[' ']'
    | '[' expression ']'
    | '{' '}'
    | '{' struct_options '}'
    | NAME
    ;

constant
    : boolean
    | NUMBER
    | STRING
    ;

boolean
    : TRUE
    | FALSE
    ;

expression
    : item comparator item
    | item operator item
    | item
    ;

comparator
    : '=='
    | '!='
    | '>'
    | '<'
    | '>='
    | '<='
    | '&&'
    | '||'
    ;

operator
    : '+'
    | '-'
    | '/'
    | '*'
    ;

item_list 
    : item_list ',' item
    | item
    ;

item
    : variable
    | constant
    | anonymous_function
    | function_call
    ;
