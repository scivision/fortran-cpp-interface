program pointer_bounds
!! explore lbound, ubound vis-a-vis pointer
!! Fortran allows arbitrary lbound, ubound.
!! In C array index starts at 0, but pointers can start in middle of array and then validly use negative indices.
use, intrinsic :: iso_c_binding, only : C_INT
use, intrinsic :: iso_fortran_env

implicit none

integer(C_INT), dimension(-1:2), target :: Ln1
integer(C_INT), pointer :: Pn1(:)


print '(a)', compiler_version()

call Lneg1(Ln1)
call Lneg1_C(Ln1)
!! bind(C) has no effect on lbound, ubound

Pn1 => Ln1
call Pneg1(Pn1)


contains

subroutine Lneg1(A)
integer(C_INT), dimension(:) :: A
print '(a,i0,a,i0)', "Lneg1: lbound(A) = ", lbound(A,1), " ubound(A) = ", ubound(A,1)
if (lbound(A,1) /= 1) error stop "Lneg1: unexpected lbound(A,1)"
if (ubound(A,1) /= 4) error stop "Lneg1: unexpected ubound(A,1)"
end subroutine Lneg1

subroutine Pneg1(A)
integer(C_INT), dimension(:), pointer :: A
print '(a,i0,a,i0)', "Pneg1: lbound(A) = ", lbound(A,1), " ubound(A) = ", ubound(A,1)
if (lbound(A,1) /= -1) error stop "Pneg1: unexpected lbound(A,1)"
if (ubound(A,1) /= 2) error stop "Pneg1: unexpected ubound(A,1)"
end subroutine Pneg1

subroutine Lneg1_C(A) bind(C)
integer(C_INT), dimension(:) :: A
print '(a,i0,a,i0)', "Lneg1_C: lbound(A) = ", lbound(A,1), " ubound(A) = ", ubound(A,1)
if (lbound(A,1) /= 1) then
  write(error_unit,'(a,i0)') "Lneg1_C: unexpected lbound(A,1) ", lbound(A,1)
  error stop
endif
if (ubound(A,1) /= 4) then
  write(error_unit, '(a,i0)') "Lneg1_C: unexpected ubound(A,1) ", ubound(A,1)
  error stop
endif
end subroutine lneg1_C
end program
