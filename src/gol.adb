with Raylib;       use Raylib;
with RaylibExtra;  use RaylibExtra;
with Interfaces.C; use Interfaces.C;
with C_Float_Elementary_Functions; use C_Float_Elementary_Functions;

procedure Gol is
   Cam : Camera2D := ((0.0, 0.0), (0.0, 0.0), 0.0, 1.0);

   Mouse_Wheel    : C_float;
   Mouse_Position : Vector2;
   Mouse_Delta    : Vector2;
begin
   SetConfigFlags (Interfaces.C.unsigned (FLAG_WINDOW_RESIZABLE));
   InitWindow (800, 600, "My Window");
   EnableCursor;
   SetTargetFPS (60);
   loop
      exit when WindowShouldClose;

      if IsMouseButtonDown (MOUSE_BUTTON_LEFT) then
         Mouse_Wheel := GetMouseWheelMove;
         Mouse_Delta := GetMouseDelta * (-1.0 / Cam.zoom);
         Cam.target := Cam.target + Mouse_Delta;
      end if;

      Mouse_Wheel := GetMouseWheelMove;
      if Mouse_Wheel /= 0.0 then
         Mouse_Position := GetMousePosition;
         Cam.target := GetScreenToWorld2D (Mouse_Position, Cam);
         Cam.offset := Mouse_Position;
         Cam.target := Cam.target + Mouse_Delta;
         Cam.zoom := Exp (Log (Cam.zoom) + 0.2 * Mouse_Wheel);
      end if;

      BeginDrawing;
      ClearBackground (RAYWHITE);
      BeginMode2D (Cam);

      DrawRectangle (0, 0, 100, 100, RED);

      EndMode2D;
      EndDrawing;
   end loop;
   CloseWindow;
end Gol;
