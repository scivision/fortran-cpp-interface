program sleep_demo

use, intrinsic :: iso_fortran_env, only : int64

use sleep_std, only : sleep_ms

implicit none

integer :: ierr, millisec
character(8) :: argv
integer(int64) :: tic, toc, trate
real :: t_ms

call system_clock(count_rate=trate)

millisec = 500
if(command_argument_count() > 0) then
  call get_command_argument(1, argv, status=ierr)
  if (ierr /= 0) error stop "please specify milliseconds to sleep"
  read(argv, '(i6)') millisec
endif

if (millisec <= 0) error stop "please specify positive milliseconds to sleep"

call system_clock(count=tic)
call sleep_ms(millisec)
call system_clock(count=toc)

t_ms = real(toc-tic) * 1000. / real(trate)

if (t_ms < 0.5 * millisec) error stop 'actual sleep time was too short'
if (t_ms > 2 * millisec) error stop 'actual sleep time was too long'

print '(A, F6.1)', 'OK: test_sleep: slept for (ms): ', t_ms

end program
