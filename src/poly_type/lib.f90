module poly_type

use, intrinsic :: iso_c_binding, only : C_PTR, c_loc, c_int, c_f_pointer, c_associated

implicit none (type, external)

type, abstract :: base

  integer(c_int) :: A, C

  contains

  procedure(constructor), deferred :: init

end type base

type, extends(base) :: vthree
  integer(c_int) :: B

  contains
  procedure :: init => init_three
end type vthree

type, extends(base) :: vfour
  integer(c_int) :: B
  contains
  procedure :: init => init_four
end type vfour


abstract interface
  subroutine constructor(self)
    import base
    class(base), intent(inout) :: self
  end subroutine constructor
end interface

contains


subroutine init_type(xtype, xC) bind(C)
  integer(c_int) :: xtype
  type(C_PTR), intent(inout) :: xC

  class(base), pointer :: x
  type(vthree), pointer :: three
  type(vfour), pointer :: four

  select case (xtype)
  case (3)
    allocate(three)
    if(.not.associated(three)) error stop "three not associated with Fortran"
    xC = c_loc(three)
    if (.not. c_associated(xC)) error stop "three not associated with C"
    x=>three
    if(.not.associated(x, three)) error stop "x Fortran pointer not associated"
  case (4)
    allocate(four)
    xC = c_loc(four)
    x=>four
  case default
    error stop "unknown init type"
  end select

  x%C = 0

  call x%init()

end subroutine init_type


subroutine init_three(self)
  class(vthree), intent(inout) :: self

  self%B = 3
end subroutine


subroutine init_four(self)
  class(vfour), intent(inout) :: self

  self%B = 4
end subroutine


function assoc_type(xtype, xC) result(x)
  integer(c_int) :: xtype
  type(C_PTR), intent(inout) :: xC

  class(base), pointer :: x
  type(vthree), pointer :: three
  type(vfour), pointer :: four

  select case (xtype)
  case (3)
    call c_f_pointer(xC, three)
    x=>three
  case (4)
    call c_f_pointer(xC, four)
    x=>four
  case default
    error stop "unknown assoc type"
  end select

end function assoc_type


subroutine add_one_C(xtype, xC, val, accum) bind(C, name='add_one_C')
  integer(c_int), intent(in) :: xtype
  type(C_PTR), intent(inout) :: xC
  integer(c_int), intent(out) :: val, accum

  class(base), pointer :: x


  x => assoc_type(xtype, xC)

  select type (x)
  type is (vthree)
    call add_one3(x)
  type is (vfour)
    call add_one4(x)
  class default
    error stop "unknown add type"
  end select

  val = x%A
  accum = x%C

end subroutine add_one_C


subroutine add_one3(x)
  class(vthree), intent(inout) :: x

  x%A = x%B + 1

  x%C = x%C + x%A
end subroutine add_one3

subroutine add_one4(x)
  class(vfour), intent(inout) :: x

  x%A = x%B + 1

  x%C = x%C + x%A
end subroutine add_one4


end module poly_type
