module bad_bool

use, intrinsic :: iso_c_binding, only : C_INT

implicit none

contains

logical function logical_not(L, dummy) bind(C)
logical, intent(in), value :: L
integer(C_INT), intent(in) :: dummy

logical_not = .not. L

print '(/, a, l1, a, l1)', "logical_not(", L, "): ", logical_not

print '(a16,2x,a,2x,a8,2x,a8)', "storage_size()", "bits", "hex(in)", "hex(out)"
print '(a16,2x,i3,2x,z8,2x,z8)', "C_BOOL: ", storage_size(L), L, logical_not

if (dummy /= 42_C_INT) error stop "dummy argument should be 42"

end function logical_not

logical function bool_passthru(L, dummy) bind(C)
logical, intent(in), value :: L
integer(C_INT), intent(in) :: dummy
if (dummy /= 42_C_INT) error stop "dummy argument should be 42"
bool_passthru = L
end function bool_passthru


logical function bool_true() bind(C)
bool_true = .true.
end function

logical function bool_false() bind(C)
bool_false = .false.
end function

end module
