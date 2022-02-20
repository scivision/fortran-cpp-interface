module bindmod

use, intrinsic :: iso_c_binding, only : c_float
implicit none (type, external)

interface
module pure real(c_float) function pi() bind(c)
end function pi
end interface

end module bindmod
