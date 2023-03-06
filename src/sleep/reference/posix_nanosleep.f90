module sleep_std
!! https://man7.org/linux/man-pages/man2/nanosleep.2.html
use, intrinsic :: iso_c_binding, only : C_INT, C_LONG
implicit none

private
public :: sleep_ms


type, bind(C) :: timespec
integer(C_INT) :: tv_sec
integer(C_LONG) :: tv_nsec
end type timespec


interface
integer(C_INT) function nanosleep(request, remainder) bind(C)
!! this works on Linux, but freezes on MacOS and MinGW
import C_INT, timespec
type(timespec), intent(in) :: request
type(timespec), intent(out) :: remainder
end function
end interface

contains

subroutine sleep_ms(millisec)
integer, intent(in) :: millisec
integer(C_INT) :: ierr

type(timespec) :: request, remainder

request%tv_sec = int(millisec / 1000, C_INT)
request%tv_nsec = int(modulo(millisec, 1000), C_LONG) * 1000000

ierr = nanosleep(request, remainder)
if (ierr /= 0) error stop 'problem with nanosleep() system call'

end subroutine sleep_ms

end module sleep_std
