#include <stdio.h>

#if defined(HAVE_NANOSLEEP)
#include <time.h>
#include <errno.h>
#elif defined(_WIN32)
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#endif

#include "sleep.h"


// https://docs.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-sleep
void c_sleep(const int milliseconds)
{

  if (milliseconds <= 0){
    fprintf(stderr, "ERROR:sleep: milliseconds must be strictly positive\n");
    return;
  }

#if defined(HAVE_NANOSLEEP)
// https://linux.die.net/man/3/usleep
//int ierr = usleep(*milliseconds * 1000);

  struct timespec t;

  t.tv_sec = milliseconds / 1000;
  t.tv_nsec = (milliseconds % 1000) * 1000000;

  int ierr = nanosleep(&t, NULL);
  if (ierr == 0)
    return;

  switch(errno){
    case EINTR:
    fprintf(stderr, "nanosleep interrupted\n");
    break;
    case EINVAL:
    fprintf(stderr, "nanosleep invalid timespec value (EINVAL)\n");
    break;
    case EFAULT:
    fprintf(stderr, "nanosleep timespec points outside accessible address space (EFAULT)\n");
    break;
    case ENOSYS:
    fprintf(stderr, "nanosleep not supported on this system\n");
    break;
    default:
    fprintf(stderr, "nanosleep error\n");
    break;
  }
#elif defined(_WIN32)
  Sleep(milliseconds);
#else
#error "No nanosleep implementation available for this platform"
#endif

}
