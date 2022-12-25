module datamod_poly
!! from https://github.com/mattzett/fortran_tests

use, intrinsic :: iso_c_binding, only : c_float, c_int

implicit none

type, abstract :: dataobj_poly
!! derived type definition containing data and procedures
real(c_float), dimension(:,:), pointer :: dataval
integer(c_int) :: lx,ly

contains
  procedure :: set_data
  procedure :: print_data
!    final :: destructor
end type dataobj_poly

type, extends(dataobj_poly) :: data1
integer :: datstat
contains
  procedure :: print_data=>print_data1
end type data1

type, extends(dataobj_poly) :: data2
real(c_float) :: datmag
contains
  procedure :: print_data=>print_data2
end type data2

contains

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!! type-bound procedures
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine set_data(self,array)
  class(dataobj_poly), intent(inout) :: self
  real(c_float), dimension(:,:), intent(in) :: array

  self%lx=size(array,1)
  self%ly=size(array,2)
  allocate(self%dataval(self%lx,self%ly))
  self%dataval(:,:)=array(:,:)
end subroutine set_data


subroutine print_data(self)
!! the default print is as a row vector
  class(dataobj_poly), intent(inout) :: self

  print*, 'Stored data:  '
  print*, self%dataval(:,:)
end subroutine print_data


subroutine print_data1(self)
!! objects of type1 will print out as a matrix on the console
  class(data1), intent(inout) :: self
  integer :: ix

  print*, 'Stored data:  '
  do ix=1,self%lx
    print '(100F4.1)', self%dataval(ix,:)
  end do
end subroutine print_data1


subroutine print_data2(self)
!! objects of type2 will print out as a column vector on the console
  class(data2), intent(inout) :: self
  integer :: ix,iy

  print*, 'Stored data:  '
  do ix=1,self%lx
    do iy=1,self%ly
      print '(f4.1)', self%dataval(ix,iy)
    end do
  end do
end subroutine print_data2

end module datamod_poly
