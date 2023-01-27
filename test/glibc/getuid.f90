program guid

use, intrinsic :: iso_c_binding, only : C_INT
implicit none

interface
integer(C_INT) function get_uid() bind(C, name="getuid")
import C_INT
end function
end interface


print '(a,i0)', "UID: ", get_uid()

end program