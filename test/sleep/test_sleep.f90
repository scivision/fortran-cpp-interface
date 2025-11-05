program sleep_demo
!! we relax this example to use 32-bit timers as Flang 20 currently has a bug with 64-bit timers where the tick rate is reported as 1/1000th the actual rate.

use, intrinsic :: iso_fortran_env, only : stderr => error_unit, compiler_version

use sleep_std, only : sleep_ms

implicit none


integer :: ierr, millisec, L
character(:), allocatable :: argv
integer :: tic, toc, trate, ticks
real :: t_ms

call system_clock(count_rate=trate)

if (trate <= 0) error stop "system_clock count_rate indicates no clock available"
print '(a, i0)', 'CPU tick rate (ticks/sec): ', trate

millisec = 500
if(command_argument_count() > 0) then

  call get_command_argument(1, length=L)
  allocate(character(L) :: argv)
  call get_command_argument(1, argv, status=ierr)
  if (ierr /= 0) error stop "please specify milliseconds to sleep"
  read(argv, '(i5)') millisec
end if

if (millisec <= 0) error stop "please specify positive milliseconds to sleep"
if (millisec > 10000) error stop "please specify milliseconds to sleep less than 10000"

print '(a, i0)', 'sleeping for (ms): ', millisec

call system_clock(count=tic)
call sleep_ms(millisec)
call system_clock(count=toc)

ticks = toc-tic
t_ms = 1000 * real(ticks) / real(trate)

print '(a, i0)', 'ticks slept: ', ticks

if (t_ms < 0.5 * millisec) then
  !> slept less than half expected time
  write(stderr, *) 'ERROR: measured sleep time too short (millisec): ', t_ms
  error stop
end if
if (t_ms > 2 * millisec) then
  !> slept more than twice expected time
  write(stderr, *) 'ERROR: measure sleep time too long (millisec): ', t_ms
  error stop
end if

print '(A, F7.1)', 'OK: ' // compiler_version() // ' slept for (ms): ', t_ms

end program
