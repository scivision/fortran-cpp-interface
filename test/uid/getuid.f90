program guid

use, intrinsic :: iso_c_binding

implicit none

interface
integer(C_SIZE_T) function c_get_uid(result, buffer_size) bind(C)
import
character(kind=C_CHAR), intent(out) :: result(*)
integer(C_SIZE_T), intent(in), value :: buffer_size
end function
end interface


print '(a)', "UID: " // get_uid()

contains

function get_uid() result(r)
character(:), allocatable :: r
character(kind=c_char, len=:), allocatable :: cbuf
integer(C_SIZE_T) :: N

!! 256 is reasonable max length for Windows SID string representation
allocate(character(256) :: cbuf)
N = len(cbuf)

N = c_get_uid(cbuf, N)

r = cbuf(:N)
end function

end program
