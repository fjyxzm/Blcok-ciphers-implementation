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
-- Company: 			CINVESTAV Campus Tamaulipas
-- Engineer: 			Carlos Andres Lara-Nino
-- 
-- Create Date:    	22:06:28 08/09/2017 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MixColumn is
	generic(
		n : integer := 128
	);
	port(
		state		: in	std_logic_vector(n-1 downto 0);
		nstate	: out	std_logic_vector(n-1 downto 0)
	);
end MixColumn;

architecture Behavioral of MixColumn is

constant w : integer := n/4;

component MC 
	generic(
		w : integer := 32
	);
	port(
		col	: in	std_logic_vector(w-1 downto 0);
		ncol	: out	std_logic_vector(w-1 downto 0)
	);
end component;

signal c0, c1, c2, c3 : std_logic_vector(w-1 downto 0);
signal nc0, nc1, nc2, nc3 : std_logic_vector(w-1 downto 0);

begin

g : for i in 0 to 3 generate
	inst_MC : MC
		generic map (w =>w)
		port map (col=>state(w-1+i*w downto 0+i*w), ncol=>nstate(w-1+i*w downto 0+i*w));
end generate;

end Behavioral;

