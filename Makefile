FC=gfortran-7
FC_FLAGS=

objects=constants_mod.o \
	argument_mod.o \
	kernel_mod.o \
	field_mod.o \
	mix_prec_kernel_mod.o \
	target_psy.o \
	target_alg.o

all: $(objects)
	$(FC) -o mp $(objects)

%.o: %.F90
	$(FC) -c $(FC_FLAGS) $<

clean:
	rm mp *.o *.mod
