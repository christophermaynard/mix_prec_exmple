module head_field_mod
  implicit none

  type, public, abstract :: head_field_type
   contains
     ! a lot of procedures
  end type head_field_type

end module head_field_mod

module field_mod
  use constants_mod, only : r_def
  use head_field_mod, only : head_field_type
  implicit none

  type, extends(head_field_type), public :: field_type
     real(kind=r_def), public :: data
   contains
     procedure, public :: get_proxy
  end type field_type

  type, public :: field_proxy_type
     real(kind=r_def), pointer, public :: data
   contains
  end type field_proxy_type

contains
  function get_proxy(self) result(proxy)
    implicit none
    class(field_type), target, intent(in) :: self
    type(field_proxy_type) :: proxy
    
    proxy%data => self%data
  end function get_proxy
  
end module field_mod

module rsolver_field_mod
  use constants_mod, only : r_solver
  use head_field_mod, only : head_field_type
  implicit none
  
  type, extends(head_field_type), public :: rsolver_field_type
     
     real(kind=r_solver) :: data
   contains
     procedure, public :: get_proxy
  end type rsolver_field_type
  
  type, public :: rsolver_field_proxy_type
     real(kind=r_solver), pointer, public :: data
   contains
  end type rsolver_field_proxy_type
  
contains
  
  function get_proxy(self) result(proxy)
    implicit none
    class(rsolver_field_type), target, intent(in) :: self
    type(rsolver_field_proxy_type) :: proxy

    proxy%data => self%data
  end function get_proxy

end module rsolver_field_mod
