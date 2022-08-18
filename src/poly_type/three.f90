module three

use base_mod, only: base

use, intrinsic:: iso_c_binding, only: c_int

implicit none

type, extends(base) :: vthree
  integer(c_int) :: B

  contains

  procedure :: init
  final :: destructor
end type vthree


contains

subroutine init(self)
  class(vthree), intent(inout) :: self

  self%A = 3
  self%B = 3

  call self%alloc()
end subroutine init


subroutine destructor(self)
  type(vthree), intent(inout) :: self

  call self%destructor()
end subroutine destructor


end module three
