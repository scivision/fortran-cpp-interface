#include <stdio.h>

#ifdef _MSC_VER
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#else
#include <time.h>
#include <errno.h>
#endif

#include "sleep.h"


// https://docs.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-sleep
void c_sleep(const int milliseconds)
{

#ifdef _MSC_VER
  Sleep(milliseconds);
#else
// https://linux.die.net/man/3/usleep
  if (milliseconds <= 0){
    fprintf(stderr, "ERROR:sleep: milliseconds must be strictly positive\n");
    return;
  }

  //int ierr = usleep(*milliseconds * 1000);

  struct timespec t;

  t.tv_sec = milliseconds / 1000;
  t.tv_nsec = (milliseconds % 1000) * 1000000;

  int ierr = nanosleep(&t, NULL);
  if (ierr == 0)
    return;

  switch(errno){
    case EINTR:
    fprintf(stderr, "nanosleep() interrupted\n");
    break;
    case EINVAL:
    case EFAULT:
    fprintf(stderr, "nanosleep() bad milliseconds value\n");
    break;
    case ENOSYS:
    fprintf(stderr, "nanosleep() not supported on this system\n");
    break;
    default:
    fprintf(stderr, "nanosleep() error\n");
    break;
  }
#endif

}
