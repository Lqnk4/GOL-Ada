with Interfaces.C; use Interfaces.C;
with Raylib; use Raylib;

package Render is

   Cell_Size : constant C_float := 30.0;

   type Cell_Coord is record
      x : Integer;
      y : Integer;
   end record;

   function To_Cell_Coord (v : in Vector2) return Cell_Coord;
   function Screen_To_Cell_Coord (v : in Vector2; Cam : Camera2D) return Cell_Coord;
   procedure Draw_Life_Grid (Cam : in Camera2D);
   procedure Draw_Cell (Position : in Cell_Coord);

end Render;
