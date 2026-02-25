program logical_C_bool

use, intrinsic ::iso_c_binding, only : C_BOOL

implicit none

interface
logical(C_BOOL) function logical_not(a) bind(C)
import
logical(C_BOOL), intent(in), value :: a
end function
end interface

logical(C_BOOL) :: t, f

logical :: true_f, false_f

t = .true.
f = .false.

false_f = logical_not(t)
true_f = logical_not(f)

if (false_f) error stop "logical_not(.true.) should be .false."
if (.not. true_f) error stop "logical_not(.false.) should be .true."

end program
