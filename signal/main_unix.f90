program wait_for_SIGTERM
use, intrinsic :: ISO_C_binding

use c_interface

implicit none (type, external)

logical, volatile :: interface_SIGTERM, interface_SIGUSR1

call init

do while( .not. interface_SIGTERM)
enddo

contains

subroutine init()

call signalterm_c(c_funloc(catchSIGTERM))
call signalusr1_c(c_funloc(catchSIGUSR1))
call interface_setSIGTERM(.false.)
call interface_setSIGUSR1(.false.)

end subroutine init

subroutine catchSIGTERM(signal) bind(C)
!! Set global variable interface_SIGTERM to .true.
!! details This function can be registered to catch signals send to the executable.
integer(C_INT), value :: signal


print'(a,i0)', ' received signal ',signal
call interface_setSIGTERM(.not. interface_SIGTERM)

end subroutine catchSIGTERM


subroutine catchSIGUSR1(signal) bind(C)
!! Set global variable interface_SIGUSR1 to .true.
!! This function can be registered to catch signals send to the executable.
integer(C_INT), value :: signal

print'(a,i0)', ' received signal ',signal
call interface_setSIGUSR1(.not. interface_SIGUSR1)

end subroutine catchSIGUSR1


subroutine interface_setSIGTERM(state)
!! Set global variable interface_SIGTERM.
logical, intent(in) :: state


interface_SIGTERM = state
print*, 'set SIGTERM to',state

end subroutine interface_setSIGTERM


subroutine interface_setSIGUSR1(state)
!! Set global variable interface_SIGUSR.
logical, intent(in) :: state


interface_SIGUSR1 = state
print*, 'set SIGUSR1 to',state

end subroutine interface_setSIGUSR1

end program
