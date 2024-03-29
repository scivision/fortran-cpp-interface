!! taken from
!! https://fortran-lang.discourse.group/t/return-an-array-of-strings-from-fortran-to-c/5100/15
module sampling
  use, intrinsic :: iso_c_binding, only: &
     ip => c_int, dp => c_double
  implicit none
  private
contains
  ! Draw random samples in the unit square [0,1)^2
  subroutine draw_random_samples(n,samples) bind(c)
     integer(ip), intent(in), value :: n
     real(dp), allocatable, intent(out) :: samples(:,:)
     allocate(samples(n,2))
     call random_number(samples)
  end subroutine
  ! Estimate pi (3.14159...) by dart throwing
  function f_estimate_pi(n) bind(c) result(pi)
     integer(ip), intent(in), value :: n
     real(dp) :: pi
     real(dp), allocatable :: samples(:,:)
     call draw_random_samples(n,samples)
     associate(x => samples(:,1), y => samples(:,2))
        pi = 4 * real(count(x**2 + y**2 < 1, dim=1), dp) / n
     end associate
  end function
end module
