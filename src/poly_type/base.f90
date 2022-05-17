module base_mod

use, intrinsic:: iso_c_binding, only: c_int

type, abstract :: base

  integer(c_int) :: A, C
  integer(c_int), pointer, dimension(:) :: D

  contains

  procedure(constructor), deferred :: init
  procedure :: alloc
  procedure :: destructor

end type base


abstract interface
  subroutine constructor(self)
    import base
    class(base), intent(inout) :: self
  end subroutine constructor
end interface


contains


subroutine alloc(self)
  class(base), intent(inout) :: self

  allocate(self%D(self%A))
end subroutine alloc


subroutine destructor(self)
  class(base), intent(inout) :: self

  if(associated(self%D)) then
    print *, "deallocating D"
    deallocate(self%D)
  else
    print *, "D was not allocated"
  endif

end subroutine destructor

end module base_mod
