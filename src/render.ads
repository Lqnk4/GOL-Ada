with Interfaces.C; use Interfaces.C;
with Raylib; use Raylib;

package Render is

   Cell_Size : constant C_float := 30.0;

   type Cell_Coord is record
      x : Integer;
      y : Integer;
   end record;

   procedure Draw_Life_Grid (Cam : in Camera2D);
   procedure Draw_Cell (Position : in Cell_Coord);

end Render;
