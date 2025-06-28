with Interfaces.C; use Interfaces.C;
with Raylib;       use Raylib;
with Simulation;   use Simulation;

package Render is
   Cell_Size  : constant C_float := 30.0;
   Grid_Color : constant Color := GRAY;
   Cell_Color : constant Color := DARKGRAY;

   type Unbounded_Cell_Coord is record
      x : Integer;
      y : Integer;
   end record;

   function World_To_Unbounded_Cell_Coord
     (v : in Vector2) return Unbounded_Cell_Coord;
   function Screen_To_Unbounded_Cell_Coord
     (v : in Vector2; Cam : Camera2D) return Unbounded_Cell_Coord;
   procedure Draw_Life_Grid (Cam : in Camera2D);
   procedure Draw_Cell (x : Cell_X; y : Cell_Y);
   procedure Draw_Life (Cells : in Life; Cam : in Camera2D);

end Render;
