#include <signal.h>

void signalterm_c(void (*handler)(int)){
  signal(SIGTERM, handler);
}

#ifndef __WIN32__
void signalusr1_c(void (*handler)(int)){
  signal(SIGUSR1, handler);
}
#endif
