module opaque

use, intrinsic :: iso_c_binding, only : C_PTR, c_loc, c_f_pointer

implicit none

type :: mytype
  integer :: secret
end type mytype

contains

subroutine init_opaque(my)
type(mytype), intent(out) :: my
my%secret = 42
end subroutine


subroutine use_opaque(my)
type(mytype), intent(in) :: my
if (my%secret /= 42) error stop "opaque not initialized"
end subroutine

!> C shims

subroutine init_opaque_C(myC) bind(C, name="init_opaque_C")

type(C_PTR), intent(out) :: myC
type(mytype), pointer :: my

allocate(my)
!! Note: allocate is necessary or heap error results
myC = c_loc(my)

call init_opaque(my)

! print *, "Fortran:init_opaque_C: my%secret=", my%secret
end subroutine


subroutine use_opaque_C(myC) bind(C, name="use_opaque_C")
type(C_PTR), intent(in) :: myC
type(mytype), pointer :: my

call c_f_pointer(myC, my)
call use_opaque(my)
end subroutine


subroutine destruct_C(myC) bind(C, name="destruct_C")
type(C_PTR), intent(inout) :: myC
type(mytype), pointer :: my

call c_f_pointer(myC, my)
deallocate(my)
end subroutine

end module opaque
