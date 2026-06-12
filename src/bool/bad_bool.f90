module bad_bool

use, intrinsic :: iso_c_binding, only : C_INT
use, intrinsic :: iso_fortran_env, only : error_unit

implicit none

include "logical_kind.inc"

type, bind(C) :: bool_args
	logical(lk) :: value
	integer(C_INT) :: dummy
end type

contains

logical function logical_not(args) bind(C)
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

logical function bool_passthru(args) bind(C)
type(bool_args), intent(in), value :: args
if (args%dummy /= 42_C_INT) then
    write(error_unit, '(a,i0,a)') "bool_passthru passed dummy argument ", args%dummy, " but expected 42"
    error stop
end if
bool_passthru = args%value
end function bool_passthru


logical function bool_true() bind(C)
bool_true = .true.
end function

logical function bool_false() bind(C)
bool_false = .false.
end function

end module
