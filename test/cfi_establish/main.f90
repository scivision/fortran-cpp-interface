!! https://fortran-lang.discourse.group/t/experiment-dealing-with-a-pointer-to-a-string-from-c/930/3
program string

use, intrinsic :: iso_c_binding, only : c_int, c_char
implicit none

interface
integer(c_int) function getstr( str ) bind(C, name="getstr")
  import :: c_int, c_char
  character(kind=c_char, len=:), pointer, intent(out) :: str
end function
end interface

character(kind=c_char, len=:), pointer :: s
integer(c_int) :: irc

irc = getstr( s )
if ( irc == 0 ) then
   print *, "s: ", s, "; expected is Hello"
   print *, "len: ", len(s), "; expected is 5"
else
   print *, "getstr function returned an error."
end if

end program
