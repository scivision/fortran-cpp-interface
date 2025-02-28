program main

use, intrinsic :: iso_c_binding

implicit none

interface
  function nullchar(b) bind(C)
    import
    logical(c_bool), value :: b
    type(C_PTR) :: nullchar
  end function
end interface

integer, parameter :: n = 5
character(n) :: s

logical(C_BOOL), parameter :: t = .true., f = .false.

type(c_ptr) :: ptr

if (.not. c_associated(nullchar(f))) error stop "nullptr should not be detected"

ptr = nullchar(t)
if (c_associated(ptr)) error stop "nullptr not detected"

! for simplicity, assume we know strlen is 5.
block
  character(kind=c_char), pointer :: c_string(:)
  integer :: i

  s = "" !< ensure s has no garbage characters

  ptr = nullchar(f)
  call c_f_pointer(ptr, c_string, [n])
  do i = 1, n
    s(i:i) = c_string(i)
  end do
end block

print '(a)', s

end program
