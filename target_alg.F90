PROGRAM mp_alg_mod
  use constants_mod, only : r_def, r_solver
  USE mp_alg_mod_psy, ONLY: invoke_0_mix_prec_kernel_type
  USE mix_prec_kernel_mod, ONLY: mix_prec_kernel_type
  USE field_mod, ONLY: field_type, field_proxy_type
  USE rsolver_field_mod, ONLY: rsolver_field_type, rsolver_field_proxy_type
  TYPE(field_type) :: f2
  TYPE(rsolver_field_type) :: f1
  f1 % data = 2.718_r_def
  f2 % data = 3.142_r_solver
  CALL invoke_0_mix_prec_kernel_type(f1, f2)
END PROGRAM mp_alg_mod
