module sleep_std

use, intrinsic :: iso_c_binding, only : C_INT

implicit none

private
public :: sleep_ms

interface
subroutine c_sleep(millseconds) bind(C, name="c_sleep")
import C_INT
integer(C_INT), intent(in), value :: millseconds
end subroutine
end interface

contains

subroutine sleep_ms(millseconds)
integer(C_INT), intent(in) :: millseconds
call c_sleep(millseconds)
end subroutine sleep_ms

end module sleep_std
