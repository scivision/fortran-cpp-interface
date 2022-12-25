module struct_rx

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


contains


pure subroutine struct_check(s) bind(C)

type(my_struct), intent(in) :: s

character(:), allocatable :: my_char

if(s%my_int /= 123) error stop "my_int /= 123"
if(.not. s%my_bool) error stop "my_bool /= .true."

block
  character(size(s%my_char)) :: buf
  integer :: i
  buf = "" !< ensure buf has no garbage characters

  do i = 1, len(buf)
    if (s%my_char(i) == c_null_char) exit
    buf(i:i) = s%my_char(i)
  enddo
  allocate(character(len_trim(buf)) :: my_char)
  my_char = trim(buf)
end block

if(my_char /= "Hello") error stop "my_char /= 'Hello'"

end subroutine struct_check


end module struct_rx
