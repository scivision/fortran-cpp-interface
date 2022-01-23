module str_mod

use iso_c_binding, only: c_ptr, c_int, c_f_pointer, c_loc, c_null_char

implicit none

contains

subroutine print_cstring_array(n, cstring) bind(C)

integer(kind=c_int),               intent(in) :: n
type(c_ptr), dimension(n), target, intent(in) :: cstring
character, pointer :: fstring(:)
integer :: i

do i = 1, n
  call c_f_pointer(cstring(i), fstring, [4])
  write(*,*) fstring
end do

end subroutine print_cstring_array

end module str_mod
