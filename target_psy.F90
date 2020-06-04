  MODULE mp_alg_mod_psy
    USE constants_mod, ONLY: r_def, i_def, r_solver
    USE field_mod, ONLY: field_type, field_proxy_type
    use rsolver_field_mod, only : rsolver_field_type, rsolver_field_proxy_type 
    IMPLICIT NONE
    CONTAINS
    SUBROUTINE invoke_0_mix_prec_kernel_type(f1, f2)
      USE mix_prec_kernel_mod, ONLY: mix_prec_code
!      USE mix_prec_kernel_mod, ONLY: mix_prec_kernel_type       
      TYPE(field_type), intent(in) :: f2
      type(rsolver_field_type), intent(inout) :: f1
!      INTEGER(KIND=i_def) cell
!      INTEGER(KIND=i_def) nlayers
      TYPE(field_proxy_type) ::f2_proxy
      type(rsolver_field_proxy_type) :: f1_proxy
!      INTEGER(KIND=i_def), pointer :: map_aspc1_f1(:,:) => null()
!      INTEGER(KIND=i_def) ndf_aspc1_f1, undf_aspc1_f1
      !      TYPE(mesh_type), pointer :: mesh => null()
!      type(mix_prec_kernel_type) :: mi_kernel ! F2K3 OO overload. Not using this
      !
      ! Initialise field and/or operator proxies
      !
      f1_proxy = f1%get_proxy()
      f2_proxy = f2%get_proxy()
      !
      ! Initialise number of layers
      !
!      nlayers = f1_proxy%vspace%get_nlayers()
      !
      ! Create a mesh object
      !
!      mesh => f1_proxy%vspace%get_mesh()
      !
      ! Look-up dofmaps for each function space
      !
!      map_aspc1_f1 => f1_proxy%vspace%get_whole_dofmap()
      !
      ! Initialise number of DoFs for aspc1_f1
      !
!      ndf_aspc1_f1 = f1_proxy%vspace%get_ndf()
!      undf_aspc1_f1 = f1_proxy%vspace%get_undf()
      !
      ! Call kernels and communication routines
      !
!      IF (f2_proxy%is_dirty(depth=1)) THEN
!        CALL f2_proxy%halo_exchange(depth=1)
!      END IF
      !
!     DO cell=1,mesh%get_last_halo_cell(1)
        !
      !        CALL mix_prec_code(nlayers, f1_proxy%data, f2_proxy%data, ndf_aspc1_f1, undf_aspc1_f1, map_aspc1_f1(:,cell))
      call mix_prec_code(f1_proxy%data, f2_proxy%data)
!      call mi_kernel%mix_prec_code(f1_proxy%data, f2_proxy%data)       ! F2K3 OO overload. Not using this
!      END DO
      !
      ! Set halos dirty/clean for fields modified in the above loop
      !
!      CALL f1_proxy%set_dirty()
      !
      !
    END SUBROUTINE invoke_0_mix_prec_kernel_type
  END MODULE mp_alg_mod_psy
