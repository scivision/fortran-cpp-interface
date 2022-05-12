module clock

use, intrinsic :: iso_c_binding, only : C_LONG_LONG

implicit none (type, external)

contains

integer(C_LONG_LONG) function ticker() bind(C)

integer(C_LONG_LONG) :: rate, tic, toc

call system_clock(count_rate=rate)
!! sets maximum precision

call system_clock(tic)
call system_clock(toc)

ticker = toc - tic

end function ticker

end module clock
