program wait_for_SIGTERM
use, intrinsic :: ISO_C_binding

use c_interface

implicit none (type, external)

logical, volatile :: interface_SIGTERM

call init

do while( .not. interface_SIGTERM)


enddo

contains

subroutine init()

call signalterm_c(c_funloc(catchSIGTERM))
call interface_setSIGTERM(.false.)

end subroutine init

subroutine catchSIGTERM(signal) bind(C)
!! Set global variable interface_SIGTERM to .true.
!! details This function can be registered to catch signals send to the executable.
integer(C_INT), value :: signal


print'(a,i0)', ' received signal ',signal
call interface_setSIGTERM(.not. interface_SIGTERM)

end subroutine catchSIGTERM


subroutine interface_setSIGTERM(state)
!! Set global variable interface_SIGTERM.
logical, intent(in) :: state


interface_SIGTERM = state
print*, 'set SIGTERM to',state

end subroutine interface_setSIGTERM


end program
