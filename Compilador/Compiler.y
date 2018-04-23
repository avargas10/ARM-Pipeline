%{

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

%}

%union{
  char* id;
  int num;
}
//lex tokens
%token <id> addition subtra multiple comp load store branch braneq branne mv
%token <id> dcb dcw dcd
%token <id> reg
%token <id> immediate
%token <id> label
%token <id> commentary
%token <num> number
//yacc tokens
%type <id> operation val_type
%%

line   : line variable '\n'
       | line instruccion '\n'
       | line label '\n'  {procces_label($2,"",1);}
       | line label instruccion '\n'  {procces_label($2,"",1);}
       | line commentary '\n'
       | line label commentary '\n'  {procces_label($2,"",1);}
       | line variable commentary '\n'
       | /* NULL */
      ;

instruccion : operation reg ',' reg {encondig_instruccion2($1,$4,$2);}
            | operation reg ',' immediate {encondig_instruccion3($1,$2,$4);}
            | operation label {encondig_instruccion5($1,$2);}
            | operation reg ',' '=' label  {encondig_instruccion4($1,$2,$5);}
            | operation reg ',' reg ',' immediate {encondig_instruccion1($1,$4,$2,$6);}
            | operation reg ',' '[' reg ']' {encondig_instruccion6($1,$2,$5,"",1);}
            | operation reg ',' '[' reg ',' reg ']' {encondig_instruccion6($1,$2,$5,$7,2);}
            | operation reg ',' '[' reg ',' immediate ']' {encondig_instruccion6($1,$2,$5,$7,3);}
            | operation reg ',' '[' reg ']' ',' immediate {encondig_instruccion7($1,$2,$5,$8);}
            | operation reg ',' '[' reg ',' immediate ']' '!' {encondig_instruccion6($1,$2,$5,$7,4);}
            | operation reg ',' reg ',' reg {encondig_instruccion($1,$4,$6,$2);}
            | instruccion commentary {;}
            | error {yyerror("2, instruccion wrong");}
            ;

variable  : label val_type array {procces_label($1,$2,2);}
          ;
array     : number  {variablestobin($1);}
          | array ',' number {variablestobin($3);}

val_type  : dcb     {$$=$1;}
          | dcw   {$$=$1;}
          | dcd   {$$=$1;}
          ;

operation : addition     {;}
          | subtra       {;}
          | multiple     {;}
          | comp        {;}
          | store       {;}
          | load        {;}
          | branch      {;}
          | braneq     {;}
          | branne     {;}
          | mv       {;}
          ;

%%

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
