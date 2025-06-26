package body Simulation is

   procedure Next_Gen (Previous : in Life; Next : out Life) is
      type Neighbor_Index is range 1 .. 8;
      Neighbor_Coords     : constant array (Neighbor_Index) of Cell_Coord :=
        [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)];
      Num_Alive_Neighbors : Integer := 0;
   begin
      -- TODO: find a type safe way to do cover the whole range including the boundary
      for I in Previous'First (1) + 1 .. Previous'Last (1) - 1 loop
         for J in Previous'First (2) + 1 .. Previous'Last (2) - 1 loop
            for K in Neighbor_Coords'Range loop
               if Previous
                    (Neighbor_Coords (K).x + I, Neighbor_Coords (K).y + J)
                 = Alive
               then
                  Num_Alive_Neighbors := @ + 1;
               end if;
            end loop;
            case Previous (I, J) is
               when Alive =>
                  if Num_Alive_Neighbors = 2 or Num_Alive_Neighbors = 3 then
                     Next (I, J) := Alive;
                  else
                     Next (I, J) := Dead;
                  end if;

               when Dead =>
                  if Num_Alive_Neighbors = 3 then
                     Next (I, J) := Alive;
                  else
                     Next (I, J) := Dead;
                  end if;
            end case;
            Num_Alive_Neighbors := 0;
         end loop;
      end loop;
   end Next_Gen;

end Simulation;
