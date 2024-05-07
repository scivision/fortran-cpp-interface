module logbool

use, intrinsic :: iso_c_binding, only : C_BOOL, C_INT

implicit none

contains

logical(c_bool) function logical_not(L) bind(C)

logical(c_bool), intent(in), value :: L

logical :: Ld
integer :: i
integer(C_INT) :: ic

character(*), parameter :: fmt = '(a16,2x,i3,2x,z8)'

!> avoid uninitialized variable warning
i = 0
ic = 0
Ld = .false.

!> workaround for nvfortran 24.3 etc.
!! nvfortran reference guide:
!! The logical constants .TRUE. and .FALSE. are defined to be the four-byte values -1 and 0 respectively.
!! A logical expression is defined to be .TRUE. if its least significant bit is 1 and .FALSE. otherwise.
!if(L) then
!  logical_not = .false._C_BOOL
!else
!  logical_not = .true._C_BOOL
!endif

logical_not = .not. L

print '(/, a, l1, a, l1)', "logical_not(", L, "): ", logical_not


print '(a16,2x,a,2x,a8)', "storage_size()", "bits", "hex"
print fmt, "logical:", storage_size(Ld), Ld
print fmt, "C_BOOL: ", storage_size(L), L
print fmt, "integer: ", storage_size(i), i
print fmt, "C_INT: ", storage_size(ic), ic

end function logical_not


logical(C_BOOL) function bool_true() bind(C)
bool_true = .true._C_BOOL
end function

logical(C_BOOL) function bool_false() bind(C)
bool_false = .false._C_BOOL
end function

end module logbool
