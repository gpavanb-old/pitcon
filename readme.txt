!*****************************************************************************80
!
!! PITCON is the user-interface routine for the continuation code.
!
!  A) Introduction:
!
!  PITCON solves nonlinear systems with one degree of freedom.
!
!  PITCON is given an N dimensional starting point X, and N-1 nonlinear
!  functions F, with F(X) = 0.  Generally, there will be a connected
!  curve of points Y emanating from X and satisfying F(Y) = 0.  PITCON
!  produces successive points along this curve.
!
!  The program can be used to study many sorts of parameterized problems,
!  including structures under a varying load, or the equilibrium
!  behavior of a physical system as some quantity is varied.
!
!  PITCON is a revised version of ACM TOMS algorithm 596.
!
!  Both versions are available via NETLIB, the electronic software
!  distribution service.  NETLIB has the original version in its TOMS
!  directory, and the current version in its CONTIN directory.
!  For more information, send the message "send index from contin"
!  to "netlib@research.att.com".
!
!
!  B) Acknowledgements:
!
!  PITCON was written by
!
!    Professor Werner C Rheinboldt and John Burkardt,
!    Department of Mathematics and Statistics
!    University of Pittsburgh,
!    Pittsburgh, Pennsylvania, 15260, USA.
!
!    E-Mail: wcrhein@vms.cis.pitt.edu
!            burkardt@psc.edu
!
!  The original work on this package was partially supported by the National
!  Science Foundation under grants MCS-78-05299 and MCS-83-09926.
!
!
!  C) Overview:
!
!  PITCON computes a sequence of solution points along a one dimensional
!  manifold of a system of nonlinear equations F(X) = 0 involving NVAR-1
!  equations and an NVAR dimensional unknown vector X.
!
!  The operation of PITCON is somewhat analogous to that of an initial value
!  ODE solver.  In particular, the user must begin the computation by
!  specifying an approximate initial solution, and subsequent points returned
!  by PITCON lie on the curve which passes through this initial point and is
!  implicitly defined by F(X) = 0.  The extra degree of freedom in the system is
!  analogous to the role of the independent variable in a differential
!  equations.
!
!  However, PITCON does not try to solve the algebraic problem by turning it
!  into a differential equation system.  Unlike differential equations, the
!  solution curve may bend and switch back in any direction, and there may be
!  many solutions for a fixed value of one of the variables.  Accordingly,
!  PITCON is not required to parametrize the implicitly defined curve with a
!  fixed parameter.  Instead, at each step, PITCON selects a suitable variable
!  as the current parameter and then determines the other variables as
!  functions of it.  This allows PITCON to go around relatively sharp bends.
!  Moreover, if the equations were actually differentiated - that is, replaced
!  by some linearization - this would introduce an inevitable "drift" away from
!  the true solution curve.  Errors at previous steps would be compounded in a
!  way that would make later solution points much less reliable than earlier
!  ones.  Instead, PITCON solves the algebraic equations explicitly and each
!  solution has to pass an acceptance test in an iterative solution process
!  with tolerances provided by the user.
!
!  PITCON is only designed for systems with one degree of freedom.  However,
!  it may be used on systems with more degrees of freedom if the user reduces
!  the available degrees of freedom by the introduction of suitable constraints
!  that are added to the set of nonlinear equations.  In this sense, PITCON may
!  be used to investigate the equilibrium behavior of physical systems with
!  several degrees of freedom.
!
!  Program options include the ability to search for solutions for which a
!  given component has a specified value.  Another option is a search for a
!  limit or turning point with respect to a given component; that is, of a
!  point where this particular solution component has a local extremum.
!
!  Another feature of the program is the use of two work arrays, IWORK and
!  RWORK.  All information required for continuing any interrupted computation
!  is saved in these two arrays.