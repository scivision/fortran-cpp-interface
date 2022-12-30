module mathv

use, intrinsic:: iso_c_binding, only: c_int, C_SIZE_T

implicit none

contains

pure subroutine timestwo_f(z, z2, N) bind(c)
! elemental is not allowed with BIND(C)

integer(C_SIZE_T), intent(in) :: N
integer(c_int),intent(in) :: z(N)
integer(c_int),intent(out) :: z2(N)

z2 = 2*z

end subroutine

end module mathv
