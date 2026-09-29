module cfi_max
use, intrinsic :: iso_c_binding, only : c_int
implicit none

integer(c_int), bind(C) :: cfi_max_rank_value

end module


program get_cfi_max_rank
use cfi_max

implicit none

print '(a,1x,i0)', "CFI_MAX_RANK:", cfi_max_rank_value
end program
