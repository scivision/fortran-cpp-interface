module c_interface_poly
!! top-level procedures that C will call to manipulate a Fortran object
!! from https://github.com/mattzett/fortran_tests

  use datamod_poly, only: dataobj_poly,data1,data2
  use, intrinsic :: iso_c_binding, only: c_loc,c_ptr,c_f_pointer,c_int, c_float, c_size_t
  implicit none (type, external)

contains

subroutine objconstruct_C(objtype,cptr_f90obj,cptr_indata,lx,ly) bind(C, name='objconstruct_C')
!! return a c pointer to a fortran polymorphic object that is created by this routine; in this case we
!! are passing the object type to be created from the C main program
  integer(c_int), intent(in) :: objtype
  type(c_ptr), intent(inout) :: cptr_f90obj
  type(c_ptr), intent(in) :: cptr_indata
  integer(c_size_t), intent(in) :: lx,ly
  class(dataobj_poly), pointer :: obj
  type(data1), pointer :: tmpobj1    !< declared as pointers so they don't auto-allocate when we return
  type(data2), pointer :: tmpobj2    !< ditto
  real(c_float), dimension(:,:), pointer :: fortdata

  !> nullify for sake of clarity and good practice
  nullify(tmpobj1, tmpobj2)

  !> allocate derived type, note that c_loc only works on a static type (i.e. not polymorphic class), hence the tmpobj's
  select case (objtype)
    case (1)
      allocate(data1::obj)
      allocate(tmpobj1)
      cptr_f90obj=c_loc(tmpobj1)
      obj=>tmpobj1
    case (2)
      allocate(data2::obj)
      allocate(tmpobj2)
      cptr_f90obj=c_loc(tmpobj2)
      obj=>tmpobj2
    case default
      error stop 'unable to identify object type during construction'
  end select

  !> initialize some test data, and call methods to print
  print*, 'Initializing test data...'
  call c_f_pointer(cptr_indata,fortdata,shape=[lx,ly])
  call obj%set_data(fortdata)

  !! note lack of deallocate and nullify here; we need memory allocated to persist past the return.
end subroutine objconstruct_C


!> Use some of the polymorphic object methods and data
subroutine objuse_C(objtype,objC) bind(C, name='objuse_C')
  type(c_ptr), intent(in) :: objC
  integer(c_int), intent(in) :: objtype
  class(dataobj_poly),pointer :: obj

  obj=>set_pointer_dyntype(objtype,objC)
  call obj%print_data()
end subroutine objuse_C


!> set fortran object pointer dynamic type to what is indicated in objtype.  Convert C pointer using
!    declared static types (c_f_pointer will not work on a polymorphic object).
function set_pointer_dyntype(objtype, objC) result(obj)
  type(c_ptr), intent(in) :: objC
  integer(c_int), intent(in) :: objtype
  class(dataobj_poly), pointer :: obj
  type(data1), pointer :: obj1
  type(data2), pointer :: obj2

  select case (objtype)
    case (1)
      call c_f_pointer(objC,obj1)
      obj=>obj1
    case (2)
      call c_f_pointer(objC,obj2)
      obj=>obj2
    case default
      error stop 'unable to identify object type during conversion from C to fortran class pointer'
  end select
end function set_pointer_dyntype

end module c_interface_poly
