with Raylib;       use Raylib;
with Interfaces.C; use Interfaces.C;

package RaylibExtra is

   function Vector2Add (lhs : Vector2; rhs : Vector2) return Vector2;
   pragma Import (C, Vector2Add, "Vector2Add");

   function "+" (lhs : Vector2; rhs : Vector2) return Vector2;
   pragma Import (C, "+", "Vector2Add");

   function Vector2Subtract (lhs : Vector2; rhs : Vector2) return Vector2
   with Import => True, Convention => C, External_Name => "Vector2Subtract";

   function "-" (lhs : Vector2; rhs : Vector2) return Vector2
   with Import => True, Convention => C, External_Name => "Vector2Subtract";

   function Vector2Scale (v : Vector2; scale : C_float) return Vector2;
   pragma Import (C, Vector2Scale, "Vector2Scale");

   function "*" (v : Vector2; scale : C_float) return Vector2;
   pragma Import (C, "*", "Vector2Scale");

   function Vector2Negate (v : Vector2) return Vector2
      with Import => True, Convention => C, External_Name => "Vector2Negate";

   function "-" (v : Vector2) return Vector2
   with Import => True, Convention => C, External_Name => "Vector2Negate";

   function Clamp (value : C_float; min : C_float; max : C_float) return C_float;
   pragma Import(C, Clamp, "Clamp");

end RaylibExtra;
