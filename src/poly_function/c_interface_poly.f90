module c_interface_poly
!! top-level procedures that C will call to manipulate a Fortran object
!! from https://github.com/mattzett/fortran_tests

  use datamod_poly, only: dataobj_poly,data1,data2
  use, intrinsic :: iso_c_binding, only: c_loc,c_ptr,c_f_pointer,c_int, c_float, c_size_t, c_null_ptr, c_associated
  implicit none

  integer(c_int), parameter :: STATUS_SUCCESS = 0_c_int
  integer(c_int), parameter :: STATUS_INVALID_TYPE = 1_c_int
  integer(c_int), parameter :: STATUS_NULL_PTR = 2_c_int
  integer(c_int), parameter :: STATUS_ZERO_DIMS = 3_c_int
  integer(c_int), parameter :: STATUS_ALLOC_FAIL = 4_c_int
  integer(c_int), parameter :: STATUS_BAD_OBJECT_PTR = 5_c_int

contains

integer(c_int) function objconstruct_C(objtype,cptr_f90obj,cptr_indata,lx,ly) bind(C, name='objconstruct_C')
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
  integer :: alloc_status

  !> nullify for sake of clarity and good practice
  nullify(tmpobj1, tmpobj2)
  objconstruct_C = STATUS_SUCCESS
  cptr_f90obj = c_null_ptr

  if (.not. c_associated(cptr_indata)) then
    objconstruct_C = STATUS_NULL_PTR
    return
  end if

  if (lx == 0_c_size_t .or. ly == 0_c_size_t) then
    objconstruct_C = STATUS_ZERO_DIMS
    return
  end if

  !> allocate derived type, note that c_loc only works on a static type (i.e. not polymorphic class), hence the tmpobj's
  select case (objtype)
    case (1)
      allocate(tmpobj1, stat=alloc_status)
      if (alloc_status /= 0) then
        objconstruct_C = STATUS_ALLOC_FAIL
        return
      end if
      cptr_f90obj=c_loc(tmpobj1)
      obj=>tmpobj1
    case (2)
      allocate(tmpobj2, stat=alloc_status)
      if (alloc_status /= 0) then
        objconstruct_C = STATUS_ALLOC_FAIL
        return
      end if
      cptr_f90obj=c_loc(tmpobj2)
      obj=>tmpobj2
    case default
      objconstruct_C = STATUS_INVALID_TYPE
      return
  end select

  !> initialize some test data, and call methods to print
  print*, 'Initializing test data...'
  call c_f_pointer(cptr_indata,fortdata,shape=[lx,ly])
  call obj%set_data(fortdata)

  !! note lack of deallocate and nullify here; we need memory allocated to persist past the return.
end function objconstruct_C


!> Use some of the polymorphic object methods and data
integer(c_int) function objuse_C(objtype,objC) bind(C, name='objuse_C')
  type(c_ptr), intent(in) :: objC
  integer(c_int), intent(in) :: objtype
  class(dataobj_poly),pointer :: obj
  integer(c_int) :: status

  objuse_C = STATUS_SUCCESS
  if (.not. c_associated(objC)) then
    objuse_C = STATUS_NULL_PTR
    return
  end if

  call set_pointer_dyntype(objtype,objC,obj,status)
  if (status /= 0) then
    objuse_C = status
    return
  end if

  call obj%print_data()
end function objuse_C


!> set fortran object pointer dynamic type to what is indicated in objtype.  Convert C pointer using
!    declared static types (c_f_pointer will not work on a polymorphic object).
subroutine set_pointer_dyntype(objtype, objC, obj, status)
  type(c_ptr), intent(in) :: objC
  integer(c_int), intent(in) :: objtype
  class(dataobj_poly), pointer, intent(out) :: obj
  integer(c_int), intent(out) :: status
  type(data1), pointer :: obj1
  type(data2), pointer :: obj2

  status = STATUS_SUCCESS
  nullify(obj)
  nullify(obj1, obj2)

  select case (objtype)
    case (1)
      call c_f_pointer(objC,obj1)
      if (.not. associated(obj1)) then
        status = STATUS_BAD_OBJECT_PTR
        return
      end if
      obj=>obj1
    case (2)
      call c_f_pointer(objC,obj2)
      if (.not. associated(obj2)) then
        status = STATUS_BAD_OBJECT_PTR
        return
      end if
      obj=>obj2
    case default
      status = STATUS_INVALID_TYPE
  end select
end subroutine set_pointer_dyntype


integer(c_int) function destruct_C(objtype, objC) bind(C, name='destruct_C')
type(c_ptr), intent(inout) :: objC
integer(c_int), intent(in) :: objtype

class(dataobj_poly),pointer :: obj
integer(c_int) :: status

destruct_C = STATUS_SUCCESS
if (.not. c_associated(objC)) return

call set_pointer_dyntype(objtype,objC,obj,status)
if (status /= 0) then
  destruct_C = status
  return
end if

if (associated(obj%dataval)) deallocate(obj%dataval)
deallocate(obj)
objC = c_null_ptr

end function destruct_C

end module c_interface_poly
