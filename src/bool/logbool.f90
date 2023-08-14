module logbool

use, intrinsic :: iso_c_binding, only : C_BOOL, C_INT

implicit none

contains

logical(c_bool) function logical_not(L) bind(C)

logical(c_bool), intent(in), value :: L

logical_not = .not. L

print '(a,20x,a)', "storage_size() ", "bits"
print '(a35,i0)', "Fortran: storage_size(logical): ", storage_size(L)
print '(a35,i0)', "C/C++: storage_size(C_BOOL): ", storage_size(.false.)
print '(a35,i0)', "Fortran: storage_size(integer): ", storage_size(1)
print '(a35,i0)', "C/C++: storage_size(C_INT): ", storage_size(1_c_int)

end function logical_not

end module logbool
