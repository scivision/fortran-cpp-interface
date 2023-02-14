module contig

use, intrinsic :: iso_c_binding, only : C_FLOAT, C_SIZE_T, C_PTR, c_f_pointer

implicit none

contains

subroutine asub(Ac, dims) bind(C)
type(C_PTR), value, intent(in) :: Ac
integer(c_size_t), intent(in) :: dims(1)

real(C_FLOAT), pointer, contiguous :: A(:)

call c_f_pointer(Ac, A, dims)

if (.not. is_contiguous(A)) error stop "assumed shape array is not contiguous"

print '(a,i0,a,10F7.1)', "contig: Fortran got length ", dims(1), " array: ", A
end subroutine

end module contig
