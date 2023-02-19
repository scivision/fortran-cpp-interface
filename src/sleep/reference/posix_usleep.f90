module sleep_std
use, intrinsic :: iso_c_binding, only : C_INT, C_LONG
implicit none

private
public :: sleep_ms


interface
integer(C_INT) function usleep(usec) bind (C)
!! int usleep(useconds_t usec);
!! https://linux.die.net/man/3/usleep
import C_INT
integer(C_INT), value, intent(in) :: usec
end function
end interface

contains

subroutine sleep_ms(millisec)
integer, intent(in) :: millisec
integer(C_INT) :: ierr

ierr = usleep(int(millisec * 1000, C_INT))
if (ierr /= 0) error stop 'problem with usleep() system call'
end subroutine sleep_ms

end module sleep_std
