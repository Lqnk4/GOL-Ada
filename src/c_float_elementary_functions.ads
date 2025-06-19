with Ada.Numerics.Generic_Elementary_Functions;
with Interfaces.C;

package C_Float_Elementary_Functions is
  new Ada.Numerics.Generic_Elementary_Functions (Interfaces.C.C_float);

pragma Pure (C_Float_Elementary_Functions);
