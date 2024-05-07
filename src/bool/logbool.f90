module logbool

use, intrinsic :: iso_c_binding, only : C_BOOL, C_INT

implicit none

contains

logical(c_bool) function logical_not(L) bind(C)

logical(c_bool), intent(in), value :: L

!! The logical constants .TRUE. and .FALSE. are defined to be the four-byte values -1 and 0 respectively.
!! A logical expression is defined to be .TRUE. if its least significant bit is 1 and .FALSE. otherwise.

logical_not = .not. L

print '(/, a, l1, a, l1)', "logical_not(", L, "): ", logical_not


print '(a16,2x,a,2x,a8,2x,a8)', "storage_size()", "bits", "hex(in)", "hex(out)"
print '(a16,2x,i3,2x,z8,2x,z8)', "C_BOOL: ", storage_size(L), L, logical_not

end function logical_not


logical(C_BOOL) function bool_true() bind(C)
bool_true = .true._C_BOOL
end function

logical(C_BOOL) function bool_false() bind(C)
bool_false = .false._C_BOOL
end function

end module logbool
