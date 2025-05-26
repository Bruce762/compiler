flex cal.l                 
yacc -d cal.y                 
gcc -c lex.yy.c -o lex.yy.o
gcc -c y.tab.c -o y.tab.o  
gcc lex.yy.o y.tab.o -o yacc
./yacc < input.txt