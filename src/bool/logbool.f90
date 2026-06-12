module logbool

use, intrinsic :: iso_c_binding, only : C_BOOL, C_INT

implicit none

contains

logical(c_bool) function logical_not(L, dummy) bind(C)

logical(c_bool), intent(in), value :: L
integer(c_int), intent(in) :: dummy

logical_not = .not. L

print '(/, a, l1, a, l1)', "logical_not(", L, "): ", logical_not

print '(a16,2x,a,2x,a8,2x,a8)', "storage_size()", "bits", "hex(in)", "hex(out)"
print '(a16,2x,i3,2x,z8,2x,z8)', "C_BOOL: ", storage_size(L), L, logical_not

if (dummy /= 42_c_int) error stop "dummy argument should be 42"
! print '(a)', "logical_not passed dummy argument correctly"

end function logical_not


logical(C_BOOL) function bool_passthru(L, dummy) bind(C)
logical(C_BOOL), intent(in), value :: L
integer(C_INT), intent(in) :: dummy
if (dummy /= 42_C_INT) error stop "dummy argument should be 42"
bool_passthru = L
end function bool_passthru


logical(C_BOOL) function bool_true() bind(C)
bool_true = .true._C_BOOL
end function

logical(C_BOOL) function bool_false() bind(C)
bool_false = .false._C_BOOL
end function

end module logbool
