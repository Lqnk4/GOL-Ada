with Raylib;       use Raylib;
with Interfaces.C; use Interfaces.C;

package RaylibExtra is

   function "+" (lhs : Vector2; rhs : Vector2) return Vector2;
   pragma Import (C, "+", "Vector2Add");

   function "-" (lhs : Vector2; rhs : Vector2) return Vector2
   with Import => True, Convention => C, External_Name => "Vector2Subtract";

   function "*" (v : Vector2; scale : C_float) return Vector2;
   pragma Import (C, "*", "Vector2Scale");

   function "-" (v : Vector2) return Vector2
   with Import => True, Convention => C, External_Name => "Vector2Negate";

end RaylibExtra;
