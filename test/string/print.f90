module printer

use, intrinsic :: iso_c_binding, only : C_CHAR, C_SIZE_T, C_NULL_CHAR
implicit none

contains

subroutine f_print(s, L) bind(C)
!! print a string to the screen
integer(C_SIZE_T), value, intent(in) :: L
character(kind=C_CHAR), intent(in) :: s(L)

character(:), allocatable :: fs

block
character(L) :: buf
integer :: i
buf = "" !< ensure buf has no garbage characters

do i = 1, len(buf)
    if (s(i) == C_NULL_CHAR) exit
    buf(i:i) = s(i)
end do
allocate(character(len_trim(buf)) :: fs)
fs = trim(buf)
end block

print '(a)', fs

end subroutine

end module
