module mix_prec_kernel_mod
  use, intrinsic :: iso_fortran_env, only : real32, real64, real128

  type, public :: mix_prec_kernel_type
   contains

     procedure, nopass :: sp => mix_prec_code_r32
     procedure, nopass :: dp => mix_prec_code_r64
     procedure, nopass :: qp => mix_prec_code_r128
     generic, public :: mix_prec_code => sp, dp, qp
  end type mix_prec_kernel_type

contains
  subroutine mix_prec_code_r32(val)
    implicit none
    real(kind=real32), intent(in) :: val

    write(*,*) "32-bit"
  end subroutine mix_prec_code_r32
  
  subroutine mix_prec_code_r64(val)
    implicit none
    real(kind=real64), intent(in) :: val

    write(*,*) "64-bit"
  end subroutine mix_prec_code_r64

  subroutine mix_prec_code_r128(val)
    implicit none
    real(kind=real128), intent(in) :: val

    write(*,*) "128-bit"
  end subroutine mix_prec_code_r128
  
end module mix_prec_kernel_mod


