module logbool

use, intrinsic :: iso_c_binding, only : C_BOOL, C_INT

implicit none

contains

logical(c_bool) function logical_not(L) bind(C)

logical(c_bool), intent(in), value :: L

logical :: Ld
integer :: i
integer(C_INT) :: ic

!> avoid uninitialized variable warning
i = 0
ic = 0
Ld = .false.

logical_not = .not. L

print '(/, a, l1, a, l1)', "logical_not(", L, "): ", logical_not

print '(a,1x,a)', "storage_size()", "bits"
print '(a15,i0)', "logical: ", storage_size(Ld)
print '(a15,i0)', "C_BOOL: ", storage_size(L)
print '(a15,i0)', "integer: ", storage_size(i)
print '(a15,i0)', "C_INT: ", storage_size(ic)

end function logical_not


logical(C_BOOL) function bool_true() bind(C)
bool_true = .true._C_BOOL
end function

logical(C_BOOL) function bool_false() bind(C)
bool_false = .false._C_BOOL
end function

end module logbool
