!! This example is overly complicated way to do this task,
!! but it's just to show how c_f_pointer() can work, although it would normally be for more advanced
!! use cases as this task could be done like vector_lib.f90.
module p

use, intrinsic :: iso_c_binding, only : C_FLOAT, C_SIZE_T, C_PTR, c_f_pointer, c_associated
implicit none

contains

subroutine point23(p1, b, N) bind(C)

type(C_PTR), value, intent(in) :: p1
real(C_FLOAT), intent(out) :: b(2)
integer(C_SIZE_T), intent(in) :: N

real(C_FLOAT), pointer :: D(:)

call c_f_pointer(p1, D, [N])

if(.not. C_associated(p1)) error stop "input pointer not C associated"
if(.not. associated(D)) error stop "data array pointer not associated"

B = D(2:3)

end subroutine point23

end module p
