program iterator

use, intrinsic :: iso_c_binding
implicit none


interface
TYPE(C_PTR) FUNCTION initIterator_C() BIND(C, NAME='initIterator_C')
  import C_PTR
end function
subroutine incrementIterator_C(pit) BIND(C, NAME='incrementIterator_C')
  import C_PTR
  type(C_PTR), value, intent(in) :: pit
end subroutine
integer(C_INT) FUNCTION getIteratorValue_C(pit) BIND(C, NAME='getIteratorValue_C')
  import C_INT, C_PTR
  type(C_PTR), value, intent(in) :: pit
end function
end interface

type(C_PTR) :: it

it = initIterator_C()

print *, getIteratorValue_C(it)

call incrementIterator_C(it)

print *, "OK: iterator"

end program
