module bindmod

use, intrinsic :: iso_c_binding, only : c_float
implicit none

interface
module pure real(c_float) function pi() bind(c)
end function pi
end interface

end module bindmod

submodule (bindmod) bindsub

implicit none

contains
module procedure pi
pi = 4*atan(1.)
end procedure pi

end submodule bindsub
