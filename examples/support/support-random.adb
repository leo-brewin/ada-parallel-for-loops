-- see
-- https://learn.adacore.com/courses/intro-to-ada/chapters/standard_library_numerics.html

with Ada.Numerics.Float_Random;
use  Ada.Numerics.Float_Random;

package body Support.Random is

   G : Generator;

   function rnd_real return Real -- Pick a uniform random number between 0.0 and 1.0
   is
   begin
      return Real (Ada.Numerics.Float_Random.Random (G));
   end rnd_real;

   function rnd_intg (low, high : Integer) return Integer -- Pick a uniform random integer between low and high
   is
      intg : Integer;
   begin
      if low >= high then
         intg := low;
      else
         intg := trunc (rnd_real * (high - low + 1) + low);
         if intg > high then
            intg := high;
         end if;
      end if;
      return intg;
   end rnd_intg;

begin

   Reset (G);

end Support.Random;
