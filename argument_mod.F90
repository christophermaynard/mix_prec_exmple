!-----------------------------------------------------------------------------
! Copyright (c) 2017,  Met Office, on behalf of HMSO and Queen's Printer
! For further details please refer to the file LICENCE.original which you
! should have received as part of this distribution.
!-----------------------------------------------------------------------------

!> @brief The argument type to hold kernel metadata required by the psy layer.

!> @details Metadata for the kernels. In order to create correct PSy code a
!> code we need to know how many fields and operators are passed to the kernel
!> and in what order they are passed. We also needs to know how these
!> fields/operators are accessed (read, write etc) within the kernel and what
!> function space they are on (w0, w1 etc). In the case of operators there are
!> two function spaces (to and from). This information is stored in the
!> arg_type type.

!> A kernel may also require additional data associated with a particular
!> function space (basis function, differential basis function and orientation
!> information). This information is specified in the xxx type.
!> the psy layer needs to know how this is to be accessed.
!> read, write etc and which function space it belongs. These are the three
!> integers of
!> the arg_type and the values are then one of the parameters
!> defined in this module.
!> field metadata also has three logicals controlling whether the psy layer
!> needs to pass the basis function, the differential basis function,
!> and the guassian quadrature type.
!> Another metadatum which describes the kernel, not the fields
!> is what the kernel will iterate over. Usually cells, sometimes
!> all the dofs.

module argument_mod

  implicit none

  private

! Argument types
  integer, public, parameter :: GH_FIELD               = 507
  integer, public, parameter :: GH_OPERATOR            = 735
  integer, public, parameter :: GH_COLUMNWISE_OPERATOR = 841
  integer, public, parameter :: GH_REAL                = 58
  integer, public, parameter :: GH_INTEGER             = 5

! Access descriptors
  integer, public, parameter :: GH_READ      = 958
  integer, public, parameter :: GH_WRITE     = 65
  integer, public, parameter :: GH_READWRITE = 811
  integer, public, parameter :: GH_INC       = 542
  integer, public, parameter :: GH_SUM       = 563
  integer, public, parameter :: GH_MIN       = 718
  integer, public, parameter :: GH_MAX       = 391

! General function space IDs. Distinct IDs required as we may have groups
! of fields that must be on the same space within a kernel.
! IDs for any space regardless of continuity
  integer, public, parameter :: ANY_SPACE_1    = 368
  integer, public, parameter :: ANY_SPACE_2    = 389
  integer, public, parameter :: ANY_SPACE_3    = 194
  integer, public, parameter :: ANY_SPACE_4    = 816
  integer, public, parameter :: ANY_SPACE_5    = 461
  integer, public, parameter :: ANY_SPACE_6    = 734
  integer, public, parameter :: ANY_SPACE_7    = 890
  integer, public, parameter :: ANY_SPACE_8    = 74
  integer, public, parameter :: ANY_SPACE_9    = 922
  integer, public, parameter :: ANY_SPACE_10   = 790
! IDs for any W2-type space regardless of continuity
  integer, public, parameter :: ANY_W2         = 353
! IDs for any discontinuous space
  integer, public, parameter :: ANY_DISCONTINUOUS_SPACE_1  = 43
  integer, public, parameter :: ANY_DISCONTINUOUS_SPACE_2  = 711
  integer, public, parameter :: ANY_DISCONTINUOUS_SPACE_3  = 267
  integer, public, parameter :: ANY_DISCONTINUOUS_SPACE_4  = 901
  integer, public, parameter :: ANY_DISCONTINUOUS_SPACE_5  = 174
  integer, public, parameter :: ANY_DISCONTINUOUS_SPACE_6  = 683
  integer, public, parameter :: ANY_DISCONTINUOUS_SPACE_7  = 425
  integer, public, parameter :: ANY_DISCONTINUOUS_SPACE_8  = 361
  integer, public, parameter :: ANY_DISCONTINUOUS_SPACE_9  = 536
  integer, public, parameter :: ANY_DISCONTINUOUS_SPACE_10 = 882

