program raiser

implicit none

interface
subroutine raise_exception() bind(C)
end subroutine
end interface

call raise_exception()

end program
