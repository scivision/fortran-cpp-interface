program test_bindc_bounds
   use, intrinsic :: iso_fortran_env
   use, intrinsic :: iso_c_binding
   implicit none

   interface
      logical(C_BOOL) function c_bounder(a, fl, fu) bind(c, name="c_bounder")
        import :: c_float, c_int64_t, C_BOOL
         real(c_float), intent(inout) :: a(:)
         integer(c_int64_t), value :: fl, fu
      end function

      logical(C_BOOL) function c_bounder_2d(a, fl1, fu1, fl2, fu2) bind(c, name="c_bounder_2d")
        import :: c_float, c_int64_t, C_BOOL
         real(c_float), intent(inout) :: a(:,:)
         integer(c_int64_t), value :: fl1, fu1, fl2, fu2
      end function
   end interface

   call test_default_bounds()
   call test_nondefault_bounds()
   call test_multidim()
   call test_array_section()
   call test_large_array()

   write(output_unit, '(a)') "All bounds checks passed."

contains

   subroutine check_bounds(a, label, expected_l, expected_u)
      real, allocatable, intent(in) :: a(:)
      character(*), intent(in) :: label
      integer, intent(in) :: expected_l, expected_u
      integer :: l, u

      l = lbound(a,1)
      u = ubound(a,1)

      if (l /= expected_l .or. u /= expected_u) then
         write(error_unit, '(a,": FAIL got [",i0,":",i0,"] expected [",i0,":",i0,"]")') &
            label, l, u, expected_l, expected_u
         error stop "Fortran bounds corrupted"
      end if
   end subroutine

   subroutine test_default_bounds()
      real, allocatable :: a(:)
      allocate(a(1:10))
      call check_bounds(a, "default before", 1, 10)
      if (.not. c_bounder(a, 1_c_int64_t, 10_c_int64_t)) then
         error stop "C bounder failed"
      end if
      call check_bounds(a, "default after ", 1, 10)
   end subroutine

   subroutine test_nondefault_bounds()
      real, allocatable :: a(:)
      allocate(a(-3:6))
      call check_bounds(a, "nondefault before", -3, 6)
      if (.not. c_bounder(a, -3_c_int64_t, 6_c_int64_t)) then
         error stop "C bounder failed"
      end if
      call check_bounds(a, "nondefault after ", -3, 6)
   end subroutine

   subroutine test_multidim()
      real, allocatable :: a(:,:)
      allocate(a(-2:5, 10:20))

      if (lbound(a,1)/=-2 .or. ubound(a,1)/=5 .or. &
          lbound(a,2)/=10 .or. ubound(a,2)/=20) then
         error stop "Multidim setup failed"
      end if

      if (.not. c_bounder_2d(a, -2_c_int64_t, 5_c_int64_t, 10_c_int64_t, 20_c_int64_t)) then
         error stop "C bounder 2D failed"
      end if

      if (lbound(a,1)/=-2 .or. ubound(a,1)/=5 .or. &
          lbound(a,2)/=10 .or. ubound(a,2)/=20) then
         error stop "Multidim bounds corrupted"
      end if
   end subroutine

   subroutine test_array_section()
      real, allocatable, target :: a(:)
      real, pointer :: p(:)

      allocate(a(-10:20))
      p => a(5:15)   ! pointer lower bound defaults to 1 here

      if (lbound(p,1) /= 1 .or. ubound(p,1) /= 11) then
         error stop "Section setup failed"
      end if

      ! Pass the section (C will see 0-based)
      if (.not. c_bounder(p, 5_c_int64_t, 15_c_int64_t)) then
         error stop "C bounder failed"
      end if

      ! Original array should still be intact
      if (lbound(a,1) /= -10 .or. ubound(a,1) /= 20) then
         error stop "Original array corrupted via section"
      end if

      print '(a)', "Array section test passed"
   end subroutine

   subroutine test_large_array()
      real, allocatable :: a(:)
      allocate(a(1:1000000))
      if (.not. c_bounder(a, 1_c_int64_t, 1000000_c_int64_t)) then
         error stop "C bounder failed"
      end if
      print '(a)', "Large array test passed"
   end subroutine

end program
