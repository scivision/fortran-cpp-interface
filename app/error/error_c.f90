program error_c

use, intrinsic :: iso_c_binding, only: C_INT

implicit none

interface
subroutine err_c(code) bind(C)
import
integer(C_INT), intent(in), value :: code
end subroutine
end interface

call err_c(42)

end program
