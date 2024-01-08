program boollog

use, intrinsic ::iso_c_binding, only : C_BOOL

implicit none

interface
logical(C_BOOL) function logical_not_cpp(a) bind(C)
import
logical(C_BOOL), intent(in), value :: a
end function
end interface

logical(C_BOOL) :: t, f

t = .true.
f = .false.

if (logical_not_cpp(t)) error stop "logical_not_cpp(.true.) should be .false."

end program
