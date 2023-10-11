program raiser

implicit none

interface
subroutine raise_exception() bind(C)
end subroutine
end interface

call raise_exception()

print '(a)', "OK: no exception raised"

end program
