program error_cpp

use, intrinsic :: iso_c_binding, only: C_INT

implicit none

interface
subroutine err_div0(i) bind(C)
import
integer(C_INT), intent(in), value :: i
end subroutine
end interface

call err_div0(0)

end program
