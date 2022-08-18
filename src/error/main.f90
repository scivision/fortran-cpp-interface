program error_c

use, intrinsic :: iso_c_binding, only: C_INT

implicit none

interface
subroutine err(code) bind(C)
import
integer(C_INT), intent(in), value :: code
end subroutine err
end interface

call err(42)

end program
