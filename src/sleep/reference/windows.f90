module sleep_std
use, intrinsic :: iso_c_binding, only : c_int, c_long
implicit none

private
public :: sleep_ms

interface
subroutine winsleep(dwMilliseconds) bind (C, name='Sleep')
!! void Sleep(DWORD dwMilliseconds)
!! https://docs.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-sleep
import c_long
integer(c_long), value, intent(in) :: dwMilliseconds
end subroutine
end interface

contains

subroutine sleep_ms(millisec)
integer, intent(in) :: millisec

call winsleep(int(millisec, c_long))

end subroutine sleep_ms

end module sleep_std
