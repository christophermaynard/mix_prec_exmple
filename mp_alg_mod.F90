program mp_alg_mod
  
  use contants_mod, only : r_def, r_solver
  use mix_prec_kernel_mod, only : mix_prec_kernel_type
  use field_mod, only : field_type, field_proxy_type
  use rsolver_field_mod, only : rsolver_field_type, rsolver_field_proxy_type

 type(field_type) :: f2
 type(rsolver_field_type) :: f1

 ! fill them with data
 f1%data = 2.718_r_def
 f2%data = 3.142_r_solver

 ! call a kernel
 call invoke( mix_prec_kernel_type( f1, f2 ) )

 ! done!
 
end program mp_alg_mod  
