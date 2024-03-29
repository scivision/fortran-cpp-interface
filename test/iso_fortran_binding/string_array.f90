!! taken from
!! https://fortran-lang.discourse.group/t/return-an-array-of-strings-from-fortran-to-c/5100/3
module m
  use, intrinsic :: iso_c_binding, only : c_char
  character(kind=c_char,len=:), allocatable, target, save :: names(:)  !<-- entity holding the string array data
contains
  ! Getter procedure
  subroutine get_names( pnames ) bind(C, name="get_names")
     ! Argument list
     character(kind=c_char,len=:), pointer, intent(inout) :: pnames(:)
     !  Elided are any checks on the state of the data, whether allocated and loaded, etc.
     pnames => names
  end subroutine
  ! Initializer toward the module entity, may be a database load, read from a file, etc.
  subroutine Finit() bind(C, name="Finit")
     names = [ character(kind=c_char,len=6) :: c_char_"red",   &
                                               c_char_"green", &
                                               c_char_"blue" ]
  end subroutine
end module
