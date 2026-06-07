program string_inout_cpp

implicit none

interface
subroutine process_strings_direct(in_str, out_str) bind(C, name="process_strings_cfi")
character(len=*), intent(in)  :: in_str
character(len=*), intent(out) :: out_str
end subroutine process_strings_direct
end interface


character(len=20) :: input_str  = "Hello from Fortran!"
character(len=20) :: output_str

call process_strings_direct(input_str, output_str)

print *, "Fortran sent: ", trim(input_str)
print *, "Fortran received: ", trim(output_str)

end program
