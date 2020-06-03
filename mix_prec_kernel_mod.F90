module mix_prec_kernel_mod

  use argument_mod, only : arg_type, GH_FIELD, GH_READ, GH_WRITE, ANY_SPACE_1, CELLS
  use, intrinsic :: iso_fortran_env, only : real32, real64, real128
  use kernel_mod,   only : kernel_type

  type, public, extends(kernel_type) :: mix_prec_kernel_type
     private
     type(arg_type) :: meta_args(2) = (/                    &
          arg_type( GH_FIELD, GH_WRITE, ANY_SPACE_1 ),      &
          arg_type( GH_FIELD, GH_READ,  ANY_SPACE_1 )       &
          /)
     integer :: iterates_over = CELLS
   contains
     procedure, nopass :: mix_prec_code

  end type mix_prec_kernel_type

  interface mix_prec_code
     module procedure mix_prec_code_r32, mix_prec_code_r64, mix_prec_code_r128
  end interface mix_prec_code
  
contains
  subroutine mix_prec_code_r32(f1, f2)
    implicit none
    real(kind=real32), intent(in) :: f1, f2
    f1 = f2
    write(*,*) "32-bit"
  end subroutine mix_prec_code_r32
  
  subroutine mix_prec_code_r64(f1, f2)
    implicit none
    real(kind=real64), intent(in) :: f1, f2
    f1 = f2
    write(*,*) "64-bit"
  end subroutine mix_prec_code_r64

  subroutine mix_prec_code_r128(f1, f2)
    implicit none
    real(kind=real128), intent(in) :: f1, f2
    f1 = f2
    write(*,*) "128-bit"
  end subroutine mix_prec_code_r128
  
end module mix_prec_kernel_mod


