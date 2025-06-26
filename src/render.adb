with RaylibExtra; use RaylibExtra;

package body Render is
   function To_Unbounded_Cell_Coord
     (v : in Vector2) return Unbounded_Cell_Coord is
   begin
      return (Integer (v.x), Integer (v.y));
   end To_Unbounded_Cell_Coord;

   function World_To_Unbounded_Cell_Coord
     (v : in Vector2) return Unbounded_Cell_Coord is
   begin
      return
        To_Unbounded_Cell_Coord
          ((C_float'Floor (v.x / Cell_Size), C_float'Floor (v.y / Cell_Size)));
   end World_To_Unbounded_Cell_Coord;

   function Screen_To_Unbounded_Cell_Coord
     (v : in Vector2; Cam : Camera2D) return Unbounded_Cell_Coord is
   begin
      return World_To_Unbounded_Cell_Coord (GetScreenToWorld2D (v, Cam));
   end Screen_To_Unbounded_Cell_Coord;

   procedure Draw_Life_Grid (Cam : in Camera2D) is
      Screen_Width  : constant int := GetScreenWidth;
      Screen_Height : constant int := GetScreenHeight;
      Screen_Origin : constant Vector2 := GetScreenToWorld2D ((0.0, 0.0), Cam);
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
      for I in 0 .. Num_Rows loop
         DrawLineV
           (Draw_Start + (0.0, C_float (I) * Cell_Size),
            Draw_Start + (Row_Length, C_float (I) * Cell_Size),
            Grid_Color);
      end loop;
      for I in 0 .. Num_Columns loop
         DrawLineV
           (Draw_Start + (C_float (I) * Cell_Size, 0.0),
            Draw_Start + (C_float (I) * Cell_Size, Column_Length),
            Grid_Color);
      end loop;
   end Draw_Life_Grid;

   procedure Draw_Cell (x : Cell_X; y : Cell_Y) is
   begin
      DrawRectangle
        (int (x) * int (Cell_Size),
         int (y) * int (Cell_Size),
         int (Cell_Size),
         int (Cell_Size),
         Cell_Color);
   end Draw_Cell;

   procedure Draw_Life (Cells : in Life; Cam : in Camera2D) is
      Top_Left     : constant Unbounded_Cell_Coord :=
        Screen_To_Unbounded_Cell_Coord ((0.0, 0.0), Cam);
      Bottom_Right : constant Unbounded_Cell_Coord :=
        Screen_To_Unbounded_Cell_Coord
          ((C_float (GetScreenWidth), C_float (GetScreenHeight)), Cam);
      Min_X        : Integer;
      Max_X        : Integer;
      Min_Y        : Integer;
      Max_Y        : Integer;
   begin
      Min_X := Integer'Max (Integer (Cells'First (1)), Top_Left.x);
      Max_X := Integer'Min (Integer (Cells'Last (1)), Bottom_Right.x);
      Min_Y := Integer'Max (Integer (Cells'First (2)), Top_Left.y);
      Max_Y := Integer'Min (Integer (Cells'Last (2)), Bottom_Right.y);
      -- Unfortunately is easiest by iterating with standard integer
      for I in Min_X .. Max_X loop
         for J in Min_Y .. Max_Y loop
            if Cells (Cell_X (I), Cell_Y (J)) = Alive then
               Draw_Cell (Cell_X (I), Cell_Y (J));
            end if;
         end loop;
      end loop;
   end Draw_Life;

end Render;
