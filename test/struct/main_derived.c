// c program that calls the Fortran subroutine with struct argument, f2008 C.11.3
// https://www.hpe.com/psnow/resources/ebooks/a00113908en_us_v2/Interlanguage_Communication.html
//*********************************************************************
#include <stdio.h>
#include <stdlib.h>

  //  declare the structure type
struct passer {
int lenc, lenf;
float *c, *f;
};

  //  prototype for the Fortran function
void simulation(long alpha, double *beta, long *gamma, double delta[], struct passer *arrays);

//  program that calls the Fortran subroutine
int main(void)
{
  int i;
  long alpha, gamma;
  double beta, delta[100];
  struct passer arrays;

  alpha = 1234L;
  gamma = 5678L;
  beta = 12.34;
  for(i=0; i<100; i++ ) {
     delta[i] = i+1;
  }

  //  fill in some of the structure
  arrays.lenc = 100;
  arrays.lenf = 0;
  arrays.c = (float *) malloc( 100*sizeof(float) );
  arrays.f = NULL;
  for(i=0; i<100; i++ ) {
     arrays.c[i] = (float) 2*(i+1);
  }

  //  reference the Fortran subroutine
  simulation(alpha, &beta, &gamma, delta, &arrays);

  printf(" After simulation\n");
  printf("   alpha: %ld, beta: %f\n", alpha, beta );
  printf("   gamma: %ld\n", gamma );
  printf("   arrays.lenc: %d\n", arrays.lenc);
  printf("   arrays.c[0],[arrays.lenc-1],: %f, %f\n", arrays.c[0], arrays.c[arrays.lenc-1]);
  printf("   arrays.lenf: %d\n", arrays.lenf);
  printf("   arrays.f[0],[arrays.lenf-1],: %f, %f\n", arrays.f[0], arrays.f[arrays.lenf-1]);

}
