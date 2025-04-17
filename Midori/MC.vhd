----------------------------------------------------------------------------------
-- Copyright (c) 2018 CINVESTAV Unidad Tamaulipas
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
----------------------------------------------------------------------------------
-- Design: MixColumn operation for the Midori cipher.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MC is
	generic(
		w : integer := 32
	);
	port(
		col	: in	std_logic_vector(w-1 downto 0);
		ncol	: out	std_logic_vector(w-1 downto 0)
	);
end MC;

architecture Behavioral of MC is

constant c : integer := w/4;

signal c0, c1, c2, c3 : std_logic_vector(c-1 downto 0);
signal nc0, nc1, nc2, nc3, cc0,cc1: std_logic_vector(c-1 downto 0);--

begin

c0 <= col(c-1+0*c downto 0*c);
c1 <= col(c-1+1*c downto 1*c);
c2 <= col(c-1+2*c downto 2*c);
c3 <= col(c-1+3*c downto 3*c);

cc0 <= c2 xor c3;
cc1 <= c1 xor c0;

nc0 <= c1 xor cc0;--c2 xor c3;--
nc1 <= c0 xor cc0;--c2 xor c3;--
nc2 <= cc1 xor c3;--c1 xor c0 xor c3;--
nc3 <= cc1 xor c2;--c1 xor c0 xor c2;--

ncol <= nc3 & nc2 & nc1 & nc0;

end Behavioral;

