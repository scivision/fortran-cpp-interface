check_source_compiles(Fortran
"program test
implicit none
real :: a(1)
print '(L1)', is_contiguous(a)
end program"
f08contiguous
)
