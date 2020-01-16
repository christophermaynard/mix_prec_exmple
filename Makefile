FC=gfortran-7
FC_FLAGS=

objects=constants_mod.o \
	field_mod.o \
	mix_prec_kernel_mod.o \
	psy_mod.o 

all: $(objects)
	$(FC) -o mp $(objects)

%.o: %.F90
	$(FC) -c $(FC_FLAGS) $<


