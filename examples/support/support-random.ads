package Support.Random is

   function rnd_real return Real; -- Pick a uniform random number between 0.0 and 1.0
   function rnd_intg (low, high : Integer) return Integer; -- Pick a uniform random integer between low and high

end Support.Random;
