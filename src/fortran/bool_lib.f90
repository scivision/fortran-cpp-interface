module logbool

use, intrinsic :: iso_c_binding, only : c_bool

implicit none (type, external)

contains

logical(c_bool) function logical_not(L) bind(C)

logical(c_bool), intent(in), value :: L
logical :: byte_default

logical_not = .not. L

print '(a,i0,1x,i0)', "C, Fortran logical bits: ", storage_size(L), storage_size(byte_default)

end function logical_not

end module logbool
