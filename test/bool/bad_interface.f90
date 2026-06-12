! This shows a common mistake to fail to specify C_BOOL in the interface, which in general mismatches the size of the logical type and causes warnings about mismatched types.  This test should

program bad_interface

use, intrinsic ::iso_c_binding, only : C_BOOL, C_INT

implicit none

interface
logical(C_BOOL) function logical_not(a, dint) bind(C)
import C_INT, C_BOOL
logical, intent(in), value :: a
integer(C_INT), intent(in) :: dint
end function

logical(C_BOOL) function bool_passthru(a, dint) bind(C)
import C_INT, C_BOOL
logical, intent(in), value :: a
integer(C_INT), intent(in) :: dint
end function
end interface

logical :: tc, fc
logical :: t0, f0, t1, f1
!! show there's no warnings

logical :: true_f, false_f

t0 = .true.
f0 = .false.
tc = t0
fc = f0
t1 = tc
f1 = fc

if (.not. t1) error stop "logical(C_BOOL) .true. should be .true."
if (.not. t1 .eqv. t0) error stop "logical(C_BOOL) .true. should EQV .true."
if (f1) error stop "logical(C_BOOL) .false. should be .false."
if(.not. f1 .eqv. f0) error stop "logical(C_BOOL) .false. should EQV .false."

false_f = logical_not(tc, 42_C_INT)
true_f = logical_not(fc, 42_C_INT)

if (false_f) error stop "logical_not(.true.) should be .false."
if (.not. true_f) error stop "logical_not(.false.) should be .true."

false_f = bool_passthru(fc, 42_C_INT)
true_f = bool_passthru(tc, 42_C_INT)

if (false_f) error stop "bool_passthru(.false.) should be .false."
if (.not. true_f) error stop "bool_passthru(.true.) should be .true."

end program
