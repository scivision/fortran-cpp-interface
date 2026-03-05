program logical_C_bool

use, intrinsic ::iso_c_binding, only : C_BOOL

implicit none

interface
logical(C_BOOL) function logical_not(a) bind(C)
import
logical(C_BOOL), intent(in), value :: a
end function
end interface

logical(C_BOOL) :: tc, fc
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

false_f = logical_not(tc)
true_f = logical_not(fc)

if (false_f) error stop "logical_not(.true.) should be .false."
if (.not. true_f) error stop "logical_not(.false.) should be .true."

end program
