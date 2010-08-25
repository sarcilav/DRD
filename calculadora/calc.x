struct in{
       int a;
       int b;
};

program CALCPROG {
	version CALCVER {
		int sumar(in)		= 0;
		int restar(in)		= 1;
		int multiplicar(in)	= 2;
		int dividir(in)		= 3;
	} = 1;
} = 0x30000001;