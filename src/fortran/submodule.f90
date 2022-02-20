submodule (bindmod) bindsub

implicit none (type, external)

contains
module procedure pi
pi = 4*atan(1.)
end procedure pi

end submodule bindsub
