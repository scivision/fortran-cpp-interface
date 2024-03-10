program test_strftime
!! SciVision implemented this in datetime-fortran
!! MinGW is broken for strftime with ISO format codes.

use, intrinsic :: iso_c_binding
use, intrinsic :: iso_fortran_env

implicit none

type, bind(c) :: tm_struct
!! https://www.cplusplus.com/reference/ctime/tm
integer(c_int) :: tm_sec = 0 ! Seconds [0-60] (1 leap second)
integer(c_int) :: tm_min = 0 ! Minutes [0-59]
integer(c_int) :: tm_hour = 0 ! Hours [0-23]
integer(c_int) :: tm_mday = 0 ! Day [1-31]
integer(c_int) :: tm_mon = 0 ! Month [0-11]
integer(c_int) :: tm_year = 0 ! Year - 1900
integer(c_int) :: tm_wday = 0 ! Day of week [0-6]
integer(c_int) :: tm_yday = 0 ! Days in year [0-365]
integer(c_int) :: tm_isdst = 0 ! DST [-1/0/1]
end type

interface
type(C_PTR) function strftime(str, slen, format, tm) bind(c)
import C_INT, C_CHAR, C_PTR, tm_struct
character(kind=c_char), intent(out) :: str(*)   !< result string
integer(c_int), value, intent(in) :: slen       !< result length
character(kind=c_char), intent(in) :: format(*) !< time format
type(tm_struct), intent(in) :: tm
end function
end interface

type(C_PTR) :: rc
character(kind=c_char, len=80) :: str
character(kind=c_char, len=*), parameter :: fmt = "%Y-%m-%dT%H:%M:%S"
type(tm_struct) :: tm

integer :: second, minute, hour, day, month, year
character(19) :: tstr

second = 56
minute = 24
hour = 13
day = 5
month = 12
year = 2020

tm % tm_sec = second
tm % tm_min = minute
tm % tm_hour = hour
tm % tm_mday = day
tm % tm_mon = month - 1
tm % tm_year = year - 1900


rc = strftime(str, len(str, kind=C_INT), fmt // c_null_char, tm)

if(.not. c_associated(rc)) error stop 'strftime failed'

tstr = str(:19)

print '(a)', "strftime: "// tstr
if (tstr /= "2020-12-05T13:24:56") then
  error stop "strftime failed, expected: 2020-12-05T13:24:56"
end if

end program
