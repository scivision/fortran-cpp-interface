module four

use, intrinsic:: iso_c_binding, only: c_int
use base_mod, only: base

implicit none (type, external)


type, extends(base) :: vfour
  integer(c_int) :: B

  contains

  procedure :: init
  final :: destructor
end type vfour

contains


subroutine init(self)
  class(vfour), intent(inout) :: self

  self%A = 4
  self%B = 4

  call self%alloc()
end subroutine init


subroutine destructor(self)
  type(vfour), intent(inout) :: self

  call self%destructor()
end subroutine destructor

end module four
