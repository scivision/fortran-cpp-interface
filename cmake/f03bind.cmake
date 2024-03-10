check_source_compiles(Fortran
"program a
use, intrinsic :: iso_c_binding

integer(C_INT) :: i

contains

subroutine fun(i) bind(C)
integer(C_INT), intent(in) :: i
end subroutine

end program
"
f03bind
)
