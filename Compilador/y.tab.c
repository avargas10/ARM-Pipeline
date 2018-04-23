
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.4.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Copy the first part of user declarations.  */

/* Line 189 of yacc.c  */
#line 1 "Compiler.y"


    #include <stdio.h>
    #include <iostream>
    #include <string.h>
    #include <bitset>
    #include <vector>
    #include <map>
    #include <stdlib.h>
    #include <algorithm>
    #include <cstdlib>
    #include <fstream>

    std::map<std::string,int> labels; //Etiquetas y valores
    std::map<std::string,int> futureLabels; //En caso de encontrar una etiqueta antes de ser declarada
    std::fstream fs;
    std::fstream fs2;
    int memCount=0;

    int yylex();
    void encondig_instruccion(std::string op,std::string rs,std::string rs2,std::string rd);
    void encondig_instruccion1(std::string op,std::string rs,std::string rd,std::string immen);
    void encondig_instruccion2(std::string op,std::string rs,std::string rd);
    void encondig_instruccion3(std::string op,std::string rs,std::string imme);
    void encondig_instruccion4(std::string op,std::string rs,std::string tag);
    void encondig_instruccion5(std::string op,std::string tag);
    void encondig_instruccion6(std::string op,std::string rd,std::string rs,std::string rs2,int type);
    void encondig_instruccion7(std::string op,std::string rd,std::string rs,std::string rs2);
    std::string regtobin(std::string r);
    int indexOf(std::string tag);
    std::string immtobin(std::string in,int type);
    void procces_label(std::string tag,std::string g,int type);
    void variablestobin(int val);
    std::string current_type="DCD";
    int data_memory=0x10000000;
    int text_memory=0x00000000;
    void yyerror(std::string S);
    void printt(std::string s);



/* Line 189 of yacc.c  */
#line 115 "y.tab.c"

/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     addition = 258,
     subtra = 259,
     multiple = 260,
     comp = 261,
     load = 262,
     store = 263,
     branch = 264,
     braneq = 265,
     branne = 266,
     mv = 267,
     dcb = 268,
     dcw = 269,
     dcd = 270,
     reg = 271,
     immediate = 272,
     label = 273,
     commentary = 274,
     number = 275
   };
#endif
/* Tokens.  */
#define addition 258
#define subtra 259
#define multiple 260
#define comp 261
#define load 262
#define store 263
#define branch 264
#define braneq 265
#define branne 266
#define mv 267
#define dcb 268
#define dcw 269
#define dcd 270
#define reg 271
#define immediate 272
#define label 273
#define commentary 274
#define number 275




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 214 of yacc.c  */
#line 42 "Compiler.y"

  char* id;
  int num;



/* Line 214 of yacc.c  */
#line 198 "y.tab.c"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif


/* Copy the second part of user declarations.  */


/* Line 264 of yacc.c  */
#line 210 "y.tab.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int yyi)
#else
static int
YYID (yyi)
    int yyi;
