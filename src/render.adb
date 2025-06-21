with RaylibExtra; use RaylibExtra;

package body Render is
   function To_Cell_Coord (v : in Vector2) return Cell_Coord is
   begin
      return (Integer (v.x), Integer (v.y));
   end To_Cell_Coord;

   function World_To_Cell_Coord (v : in Vector2) return Cell_Coord is
   begin
      return
        To_Cell_Coord
          ((C_float'Floor (v.x / Cell_Size),
            C_float'Floor (v.y / Cell_Size)));
   end World_To_Cell_Coord;

   function Screen_To_Cell_Coord
     (v : in Vector2; Cam : Camera2D) return Cell_Coord is
   begin
      return World_To_Cell_Coord (GetScreenToWorld2D (v, Cam));
   end Screen_To_Cell_Coord;

   procedure Draw_Life_Grid (Cam : in Camera2D) is
      Screen_Width  : constant int := GetScreenWidth;
      Screen_Height : constant int := GetScreenHeight;
      Screen_Origin : constant Vector2 := GetScreenToWorld2D ((0.0, 0.0), Cam);
      Grid_Color    : constant Color := GRAY;
      Draw_Start    : constant Vector2 :=
        (C_float'Floor (Screen_Origin.x / Cell_Size) * Cell_Size,
         C_float'Floor (Screen_Origin.y / Cell_Size) * Cell_Size);
      Num_Rows      : constant int :=
        (Screen_Height / int (Cell_Size * Cam.zoom)) + 1;
      Num_Columns   : constant int :=
        (Screen_Width / int (Cell_Size * Cam.zoom)) + 1;
      Row_Length    : constant C_float :=
        C_float (Screen_Width) * (1.0 / Cam.zoom) + Cell_Size;
      Column_Length : constant C_float :=
        C_float (Screen_Height) * (1.0 / Cam.zoom) + Cell_Size;
   begin
      for i in 0 .. Num_Rows loop
         DrawLineV
           (Draw_Start + (0.0, C_float (i) * Cell_Size),
            Draw_Start + (Row_Length, C_float (i) * Cell_Size),
            Grid_Color);
      end loop;
      for i in 0 .. Num_Columns loop
         DrawLineV
           (Draw_Start + (C_float (i) * Cell_Size, 0.0),
            Draw_Start + (C_float (i) * Cell_Size, Column_Length),
            Grid_Color);
      end loop;
   end Draw_Life_Grid;

   procedure Draw_Cell (Position : in Cell_Coord) is
   begin
      DrawRectangle
        (int (Position.x) * int (Cell_Size),
         int (Position.y) * int (Cell_Size),
         int (Cell_Size),
         int (Cell_Size),
         WHITE);
   end Draw_Cell;

end Render;
