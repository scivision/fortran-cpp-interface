program boollog

use, intrinsic ::iso_c_binding, only : C_BOOL

implicit none

interface
logical(C_BOOL) function logical_not(a) bind(C)
import
logical(C_BOOL), intent(in), value :: a
end function
end interface

logical(C_BOOL) :: t, f

t = .true.
f = .false.

if (logical_not(t)) error stop "logical_not(.true.) should be .false."
if (.not. logical_not(f)) error stop "logical_not(.false.) should be .true."

end program
