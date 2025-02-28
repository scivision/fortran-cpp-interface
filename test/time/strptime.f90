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
character(kind=C_CHAR, len=20) :: str = '2018-01-02 12:05:15'
character(kind=C_CHAR, len=18), parameter :: fmt = '%Y-%m-%d %H:%M:%S' // c_null_char
type(tm_struct) :: tm

rc = strptime(trim(str)// c_null_char, fmt, tm)
if(c_associated(rc, c_null_ptr)) error stop "strptime failed"

if (tm%tm_year /= 118) error stop "tm_year /= 2018"
if (tm%tm_mon /= 0) error stop "tm_mon /= 0+1"
if (tm%tm_mday /= 2) error stop "tm_mday /= 2"
if (tm%tm_hour /= 12) error stop "tm_hour /= 12"
if (tm%tm_min /= 5) error stop "tm_min /= 0"
if (tm%tm_sec /= 15) error stop "tm_sec /= 15"

print '(a)', "OK: strptime"

end program
