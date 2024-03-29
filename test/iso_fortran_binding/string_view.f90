!! https://fortran-lang.discourse.group/t/passing-strings-to-c-functions-without-copying/2842/3
program string_view

use, intrinsic :: iso_c_binding, only : c_char

implicit none

interface
subroutine echo_c( str ) bind(C)
import :: c_char
character(kind=c_char, len=:), allocatable, intent(in) :: str
end subroutine
end interface

character(kind=c_char, len=:), allocatable :: s

s = c_char_"Hello World!"

call echo_c( s )

end program
