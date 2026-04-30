program c

use, intrinsic :: iso_c_binding
use, intrinsic :: iso_fortran_env

implicit none

interface
character(kind=C_CHAR, len=1) function three() bind(C)
import C_CHAR
end function
end interface

character(kind=C_CHAR) :: fc

fc = three()

print '(i0,1x,a)', len_trim(fc), fc

if (fc /= C_CHAR_"3" .or. len_trim(fc) /= 1) then
  write(error_unit, '(a,i0)') "ERROR: unexpected result from C function: " // fc // " length ", len_trim(fc)
  error stop
end if

end program
