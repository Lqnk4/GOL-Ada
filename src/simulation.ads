package Simulation
  with SPARK_Mode => On
is
   type Cell is (Dead, Alive);
   type Cell_X is range -(2**7) .. 2**7 - 1;
   type Cell_Y is range -(2**7) .. 2**7 - 1;
   type Life is array (Cell_X, Cell_Y) of Cell;

   type Cell_Coord is record
      x : Cell_X;
      y : Cell_Y;
   end record;

   function Next_Gen (Previous : in Life) return Life
   with Global => null, Depends => (Next_Gen'Result => Previous);

end Simulation;
