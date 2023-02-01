program Null_C

use, intrinsic :: iso_c_binding, only : C_PTR, c_associated, C_NULL_CHAR, C_CHAR

implicit none

interface
type(C_PTR) function get_null(c) bind(C)
import
character(kind=C_CHAR), intent(in) :: c(*)
end function
end interface

type(C_PTR) :: p

p = get_null(C_NULL_CHAR)
if (c_associated(p)) error stop "null should not be associated"

p = get_null(""//C_NULL_CHAR)
if (c_associated(p)) error stop "null should not be associated"

p = get_null(" "//C_NULL_CHAR)
if (.not.c_associated(p)) error stop "non-null should be associated"

end program
