!! https://stackoverflow.com/a/63413298
program cfisp
use, intrinsic :: iso_c_binding, only : c_int

implicit none

interface
subroutine fcpoint(f_p) bind(c)
import c_int
integer(c_int), pointer, intent(out) :: f_p(:)
end subroutine
end interface

integer(c_int), pointer :: f_p(:)

nullify(f_p)

call fcpoint(f_p)
print *, f_p

end program
