program struct_tx

use, intrinsic :: iso_c_binding, only : c_int, c_bool, c_char, c_null_char

implicit none


type, bind(C) :: my_struct
!! order and length must match in Fortran and C
integer(c_int) :: my_int
logical(c_bool) :: my_bool
character(kind=c_char) :: my_char(1000)
!! character(kind=c_char) in bind(c) type cannot be allocatable. Just have to make it "long enough"
!! or use iso_c_binding.h stuff

end type my_struct


interface
subroutine struct_check_c(p) bind(C)
import my_struct
type(my_struct), intent(in) :: p
end subroutine

subroutine struct_check_cpp(p) bind(C)
import my_struct
type(my_struct), intent(in) :: p
end subroutine
end interface


type(my_struct) :: s
integer :: i
character(:), allocatable :: my_char

allocate(character(5) :: my_char)
my_char = "Hello"


s%my_int = 123
s%my_bool = .true.

do i = 1, len(my_char)
  s%my_char(i) = my_char(i:i)
end do
s%my_char(i+1) = c_null_char

call struct_check_c(s)
call struct_check_cpp(s)

deallocate(my_char)

print *, "OK: Fortran => C struct"
end program
