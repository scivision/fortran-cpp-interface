program contiguous_bad

use, intrinsic :: iso_c_binding, only : C_FLOAT
use contig, only : fcheck

implicit none

real(C_FLOAT), target :: a(3) = [1.0_C_FLOAT, 2.0_C_FLOAT, 3.0_C_FLOAT]

call fcheck(a(1:3:2))

end program