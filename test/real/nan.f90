module mod

use, intrinsic :: iso_c_binding, only : C_DOUBLE, C_FLOAT, C_BOOL
use, intrinsic :: ieee_arithmetic, only : ieee_is_nan

implicit none

contains

logical(C_BOOL) function is_nan(x) result(r) bind(C)
real(C_DOUBLE), intent(in) :: x
r = x /= x
end function

logical(C_BOOL) function is_ieee_nan(x) result(r) bind(C)
real(C_DOUBLE), intent(in) :: x
r = ieee_is_nan(x)
end function

end module