! Function space attributes
  integer, public, parameter :: GH_BASIS       = 751
  integer, public, parameter :: GH_DIFF_BASIS  = 767
  integer, public, parameter :: GH_ORIENTATION = 397
  integer, public, parameter :: GH_COLUMN_BANDED_DOFMAP = 541
  integer, public, parameter :: GH_COLUMN_INDIRECTION_DOFMAP = 204


! Kernel iterator
  integer, public, parameter :: CELLS     = 396
  integer, public, parameter :: ALL_DOFS  = 945

! Quadrature metadata
  integer, public, parameter :: GH_QUADRATURE_XYZ   = 912
  integer, public, parameter :: GH_QUADRATURE_XYoZ  = 849
  integer, public, parameter :: GH_QUADRATURE_XoYoZ = 701
  integer, public, parameter :: GH_QUADRATURE_face  = 539
  integer, public, parameter :: GH_QUADRATURE_edge  = 419

! Evaluator metadata
  integer, public, parameter :: GH_EVALUATOR        = 959

! Coarse and fine function spaces
  integer, public, parameter :: GH_FINE   = 27745
  integer, public, parameter :: GH_COARSE = 83491

  !> @defgroup stencil_items Enumeration of stencil types.
  !> @{
  integer, public, parameter :: XORY1D = 1
  integer, public, parameter :: X1D    = 2
  integer, public, parameter :: Y1D    = 3
  integer, public, parameter :: CROSS  = 4
  integer, public, parameter :: REGION = 5
  !> @}

  !> Allows metadata types to be syntactically correct.
  !>
  !> This is a dummy array which the enumerators can index. It is not a real
  !> thing it is just there to ensure the compiler is happy.
  !>
  !> @todo In an ideal world this would be implemented as a function which
  !>       would remove the need for 1-based monotonically increasing
  !>       enumerator values but GFortran doesn't like that.
  !>
  integer, public, parameter :: STENCIL(5) = -1

  !> @defgroup mesh_data_items Enumeration of mesh data items.
  !> @{
  integer, public, parameter :: adjacent_face                             = 533
  integer, public, parameter :: reference_element_number_horizontal_faces = 904
  integer, public, parameter :: reference_element_normal_to_face          = 171
  integer, public, parameter :: reference_element_out_face_normal         = 007
  !> @}

! Metadata argument type
  type, public :: arg_type
     integer :: arg_type         ! {GH_FIELD, GH_OPERATOR, GH_COLUMNWISE_OPERATOR, &
                                 !  GH_REAL, GH_INTEGER}
     integer :: arg_intent       ! {GH_READ, GH_WRITE, GH_READWRITE, GH_INC, &
                                 !  GH_SUM, GH_MIN, GH_MAX}
     integer :: wspace      = -1 ! {W0, W1, W2, W3, ANY_SPACE_[0-9]+, ANY_W2}
     integer :: from_wspace = -1 ! { " } only required for gh_operator
     integer :: stencil_map = -1 !{XORY1D,X1D,Y1D,CROSS} optional, type of stencil map to use
     integer :: mesh_arg    = -1 !{GH_FINE,GH_COARSE} optional, for inter mesh mapping kernels
  end type arg_type

! Metadata argument function space type
  type, public :: func_type
     integer :: wspace            ! {W0, W1, W2, W3, ANY_SPACE_[0-9]+, ANY_W2}
     integer :: wproperties1      ! {GH_BASIS, GH_DIFF_BASIS, GH_OPERATOR, &
                                  !  GH_COLUMN_BANDED_DOFMAP, &
                                  !  GH_COLUMN_INDIRECTION_DOFMAP}
     integer :: wproperties2 = -1 ! { " } optional and must be a distinct property
     integer :: wproperties3 = -1 ! { " } optional and must be a distinct property
  end type func_type

  !> Describes mesh data requirements used in kernel metadata.
  !>
  type, public :: mesh_data_type
    integer :: mesh_data_item
  end type mesh_data_type

end module argument_mod
