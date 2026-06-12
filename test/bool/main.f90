program logical_C_bool

use, intrinsic ::iso_c_binding, only : C_BOOL, C_INT

implicit none

type, bind(C) :: bool_args
logical(C_BOOL) :: value
integer(C_INT) :: dummy
end type

interface
logical(C_BOOL) function logical_not(args) bind(C)
import C_BOOL, bool_args
type(bool_args), intent(in), value :: args
end function

logical(C_BOOL) function bool_passthru(args) bind(C)
import C_BOOL, bool_args
type(bool_args), intent(in), value :: args
end function
end interface

type(bool_args) :: tc, fc
logical :: t0, f0, t1, f1
!! show there's no warnings

logical :: true_f, false_f

t0 = .true.
f0 = .false.
tc%value = t0
tc%dummy = 42_C_INT
fc%value = f0
fc%dummy = 42_C_INT
t1 = tc%value
f1 = fc%value

if (.not. t1) error stop "logical(C_BOOL) .true. should be .true."
if (.not. t1 .eqv. t0) error stop "logical(C_BOOL) .true. should EQV .true."
if (f1) error stop "logical(C_BOOL) .false. should be .false."
if(.not. f1 .eqv. f0) error stop "logical(C_BOOL) .false. should EQV .false."

false_f = logical_not(tc)
true_f = logical_not(fc)

if (false_f) error stop "logical_not(.true.) should be .false."
if (.not. true_f) error stop "logical_not(.false.) should be .true."

false_f = bool_passthru(fc)
true_f = bool_passthru(tc)

if (false_f) error stop "bool_passthru(.false.) should be .false."
if (.not. true_f) error stop "bool_passthru(.true.) should be .true."

end program
