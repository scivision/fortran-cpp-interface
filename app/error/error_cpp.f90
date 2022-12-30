program error_cpp

use, intrinsic :: iso_c_binding, only: C_INT

implicit none

interface
subroutine err_cpp(code) bind(C)
import
integer(C_INT), intent(in), value :: code
end subroutine err_cpp
end interface

call err_cpp(42)

end program
