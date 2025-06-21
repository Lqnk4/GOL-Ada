with Raylib;                       use Raylib;
with RaylibExtra;                  use RaylibExtra;
with Interfaces.C;                 use Interfaces.C;
with C_Float_Elementary_Functions; use C_Float_Elementary_Functions;
with Render; use Render;

procedure Gol is
   Screen_Width  : constant int := 840;
   Screen_Height : constant int := 600;
   Cam           : Camera2D :=
     (
      --  (C_float (Screen_Width / 2), C_float (Screen_Height / 2)),
      (0.0, 0.0),
      (0.0, 0.0),
      0.0,
      1.0);

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
         Cam.zoom :=
           Clamp (Exp (Log (Cam.zoom) + 0.2 * Mouse_Wheel), 0.3, 64.0);
      end if;

      BeginDrawing;
      ClearBackground (BLACK);

      BeginMode2D (Cam);

      Draw_Life_Grid (Cam);
      DrawCircle (0, 0, 10.0, GREEN);

      Draw_Cell ((5, 5));
      Draw_Cell ((1000, 0));

      EndMode2D;


      DrawTextEx
        (GetFontDefault,
         "["
         & C_float'Image (GetScreenToWorld2D (Mouse_Position, Cam).x)
         & " "
         & C_float'Image (GetScreenToWorld2D (Mouse_Position, Cam).y)
         & "]",
         Mouse_Position + (-44.0, -24.0),
         20.0,
         2.0,
         WHITE);
      EndDrawing;

   end loop;
   CloseWindow;
end Gol;
