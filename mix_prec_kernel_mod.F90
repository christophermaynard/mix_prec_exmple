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
     ! PSyclone requires this
!     procedure, nopass :: mixed_prec_code

! F2K3 OO over-loading, works but cannot call mix_prec_code without type     
!     procedure, nopass :: mix_prec_code_r32
!     procedure, nopass :: mix_prec_code_r64
!     procedure, nopass :: mix_prec_code_mixed
!     generic, public :: mix_prec_code => mix_prec_code_r32, mix_prec_code_r64, &
!                        mix_prec_code_mixed
  end type mix_prec_kernel_type

! F90 style over-loading - cannot work with type bound procedures  
  interface mix_prec_code
     module procedure mix_prec_code_r32, mix_prec_code_r64, mix_prec_code_mixed
  end interface mix_prec_code
  
contains
  
  subroutine mix_prec_code_r32(f1, f2)
    implicit none
    real(kind=real32), intent(in) :: f2
    real(kind=real32), intent(inout) :: f1    
    f1 = f2
    write(*,*) "32-bit"
  end subroutine mix_prec_code_r32
  
  subroutine mix_prec_code_r64(f1, f2)
    implicit none
    real(kind=real64), intent(in) :: f2
    real(kind=real64), intent(inout) :: f1        
    f1 = f2
    write(*,*) "64-bit"
  end subroutine mix_prec_code_r64

  subroutine mix_prec_code_mixed(f1, f2)
    implicit none
    real(kind=real64), intent(in) :: f2
    real(kind=real32), intent(inout) :: f1        
    f1 = real(f2,kind=real32)
    write(*,*) "real mixed prec"
  end subroutine mix_prec_code_mixed
  
end module mix_prec_kernel_mod


