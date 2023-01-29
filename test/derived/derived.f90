! Example derived type/structure interoperability, f2008 C.11.3
!**************************************************************
subroutine simulation(alpha, beta, gamma, delta, arrays) bind(c)

use, intrinsic :: iso_c_binding

implicit none

integer (c_long), value :: alpha
real (c_double), intent(inout) :: beta
integer (c_long), intent(out) :: gamma
real (c_double),dimension(*),intent(in) :: delta

type, bind(c) :: pass
  integer (c_int) :: lenc, lenf
  type (c_ptr) :: c, f
end type pass

type (pass), intent(inout) :: arrays

real (c_float), allocatable, target, save :: eta(:)
real (c_float), pointer :: c_array(:)
integer i

print *, "In simulation"
print *, "  alpha: ", alpha, ", beta: ", beta
print *, "  delta(1),(100): ", delta(1), delta(100)

! associate c_array with an array allocated in c
call c_f_pointer (arrays%c, c_array, [arrays%lenc])
print *, "  c_array(1),(arrays%lenc): ", c_array(1), c_array(arrays%lenc)

! allocate an array and make it available in c
arrays%lenf = 100
allocate (eta(arrays%lenf))
arrays%f = c_loc(eta)
eta = [(i*3,i=1,arrays%lenf)]

! change argument values
c_array = c_array * 2.0
gamma = 77
beta = -55.66

end subroutine simulation
