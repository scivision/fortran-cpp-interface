program ticks

use, intrinsic :: iso_fortran_env, only : int32, int64, error_unit

implicit none

integer(int32) :: trate32, tic32, toc32, ticks32
integer(int64) :: trate, tic, toc, ticks64
logical :: ok = .true.

call system_clock(count_rate=trate)
call system_clock(count_rate=trate32)

if (trate <= 0) error stop "system_clock count_rate indicates no clock available"
print '(a, i0)', 'CPU 64-bit tick rate (ticks/sec): ', trate
print '(a, i0)', 'CPU 32-bit tick rate (ticks/sec): ', trate32

call system_clock(count=tic)
call system_clock(count=tic32)

call sleep(1)
! this is non-standard, but we are interested in tick counts

call system_clock(count=toc)
call system_clock(count=toc32)

ticks64 = toc - tic
ticks32 = toc32 - tic32
print '(a,i0,a,i0)', 'CPU ticks: 64-bit ', ticks64, ' 32-bit ', ticks32

if (real(ticks64) < real(trate) * 0.95 .or. real(ticks64) > real(trate) * 1.05) then
  ok = .false.
  write(error_unit, *) 'ERROR: 64-bit ticks: expected about ', trate, ' but got ', ticks64
end if

if (real(ticks32) < real(trate32) * 0.95 .or. real(ticks32) > real(trate32) * 1.05) then
  ok = .false.
  write(error_unit, *) 'ERROR: 32-bit ticks: expected about ', trate32, ' but got ', ticks32
end if

if (.not. ok) error stop "tick rate test failed"

print *, 'OK: ticks: tick rates look good'

end program
