program psy_layer
  use mix_prec_kernel_mod, only : mix_prec_kernel_type
  use field_mod, only : field_type, field_proxy_type
  use rsolver_field_mod, only : rsolver_field_type, rsolver_field_proxy_type

  type(field_type) :: f1
  type(field_proxy_type) :: f1_p
  type(rsolver_field_type) :: f2
  type(rsolver_field_proxy_type) :: f2_p

  type(mix_prec_kernel_type) :: mpk
  
  f1_p = f1%get_proxy()
  f2_p = f2%get_proxy()

  write(*,*) "Calling kernel with field_type"
  call mpk%mix_prec_code(f1_p%data)
  write(*,*) "Calling kernel with rsolver_field_type"  
  call mpk%mix_prec_code(f2_p%data)
  
end program psy_layer
