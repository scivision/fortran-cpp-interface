module logbool

use, intrinsic :: iso_c_binding
use, intrinsic :: iso_fortran_env

implicit none

type, bind(C) :: bool_args
	logical(C_BOOL) :: value
	integer(C_INT) :: dummy
end type

contains

logical(C_BOOL) function logical_not(args) bind(C)
type(bool_args), intent(in), value :: args

logical_not = .not. args%value

print '(/, a, l1, a, l1)', "logical_not(", args%value, "): ", logical_not

print '(a16,2x,a,2x,a8,2x,a8)', "storage_size()", "bits", "hex(in)", "hex(out)"
print '(a16,2x,i3,2x,z8,2x,z8)', "C_BOOL: ", storage_size(args%value), args%value, logical_not

if (args%dummy /= 42_C_INT) then
    write(error_unit, '(a,i0,a)') "bool_passthru passed dummy argument ", args%dummy, " but expected 42"
    error stop
end if

end function logical_not


logical(C_BOOL) function bool_passthru(args) bind(C)
type(bool_args), intent(in), value :: args
if (args%dummy /= 42_C_INT) then
    write(error_unit, '(a,i0,a)') "bool_passthru passed dummy argument ", args%dummy, " but expected 42"
    error stop
end if
bool_passthru = args%value
end function bool_passthru


logical(C_BOOL) function bool_true() bind(C)
bool_true = .true._C_BOOL
end function

logical(C_BOOL) function bool_false() bind(C)
bool_false = .false._C_BOOL
end function

end module
