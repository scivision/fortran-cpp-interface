module C_bounds

use, intrinsic :: iso_c_binding
use, intrinsic :: iso_fortran_env, only : error_unit

implicit none

interface
logical(C_BOOL) function c_bounder(a, fl, fu) bind(c, name="c_bounder")
import :: c_float, c_int64_t, C_BOOL
real(c_float), intent(inout) :: a(:)
integer(c_int64_t), value :: fl, fu
end function

logical(C_BOOL) function c_bounder_2d(a, fl1, fu1, fl2, fu2) bind(c, name="c_bounder_2d")
import :: c_float, c_int64_t, C_BOOL
real(c_float), intent(inout) :: a(:,:)
integer(c_int64_t), value :: fl1, fu1, fl2, fu2
end function
end interface

private
public :: c_bounder, c_bounder_2d, check_bounds

contains

subroutine check_bounds(a, label, expected_l, expected_u)
real, allocatable, intent(in) :: a(:)
character(*), intent(in) :: label
integer, intent(in) :: expected_l, expected_u
integer :: l, u

l = lbound(a,1)
u = ubound(a,1)

if (l /= expected_l .or. u /= expected_u) then
    write(error_unit, '(a,": FAIL got [",i0,":",i0,"] expected [",i0,":",i0,"]")') &
        label, l, u, expected_l, expected_u
    error stop "Fortran bounds corrupted"
end if
end subroutine

end module
