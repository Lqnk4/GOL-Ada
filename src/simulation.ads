package Simulation is
   type Cell is (Dead, Alive);
   type Cell_X is range -(2**7) .. 2**7 - 1;
   type Cell_Y is range -(2**7) .. 2**7 - 1;
   type Life is array (Cell_X, Cell_Y) of Cell;

   type Cell_Coord is record
      x : Cell_X;
      y : Cell_Y;
   end record;

   procedure Next_Gen (Previous : in Life; Next : out Life);

end Simulation;
