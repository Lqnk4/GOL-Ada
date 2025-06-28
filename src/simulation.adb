package body Simulation
  with SPARK_Mode => On
is
   function Next_Gen (Previous : in Life) return Life is
      Next                : Life :=
        [Life'Range (1) => [Life'Range (2) => Dead]];
      Neighbor_Coords     : constant array (1 .. 8) of Cell_Coord :=
        [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)];
      Alive_Neighbors : Natural := 0;
   begin
      -- TODO: find a way to do cover the whole range including the boundary
      for I in Previous'First (1) + 1 .. Previous'Last (1) - 1 loop
         pragma Loop_Invariant (Alive_Neighbors = 0);
         for J in Previous'First (2) + 1 .. Previous'Last (2) - 1 loop
            pragma Loop_Invariant (Alive_Neighbors = 0);
            for K in Neighbor_Coords'Range loop
               pragma Loop_Invariant (Alive_Neighbors < K);
               if Previous
                    (Neighbor_Coords (K).x + I, Neighbor_Coords (K).y + J)
                 = Alive
               then
                  Alive_Neighbors := Natural'Succ(Alive_Neighbors);
               end if;
            end loop;
            case Previous (I, J) is
               when Alive =>
                  if Alive_Neighbors = 2 or Alive_Neighbors = 3 then
                     Next (I, J) := Alive;
                  else
                     Next (I, J) := Dead;
                  end if;

               when Dead =>
                  if Alive_Neighbors = 3 then
                     Next (I, J) := Alive;
                  else
                     Next (I, J) := Dead;
                  end if;
            end case;
            Alive_Neighbors := 0;
         end loop;
      end loop;
      return Next;
   end Next_Gen;
end Simulation;
