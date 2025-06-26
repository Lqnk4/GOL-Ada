with Raylib;                       use Raylib;
with Interfaces.C;                 use Interfaces.C;
with C_Float_Elementary_Functions; use C_Float_Elementary_Functions;
with RaylibExtra;                  use RaylibExtra;
with Render;                       use Render;
with Simulation;                   use Simulation;

procedure Gol is
   Screen_Width   : constant int := 840;
   Screen_Height  : constant int := 600;
   Cam            : Camera2D :=
     ((C_float (Screen_Width) / 2.0, C_float (Screen_Height) / 2.0),
      (0.0, 0.0),
      0.0,
      1.0);
   Mouse_Wheel    : C_float;
   Mouse_Position : Vector2;
   Mouse_Delta    : Vector2;

   Previous_Cells : Life := [Life'Range (1) => [Life'Range (2) => Dead]];
   Next_Cells     : Life;

begin
   SetConfigFlags
     (Interfaces.C.unsigned (FLAG_VSYNC_HINT or FLAG_WINDOW_RESIZABLE));
   InitWindow (Screen_Width, Screen_Height, "My Window");
   EnableCursor;
   while not WindowShouldClose loop
      Mouse_Wheel := GetMouseWheelMove;
      Mouse_Position := GetMousePosition;

      if IsMouseButtonDown (MOUSE_BUTTON_MIDDLE) then
         Mouse_Wheel := GetMouseWheelMove;
         Mouse_Delta := GetMouseDelta * (-1.0 / Cam.zoom);
         Cam.target := Cam.target + Mouse_Delta;
      end if;

      if Mouse_Wheel /= 0.0 then
         Cam.offset := Mouse_Position;
         Cam.target := GetScreenToWorld2D (Mouse_Position, Cam);
         Cam.zoom :=
           Clamp (Exp (Log (Cam.zoom) + 0.2 * Mouse_Wheel), 0.27, 64.0);
      end if;

      if IsMouseButtonPressed (MOUSE_BUTTON_LEFT) then
         declare
            Hover_Coord : constant Unbounded_Cell_Coord :=
              Screen_To_Unbounded_Cell_Coord (Mouse_Position, Cam);
            Hover_X : Cell_X;
            Hover_Y : Cell_Y;
         begin
            if Hover_Coord.x
               in Integer (Previous_Cells'First (1))
                .. Integer (Previous_Cells'Last (1))
              and Hover_Coord.y
                  in Integer (Previous_Cells'First (2))
                   .. Integer (Previous_Cells'Last (2))
            then
               Hover_X := Cell_X (Hover_Coord.x);
               Hover_Y := Cell_Y (Hover_Coord.y);
               case Previous_Cells (Hover_X, Hover_Y) is
                  when Alive => Previous_Cells (Hover_X, Hover_Y) := Dead;
                  when Dead => Previous_Cells (Hover_X, Hover_Y) := Alive;
               end case;
            end if;
         end;
      end if;

      if IsKeyPressed (KEY_SPACE) then
         Next_Gen (Previous_Cells, Next_Cells);
         Previous_Cells := Next_Cells;
      end if;

      BeginDrawing;
      ClearBackground (RAYWHITE);
      BeginMode2D (Cam);
      Draw_Life (Previous_Cells, Cam);
      Draw_Life_Grid (Cam);
      DrawCircle (0, 0, 10.0, GREEN);
      EndMode2D;

      DrawFPS (20, 20);
      DrawTextEx
        (GetFontDefault,
         Unbounded_Cell_Coord'Image
           (Screen_To_Unbounded_Cell_Coord (Mouse_Position, Cam)),
         Mouse_Position + (0.0, -100.0),
         20.0,
         2.0,
         BLACK);
      EndDrawing;

   end loop;
   CloseWindow;
end Gol;
