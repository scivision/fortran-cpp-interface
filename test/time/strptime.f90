program test_strptime

use iso_c_binding

implicit none

type,bind(c) :: tm_struct
!! vital to initialize to 0 or something, else get macOS runtime segfault with GCC or Clang
integer(C_INT) :: tm_sec=0,tm_min=0,tm_hour=0,tm_mday=0,tm_mon=0,tm_year=0,tm_wday=0,tm_yday=0,tm_isdst=0
end type

interface
function strptime(str,format,tm) bind(C)
import
character(kind=C_CHAR), intent(in) :: str(*), format(*)
type(tm_struct), intent(out) :: tm
type(C_PTR) :: strptime
end function
end interface

type(C_PTR) :: rc
character(kind=C_CHAR, len=20) :: str = '2018-01-01 12:00:00'
character(kind=C_CHAR, len=18), parameter :: fmt = '%Y-%m-%d %H:%M:%S' // c_null_char
type(tm_struct) :: tm

rc = strptime(trim(str)// c_null_char, fmt, tm)
if(c_associated(rc, c_null_ptr)) error stop "strptime failed"

print '(a3,1x,i4,1x,i2,1x,i2,1x,i2,1x,i2,1x,i2)', "OK:", &
  tm%tm_year+1900, tm%tm_mon+1, tm%tm_mday, tm%tm_hour, tm%tm_min, tm%tm_sec

end program
