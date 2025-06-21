with Raylib;                       use Raylib;
with RaylibExtra;                  use RaylibExtra;
with Interfaces.C;                 use Interfaces.C;
with C_Float_Elementary_Functions; use C_Float_Elementary_Functions;
with Render;                       use Render;

procedure Gol is
   Screen_Width  : constant int := 840;
   Screen_Height : constant int := 600;
   Cam           : Camera2D := ((0.0, 0.0), (0.0, 0.0), 0.0, 1.0);

   Mouse_Wheel    : C_float;
   Mouse_Position : Vector2;
   Mouse_Delta    : Vector2;
begin
   SetConfigFlags (Interfaces.C.unsigned (FLAG_WINDOW_RESIZABLE));
   InitWindow (Screen_Width, Screen_Height, "My Window");
   EnableCursor;
   SetTargetFPS (60);
   loop
      exit when WindowShouldClose;
      Mouse_Wheel := GetMouseWheelMove;
      Mouse_Position := GetMousePosition;

      if IsMouseButtonDown (MOUSE_BUTTON_LEFT) then
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

      BeginDrawing;
      ClearBackground (BLACK);
      BeginMode2D (Cam);
      Draw_Life_Grid (Cam);
      DrawCircle (0, 0, 10.0, GREEN);
      Draw_Cell ((5, 5));
      Draw_Cell ((1000, 0));
      Draw_Cell (Screen_To_Cell_Coord (Mouse_Position, Cam));
      EndMode2D;

      DrawFPS (20, 20);
      DrawTextEx
        (GetFontDefault,
         Cell_Coord'Image (Screen_To_Cell_Coord (Mouse_Position, Cam)),
         Mouse_Position + (0.0, -64.0),
         20.0,
         2.0,
         WHITE);
      EndDrawing;

   end loop;
   CloseWindow;
end Gol;