#endif
{
  return yyi;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)				\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack_alloc, Stack, yysize);			\
	Stack = &yyptr->Stack_alloc;					\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  2
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   66

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  27
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  7
/* YYNRULES -- Number of rules.  */
#define YYNRULES  38
/* YYNRULES -- Number of states.  */
#define YYNSTATES  59

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   275

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
      21,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    26,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,    22,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    23,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    24,     2,    25,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint8 yyprhs[] =
{
       0,     0,     3,     7,    11,    15,    20,    24,    29,    34,
      35,    40,    45,    48,    54,    61,    68,    77,    86,    95,
     105,   112,   115,   117,   121,   123,   127,   129,   131,   133,
     135,   137,   139,   141,   143,   145,   147,   149,   151
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      28,     0,    -1,    28,    30,    21,    -1,    28,    29,    21,
      -1,    28,    18,    21,    -1,    28,    18,    29,    21,    -1,
      28,    19,    21,    -1,    28,    18,    19,    21,    -1,    28,
      30,    19,    21,    -1,    -1,    33,    16,    22,    16,    -1,
      33,    16,    22,    17,    -1,    33,    18,    -1,    33,    16,
      22,    23,    18,    -1,    33,    16,    22,    16,    22,    17,
      -1,    33,    16,    22,    24,    16,    25,    -1,    33,    16,
      22,    24,    16,    22,    16,    25,    -1,    33,    16,    22,
      24,    16,    22,    17,    25,    -1,    33,    16,    22,    24,
      16,    25,    22,    17,    -1,    33,    16,    22,    24,    16,
      22,    17,    25,    26,    -1,    33,    16,    22,    16,    22,
      16,    -1,    29,    19,    -1,     1,    -1,    18,    32,    31,
      -1,    20,    -1,    31,    22,    20,    -1,    13,    -1,    14,
      -1,    15,    -1,     3,    -1,     4,    -1,     5,    -1,     6,
      -1,     8,    -1,     7,    -1,     9,    -1,    10,    -1,    11,
      -1,    12,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint8 yyrline[] =
{
       0,    58,    58,    59,    60,    61,    62,    63,    64,    65,
      68,    69,    70,    71,    72,    73,    74,    75,    76,    77,
      78,    79,    80,    83,    85,    86,    88,    89,    90,    93,
      94,    95,    96,    97,    98,    99,   100,   101,   102
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "addition", "subtra", "multiple", "comp",
  "load", "store", "branch", "braneq", "branne", "mv", "dcb", "dcw", "dcd",
  "reg", "immediate", "label", "commentary", "number", "'\\n'", "','",
  "'='", "'['", "']'", "'!'", "$accept", "line", "instruccion", "variable",
  "array", "val_type", "operation", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,    10,    44,    61,    91,    93,    33
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    27,    28,    28,    28,    28,    28,    28,    28,    28,
      29,    29,    29,    29,    29,    29,    29,    29,    29,    29,
      29,    29,    29,    30,    31,    31,    32,    32,    32,    33,
      33,    33,    33,    33,    33,    33,    33,    33,    33
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     3,     3,     3,     4,     3,     4,     4,     0,
       4,     4,     2,     5,     6,     6,     8,     8,     8,     9,
       6,     2,     1,     3,     1,     3,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       9,     0,     1,    22,    29,    30,    31,    32,    34,    33,
      35,    36,    37,    38,     0,     0,     0,     0,     0,    26,
      27,    28,     0,     4,     0,     0,     6,    21,     3,     0,
       2,     0,    12,     7,     5,    24,    23,     8,     0,     0,
      10,    11,     0,     0,    25,     0,    13,     0,    20,    14,
       0,    15,     0,     0,     0,    16,    17,    18,    19
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     1,    16,    17,    36,    25,    18
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -21
static const yytype_int8 yypact[] =
{
     -21,    21,   -21,   -21,   -21,   -21,   -21,   -21,   -21,   -21,
     -21,   -21,   -21,   -21,    -1,   -20,    -4,    17,    27,   -21,
     -21,   -21,     2,   -21,    25,    32,   -21,   -21,   -21,    16,
     -21,    29,   -21,   -21,   -21,   -21,    34,   -21,    18,    35,
      36,   -21,    39,    37,   -21,    31,   -21,    -6,   -21,   -21,
      33,    38,    40,    41,    42,   -21,    28,   -21,   -21
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -21,   -21,    47,   -21,   -21,   -21,   -21
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -1
static const yytype_uint8 yytable[] =
{
       3,    26,     4,     5,     6,     7,     8,     9,    10,    11,
      12,    13,    19,    20,    21,    27,    50,    28,    22,    51,
      23,     2,     3,    33,     4,     5,     6,     7,     8,     9,
      10,    11,    12,    13,    40,    41,    29,    37,    30,    14,
      15,    42,    43,    31,    27,    32,    34,    48,    49,    52,
      53,    38,    35,    47,    58,    44,    39,    46,    45,    57,
      54,    24,     0,     0,     0,    55,    56
};

static const yytype_int8 yycheck[] =
{
       1,    21,     3,     4,     5,     6,     7,     8,     9,    10,
      11,    12,    13,    14,    15,    19,    22,    21,    19,    25,
      21,     0,     1,    21,     3,     4,     5,     6,     7,     8,
       9,    10,    11,    12,    16,    17,    19,    21,    21,    18,
      19,    23,    24,    16,    19,    18,    21,    16,    17,    16,
      17,    22,    20,    16,    26,    20,    22,    18,    22,    17,
      22,    14,    -1,    -1,    -1,    25,    25
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    28,     0,     1,     3,     4,     5,     6,     7,     8,
       9,    10,    11,    12,    18,    19,    29,    30,    33,    13,
      14,    15,    19,    21,    29,    32,    21,    19,    21,    19,
      21,    16,    18,    21,    21,    20,    31,    21,    22,    22,
      16,    17,    23,    24,    20,    22,    18,    16,    16,    17,
      22,    25,    16,    17,    22,    25,    25,    17,    26
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
#else
static void
yy_stack_print (yybottom, yytop)
    yytype_int16 *yybottom;
    yytype_int16 *yytop;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}

/* Prevent warnings from -Wmissing-prototypes.  */
#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */


/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*-------------------------.
| yyparse or yypush_parse.  |
`-------------------------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{


    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       `yyss': related to states.
       `yyvs': related to semantic values.

       Refer to the stacks thru separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yytoken = 0;
  yyss = yyssa;
  yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */
  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;

	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),
		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss_alloc, yyss);
	YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 4:

/* Line 1455 of yacc.c  */
#line 60 "Compiler.y"
    {procces_label((yyvsp[(2) - (3)].id),"",1);}
    break;

  case 5:

/* Line 1455 of yacc.c  */
#line 61 "Compiler.y"
    {procces_label((yyvsp[(2) - (4)].id),"",1);}
    break;

  case 7:

/* Line 1455 of yacc.c  */
#line 63 "Compiler.y"
    {procces_label((yyvsp[(2) - (4)].id),"",1);}
    break;

  case 10:

/* Line 1455 of yacc.c  */
#line 68 "Compiler.y"
    {encondig_instruccion2((yyvsp[(1) - (4)].id),(yyvsp[(4) - (4)].id),(yyvsp[(2) - (4)].id));}
    break;

  case 11:

/* Line 1455 of yacc.c  */
#line 69 "Compiler.y"
    {encondig_instruccion3((yyvsp[(1) - (4)].id),(yyvsp[(2) - (4)].id),(yyvsp[(4) - (4)].id));}
    break;

  case 12:

/* Line 1455 of yacc.c  */
#line 70 "Compiler.y"
    {encondig_instruccion5((yyvsp[(1) - (2)].id),(yyvsp[(2) - (2)].id));}
    break;

  case 13:

/* Line 1455 of yacc.c  */
#line 71 "Compiler.y"
    {encondig_instruccion4((yyvsp[(1) - (5)].id),(yyvsp[(2) - (5)].id),(yyvsp[(5) - (5)].id));}
    break;

  case 14:

/* Line 1455 of yacc.c  */
#line 72 "Compiler.y"
    {encondig_instruccion1((yyvsp[(1) - (6)].id),(yyvsp[(4) - (6)].id),(yyvsp[(2) - (6)].id),(yyvsp[(6) - (6)].id));}
    break;

  case 15:

/* Line 1455 of yacc.c  */
#line 73 "Compiler.y"
    {encondig_instruccion6((yyvsp[(1) - (6)].id),(yyvsp[(2) - (6)].id),(yyvsp[(5) - (6)].id),"",1);}
    break;

  case 16:

/* Line 1455 of yacc.c  */
#line 74 "Compiler.y"
    {encondig_instruccion6((yyvsp[(1) - (8)].id),(yyvsp[(2) - (8)].id),(yyvsp[(5) - (8)].id),(yyvsp[(7) - (8)].id),2);}
    break;

  case 17:

/* Line 1455 of yacc.c  */
#line 75 "Compiler.y"
    {encondig_instruccion6((yyvsp[(1) - (8)].id),(yyvsp[(2) - (8)].id),(yyvsp[(5) - (8)].id),(yyvsp[(7) - (8)].id),3);}
    break;

  case 18:

/* Line 1455 of yacc.c  */
#line 76 "Compiler.y"
    {encondig_instruccion7((yyvsp[(1) - (8)].id),(yyvsp[(2) - (8)].id),(yyvsp[(5) - (8)].id),(yyvsp[(8) - (8)].id));}
    break;

  case 19:

/* Line 1455 of yacc.c  */
#line 77 "Compiler.y"
    {encondig_instruccion6((yyvsp[(1) - (9)].id),(yyvsp[(2) - (9)].id),(yyvsp[(5) - (9)].id),(yyvsp[(7) - (9)].id),4);}
    break;

  case 20:

/* Line 1455 of yacc.c  */
#line 78 "Compiler.y"
    {encondig_instruccion((yyvsp[(1) - (6)].id),(yyvsp[(4) - (6)].id),(yyvsp[(6) - (6)].id),(yyvsp[(2) - (6)].id));}
    break;

  case 21:

/* Line 1455 of yacc.c  */
#line 79 "Compiler.y"
    {;}
    break;

  case 22:

/* Line 1455 of yacc.c  */
#line 80 "Compiler.y"
    {yyerror("2, instruccion wrong");}
    break;

  case 23:

/* Line 1455 of yacc.c  */
#line 83 "Compiler.y"
    {procces_label((yyvsp[(1) - (3)].id),(yyvsp[(2) - (3)].id),2);}
    break;

  case 24:

/* Line 1455 of yacc.c  */
#line 85 "Compiler.y"
    {variablestobin((yyvsp[(1) - (1)].num));}
    break;

  case 25:

/* Line 1455 of yacc.c  */
#line 86 "Compiler.y"
    {variablestobin((yyvsp[(3) - (3)].num));}
    break;

  case 26:

/* Line 1455 of yacc.c  */
#line 88 "Compiler.y"
    {(yyval.id)=(yyvsp[(1) - (1)].id);}
    break;

  case 27:

/* Line 1455 of yacc.c  */
#line 89 "Compiler.y"
    {(yyval.id)=(yyvsp[(1) - (1)].id);}
    break;

  case 28:

/* Line 1455 of yacc.c  */
#line 90 "Compiler.y"
    {(yyval.id)=(yyvsp[(1) - (1)].id);}
    break;

  case 29:

/* Line 1455 of yacc.c  */
#line 93 "Compiler.y"
    {;}
    break;

  case 30:

/* Line 1455 of yacc.c  */
#line 94 "Compiler.y"
    {;}
    break;

  case 31:

/* Line 1455 of yacc.c  */
#line 95 "Compiler.y"
    {;}
    break;

  case 32:

/* Line 1455 of yacc.c  */
#line 96 "Compiler.y"
    {;}
    break;

  case 33:

/* Line 1455 of yacc.c  */
#line 97 "Compiler.y"
    {;}
    break;

  case 34:

/* Line 1455 of yacc.c  */
#line 98 "Compiler.y"
    {;}
    break;

  case 35:

/* Line 1455 of yacc.c  */
#line 99 "Compiler.y"
    {;}
    break;

  case 36:

/* Line 1455 of yacc.c  */
#line 100 "Compiler.y"
    {;}
    break;

  case 37:

/* Line 1455 of yacc.c  */
#line 101 "Compiler.y"
    {;}
    break;

  case 38:

/* Line 1455 of yacc.c  */
#line 102 "Compiler.y"
    {;}
    break;



/* Line 1455 of yacc.c  */
#line 1672 "y.tab.c"
      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined(yyoverflow) || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}



/* Line 1675 of yacc.c  */
#line 105 "Compiler.y"


extern int yyparse();
extern FILE *yyin;
std::string ruta="";

//Instruccion op rd,rs,rm
void encondig_instruccion(std::string op,std::string rs,std::string rs2,std::string rd){
  std::string binIns="1110";
  text_memory+=0x4;
  if(op.compare("Add")==0 || op.compare("ADD")==0 || op.compare("add")==0){
    binIns+="00001000";
    binIns+=regtobin(rs);
    binIns+=regtobin(rd);
    binIns+="00000000";
    binIns+=regtobin(rs2);
    fs<<binIns<<'\n';
  }else if(op.compare("Sub")==0 || op.compare("sub")==0 || op.compare("SUB")==0){
    binIns+="00000100";
    binIns+=regtobin(rs);
    binIns+=regtobin(rd);
    binIns+="00000000";
    binIns+=regtobin(rs2);
    fs<<binIns<<'\n';
  }else if(op.compare("Mul")==0 || op.compare("MUL")==0 || op.compare("mul")==0){
    binIns+="00000000";
    binIns+=regtobin(rd);
    binIns+="0000";
    binIns+=regtobin(rs2);
    binIns+="1001";
    binIns+=regtobin(rs);
    fs<<binIns<<'\n';
  }else{
    std::cout<< "Error at read instruccion: 2"<<'\n';
  }
}

//Instruccion op rd,rs
void encondig_instruccion2(std::string op,std::string rs,std::string rd){
  std::string binIns="1110";
  text_memory+=0x4;
  if(op.compare("cmp")==0 || op.compare("CMP")==0 || op.compare("Cmp")==0){
    binIns+="00010101";
    binIns+=regtobin(rd);
    binIns+="000000000000";
    binIns+=regtobin(rs);
    fs<<binIns<<'\n';
  }else if(op.compare("mov")==0 || op.compare("MOV")==0 || op.compare("Mov")==0){
    binIns+="000110100000";
    binIns+=regtobin(rd);
    binIns+="00000000";
    binIns+=regtobin(rs);
    fs<<binIns<<'\n';
  }else{
    std::cout<< "Error at read instruccion: 2"<<'\n';
  }
}

//Instruccion op rd,#imme
void encondig_instruccion3(std::string op,std::string rs,std::string imme){
  std::string binIns="1110";
  text_memory+=0x4;
  if(op.compare("cmp")==0 || op.compare("CMP")==0 || op.compare("Cmp")==0){
    binIns+="00110101";
    binIns+=regtobin(rs);
    binIns+="0000";
    binIns+=immtobin(imme,1);
    fs<<binIns<<'\n';
  }else if(op.compare("mov")==0 || op.compare("MOV")==0 || op.compare("Mov")==0){
    binIns+="001110100000";
    binIns+=regtobin(rs);
    binIns+=immtobin(imme,1);
    fs<<binIns<<'\n';
  }else{
    std::cout<< "Error at read instruccion: 2"<<'\n';
  }
}

//No implementadas correctamente, no realizan lo que deberian
void encondig_instruccion4(std::string op,std::string rs,std::string tag){
  std::string binIns="1110";
  text_memory+=0x4;
  if(op.compare("ldr")==0 || op.compare("Ldr")==0 || op.compare("LDR")==0){
    binIns+="010100010000";
    binIns+=regtobin(rs);
    int result=labels.find(tag)->second;
    binIns+=std::bitset<12>(result).to_string();
    fs<<binIns<<'\n';
  }else if(op.compare("str")==0 || op.compare("Str")==0 || op.compare("STR")==0){
    binIns+="010100000000";
    binIns+=regtobin(rs);
    int result=labels.find(tag)->second;
    binIns+=std::bitset<12>(result).to_string();
    fs<<binIns<<'\n';
  }else{
    std::cout<< "Error at read instruccion: 2"<<'\n';
  }
}

//Branch instruccion
void encondig_instruccion5(std::string op,std::string tag){
  text_memory+=0x4;
  if(op.compare("B")==0 || op.compare("b")==0){
    std::string binIns="11101010";
    int index=labels.find(tag)->second;
    if(index < 0){
      futureLabels[tag]=fs.tellp();
    }
    int result=(index-text_memory+0x4)/4;
    binIns+=std::bitset<24>(result).to_string();
    fs<<binIns<<'\n';
    fs<<"11100001101000000000000000000000"<<'\n';
    fs<<"11100001101000000000000000000000"<<'\n';
    fs<<"11100001101000000000000000000000"<<'\n';
    fs<<"11100001101000000000000000000000"<<'\n';
    fs<<"11100001101000000000000000000000"<<'\n';
  }else if(op.compare("Beq")==0 || op.compare("BEQ")==0 || op.compare("beq")==0){
    std::string binIns="00001010";
    int index=labels.find(tag)->second;
    if(index < 0){
      futureLabels[tag]=fs.tellp();
    }
    int result=(index-text_memory+0x4)/4;
    binIns+=std::bitset<24>(result).to_string();
    fs<<binIns<<'\n';
    fs<<"11100001101000000000000000000000"<<'\n';
    fs<<"11100001101000000000000000000000"<<'\n';
    fs<<"11100001101000000000000000000000"<<'\n';
    fs<<"11100001101000000000000000000000"<<'\n';
    fs<<"11100001101000000000000000000000"<<'\n';
  }else if(op.compare("Bne")==0 || op.compare("BNE")==0 || op.compare("bne")==0){
    std::string binIns="00011010";
    int index=labels.find(tag)->second;
    if(index < 0){
      futureLabels[tag]=fs.tellp();
    }
    int result=(index-text_memory+0x4)/4;
    binIns+=std::bitset<24>(result).to_string();
    fs<<binIns<<'\n';
    fs<<"11100001101000000000000000000000"<<'\n';
    fs<<"11100001101000000000000000000000"<<'\n';
    fs<<"11100001101000000000000000000000"<<'\n';
    fs<<"11100001101000000000000000000000"<<'\n';
    fs<<"11100001101000000000000000000000"<<'\n';
  }else{
    std::cout<< "Error at read instruccion: 2"<<'\n';
  }
}

//intruccion op rd,[rs,rm]
//          op rd,[rs,#imme] (post index and offset)
void encondig_instruccion6(std::string op,std::string rd,std::string rs,std::string rs2,int type){
  std::string binIns="111001";
  text_memory+=0x4;
  if(op.compare("ldr")==0 || op.compare("Ldr")==0 || op.compare("LDR")==0){
    if(type==1){
      binIns+="111001";
      binIns+=regtobin(rs);
      binIns+=regtobin(rd);
      binIns+="000000000000";
      fs<<binIns<<'\n';
      fs<<"11100001101000000000000000000000"<<'\n';
      fs<<"11100001101000000000000000000000"<<'\n';
      fs<<"11100001101000000000000000000000"<<'\n';
    }else if(type==2){
      binIns+="011001";
      binIns+=regtobin(rs);
      binIns+=regtobin(rd);
      binIns+="00000000";
      binIns+=regtobin(rs2);
      fs<<binIns<<'\n';
      fs<<"11100001101000000000000000000000"<<'\n';
      fs<<"11100001101000000000000000000000"<<'\n';
      fs<<"11100001101000000000000000000000"<<'\n';
    }else if(type==3){
      if(rs2.find("-")==std::string::npos){
        binIns+="111001";
        binIns+=regtobin(rs);
        binIns+=regtobin(rd);
        binIns+=immtobin(rs2,2);
        fs<<binIns<<'\n';
        fs<<"11100001101000000000000000000000"<<'\n';
        fs<<"11100001101000000000000000000000"<<'\n';
        fs<<"11100001101000000000000000000000"<<'\n';;
      }else{
        rs2.erase(1,1);
        binIns+="110001";
        binIns+=regtobin(rs);
        binIns+=regtobin(rd);
        binIns+=immtobin(rs2,2);
        fs<<binIns<<'\n';
        fs<<"11100001101000000000000000000000"<<'\n';
        fs<<"11100001101000000000000000000000"<<'\n';
        fs<<"11100001101000000000000000000000"<<'\n';
      }
    }else if(type==4){
      if(rs2.find("-")==std::string::npos){
        binIns+="111011";
        binIns+=regtobin(rs);
        binIns+=regtobin(rd);
        binIns+=immtobin(rs2,2);
        fs<<binIns<<'\n';
        fs<<"11100001101000000000000000000000"<<'\n';
        fs<<"11100001101000000000000000000000"<<'\n';
        fs<<"11100001101000000000000000000000"<<'\n';
      }else{
        rs2.erase(1,1);
        binIns+="110011";
        binIns+=regtobin(rs);
        binIns+=regtobin(rd);
        binIns+=immtobin(rs2,2);
        fs<<binIns<<'\n';
        fs<<"11100001101000000000000000000000"<<'\n';
        fs<<"11100001101000000000000000000000"<<'\n';
        fs<<"11100001101000000000000000000000"<<'\n';
      }
    }
  }else if(op.compare("str")==0 || op.compare("Str")==0 || op.compare("STR")==0){
    if(type==1){
      binIns+="111000";
      binIns+=regtobin(rs);
      binIns+=regtobin(rd);
      binIns+="000000000000";
      fs<<binIns<<'\n';
    }else if(type==2){
      binIns+="011000";
      binIns+=regtobin(rs);
      binIns+=regtobin(rd);
      binIns+="00000000";
      binIns+=regtobin(rs2);
      fs<<binIns<<'\n';
    }else if(type==3){
      if(rs2.find("-")==std::string::npos){
        binIns+="111000";
        binIns+=regtobin(rs);
        binIns+=regtobin(rd);
        binIns+=immtobin(rs2,2);
        fs<<binIns<<'\n';
      }else{
        rs2.erase(1,1);
        binIns+="110000";
        binIns+=regtobin(rs);
        binIns+=regtobin(rd);
        binIns+=immtobin(rs2,2);
        fs<<binIns<<'\n';
      }
    }else if(type==4){
      if(rs2.find("-")==std::string::npos){
        binIns+="111010";
        binIns+=regtobin(rs);
        binIns+=regtobin(rd);
        binIns+=immtobin(rs2,2);
        fs<<binIns<<'\n';
      }else{
        rs2.erase(1,1);
        binIns+="110010";
        binIns+=regtobin(rs);
        binIns+=regtobin(rd);
        binIns+=immtobin(rs2,2);
        fs<<binIns<<'\n';
      }
    }
  }
}

//Instruccion op rd,[rs],#imme (post index)
void encondig_instruccion7(std::string op,std::string rd,std::string rs,std::string rs2){
  std::string binIns="111001";
  text_memory+=0x4;
  if(op.compare("ldr")==0 || op.compare("Ldr")==0 || op.compare("LDR")==0){
    if(rs2.find("-")==std::string::npos){
      binIns+="101001";
      binIns+=regtobin(rs);
      binIns+=regtobin(rd);
      binIns+=immtobin(rs2,2);
      fs<<binIns<<'\n';
      fs<<"11100001101000000000000000000000"<<'\n';
      fs<<"11100001101000000000000000000000"<<'\n';
      fs<<"11100001101000000000000000000000"<<'\n';
    }else{
      rs2.erase(1,1);
      binIns+="100001";
      binIns+=regtobin(rs);
      binIns+=regtobin(rd);
      binIns+=immtobin(rs2,2);
      fs<<binIns<<'\n';
      fs<<"11100001101000000000000000000000"<<'\n';
      fs<<"11100001101000000000000000000000"<<'\n';
      fs<<"11100001101000000000000000000000"<<'\n';
    }
  }else if(op.compare("str")==0 || op.compare("Str")==0 || op.compare("STR")==0){
    if(rs2.find("-")==std::string::npos){
      binIns+="101000";
      binIns+=regtobin(rs);
      binIns+=regtobin(rd);
      binIns+=immtobin(rs2,2);
      fs<<binIns<<'\n';
    }else{
      rs2.erase(1,1);
      binIns+="100000";
      binIns+=regtobin(rs);
      binIns+=regtobin(rd);
      binIns+=immtobin(rs2,2);
      fs<<binIns<<'\n';
    }
  }
}

//intruccion  op rd,rs,#imme
void encondig_instruccion1(std::string op,std::string rs,std::string rd,std::string immen){
  std::string binIns="1110";
  text_memory+=0x4;
  if(op.compare("Add")==0 || op.compare("ADD")==0 || op.compare("add")==0){
    binIns+="00101000";
    binIns+=regtobin(rs);
    binIns+=regtobin(rd);
    binIns+=immtobin(immen,1);
    fs<<binIns<<'\n';
  }else if(op.compare("Sub")==0 || op.compare("sub")==0 || op.compare("SUB")==0){
    binIns+="00100100";
    binIns+=regtobin(rs);
    binIns+=regtobin(rd);
    binIns+=immtobin(immen,1);
    fs<<binIns<<'\n';
  }
}

//Conversion del numero de registro a binario
std::string regtobin(std::string r){
  r.erase(0,1);
  std::string bin=std::bitset<4>(atoi(r.c_str())).to_string();
  return bin;
}

/*int indexOf(std::string tag){
  int pos =std::find(labels.begin(),labels.end(),tag)-labels.begin();
  if (pos < labels.size()){
    return pos;
  }else{
    std::cout<<"elem not found "<<tag<<'\n';
    return -1;
  }
}*/

void variablestobin(int val){
  if(current_type.compare("DCB")==0){
    std::string bin=std::bitset<8>(val).to_string();
    if(memCount>2){
      memCount=0;
      fs2<<bin<<'\n';
    }else{
      memCount++;
      fs2<<bin;
    }
  }else if(current_type.compare("DCW")==0){
    std::string bin=std::bitset<16>(val).to_string();
    if(memCount>1){
      memCount=0;
      fs2<<bin<<'\n';
    }else{
      memCount++;
      fs2<<bin;
    }
  }else if(current_type.compare("DCD")==0){
    std::string bin=std::bitset<32>(val).to_string();
    fs2<<bin<<'\n';
  }
}

void procces_label(std::string tag,std::string g,int type){
  int tmp=futureLabels.find(tag)->second;
  if(tmp > 0){ //Se encontro una etiqueta usada por una instruccion antes de declararse
    int tposition=fs.tellp();
    int result=0x8+(0x4*tmp/33);
    std::cout<<tag<<" "<<result<<" "<<text_memory<<'\n';
    result=(text_memory-result)/4;
    fs.seekp(tmp+8);
    fs<<std::bitset<24>(result).to_string();
    fs.seekp(tposition);
  }

  if(type==1){
    labels[tag]=text_memory; //Valor de la etiqueta
  }else if(type==2){
    current_type=g;
    labels[tag]=data_memory;
  }
}

//Se guarda el inmediato en binario
//Type= De que tamaño sera el inmediato
std::string immtobin(std::string in,int type){
  in.erase(0,1);
  int x=0;
  if(in.find("0x")==std::string::npos){
    x=strtol(in.c_str(),NULL,10);
  }else{
    x=strtol(in.c_str(),NULL,16);
  }

  if(type==1){
    if(x<255){
      std::string bin="0000";
      bin+=std::bitset<8>(x).to_string();
      return bin;
    }
  }else if(type==2){
    std::string bin=std::bitset<12>(x).to_string();
    return bin;
  }else if(type==3){
    std::string bin=std::bitset<24>(x).to_string();
    return bin;
  }
}

void printt(std::string s){
  std::cout << s << std::endl;
}

void yyerror(std::string S){
  std::cout << S << std::endl;
}

int main(void) {
  std::cout<<"Ruta del archivo a compilar"<<'\n';
  fs.open ("text.txt", std::ios::out | std::ios::trunc); //Intrucciones
  fs2.open ("data.txt", std::ios::out | std::ios::trunc); //Datos
  std::cin>>ruta;
  FILE *myfile = fopen(ruta.c_str(), "r");
	//se verifica si es valido
	if (!myfile) {
		std::cout << "No es posible abrir el archivo" << std::endl;
		return -1;
	}
  fs<<"11100001101000000000000000000000"<<'\n';
	yyin = myfile;
	do {
		yyparse();
	} while (!feof(yyin));
  fs.close();
  fs2.close();
  std::cout<<"Compiler success"<<'\n';
  for(int i=0;i<100;++i);
}

