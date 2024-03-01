program c

use, intrinsic :: iso_c_binding
use, intrinsic :: iso_fortran_env

implicit none

interface
character(kind=c_char) function three() bind(C)
import
end function
end interface

character :: fc

fc = three()

print '(i0,1x,a)', len_trim(fc), fc

if (fc /= "3" .or. len_trim(fc) /= 1) error stop "ERROR: unexpected result from C function"

end program
