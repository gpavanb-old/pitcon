F90=gfortran

OBJDIR=obj
LIBDIR=lib
OBJ_FOR_LIB=pitcon7.o binder.o
OBJ_DEST=$(addprefix $(OBJDIR)/,$(OBJ_FOR_LIB))

%.o : %.f90
	@mkdir -p obj
	@echo "Compiling $*.f90 ..."
	@$(F90) -c $*.f90 -o $(OBJDIR)/$*.o 

libpitcon.a : $(OBJ_FOR_LIB)
	@mkdir -p lib
	@$(AR) rcs $(LIBDIR)/$@ $(OBJ_DEST)
	@chmod 755 $(LIBDIR)/$@
	@ranlib $(LIBDIR)/$@

all: libpitcon.a

clean:
	@-rm -f *~
	@-rm -rf lib obj
	@-rm -f $(OBJDIR)/*.o
	@-rm -f $(LIBDIR)/libpitcon.a
