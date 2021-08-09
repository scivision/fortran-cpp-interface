module c_interface

use, intrinsic :: ISO_C_Binding, only: C_FUNPTR

implicit none (type, external)

interface

subroutine signalterm_C(handler) bind(C)
import C_FUNPTR
type(C_FUNPTR), intent(in), value :: handler
end subroutine signalterm_C

#ifndef __WIN32__
subroutine signalusr1_C(handler) bind(C)
import C_FUNPTR
type(C_FUNPTR), intent(in), value :: handler
end subroutine signalusr1_C
#endif

end interface

end module c_interface
