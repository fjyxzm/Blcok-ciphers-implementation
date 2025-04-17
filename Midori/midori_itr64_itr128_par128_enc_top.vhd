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
-- Company: 		CINVESTAV UNIDAD TAMAULIPAS
-- Engineer: 		LARA-NINO, CARLOS ANDRES
-- 
-- Create Date:   19:59:10 03/07/2018 
-- Design Name: 	ITERATIVE ARCHTIECTURE FOR THE MIDORI BLOCK CIPHER
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TOP is
GENERIC(
	N	: INTEGER :=64;	--STATE WIDTH
	K	: INTEGER :=128;	--KEY WIDTH
	R	: INTEGER :=5; 	--ROUND COUNTER
	D	: INTEGER :=8		--IO WIDTH
);
PORT(
	CLK		: IN	STD_LOGIC;								-- CLOCKING SIGNAL
	RST		: IN	STD_LOGIC;								-- RESET SIGNAL
	P			: IN	STD_LOGIC_VECTOR(D-1 DOWNTO 0);	-- PART OF THE PLAINTEXT BLOCK
	Q			: IN	STD_LOGIC_VECTOR(D-1 DOWNTO 0);	-- PART OF THE CIPHER KEY
	START		: IN	STD_LOGIC;								-- SIGNAL THAT STARTS THE PROCESS
	T			: OUT	STD_LOGIC_VECTOR(D-1 DOWNTO 0);	-- N-BIT PART OF THE CIPHEREDTEXT BLOCK
	BUSY		: OUT	STD_LOGIC;								-- SIGNAL THAT INDICATES THAT THE CIPHER IS BUSY
	DONE		: OUT	STD_LOGIC								-- SIGNAL THAT INDICATES THAT THE RESULT IS READY
);
end TOP;

architecture Behavioral of TOP is

COMPONENT SubCell
	generic(
		n : integer := 8;
		i : integer := 0
	);
	port(
		s_in		: in	std_logic_vector(n-1 downto 0);
		s_out		: out	std_logic_vector(n-1 downto 0)
	);
end COMPONENT;

COMPONENT ShuffleCell
	generic(
		n : integer := 128;
		c : integer := 8
	);
	port(
		state		: in	std_logic_vector(n-1 downto 0);
		nstate	: out	std_logic_vector(n-1 downto 0)
	);
end COMPONENT;

COMPONENT MixColumn
	generic(
		n : integer := 128
	);
	port(
		state		: in	std_logic_vector(n-1 downto 0);
		nstate	: out	std_logic_vector(n-1 downto 0)
	);
end COMPONENT;

COMPONENT RoundKeys
	generic(
		m : integer := 128;
		r : integer := 5
	);
	port(
		key 		: in	std_logic_vector(m-1 downto 0);
		round		: in	std_logic_vector(r-1 downto 0);
		nkey		: out	std_logic_vector(m-1 downto 0)
	);
end COMPONENT;
	
	COMPONENT universal_shift_reg is 
    generic (
        DEP : natural;
        DIR : natural range 0 to 1 := 0;
        WID : natural
    );
    port(
        clk : in  std_logic;
        rst : in  std_logic;
        en  : in  std_logic; 
        ld  : in  std_logic;
        pi  : in  std_logic_vector(DEP*WID-1 downto 0);
        po  : out std_logic_vector(DEP*WID-1 downto 0);
        si  : in  std_logic_vector(WID-1 downto 0);
        so  : out std_logic_vector(WID-1 downto 0)
    );
end COMPONENT;
	
	CONSTANT S : INTEGER := 16;
	CONSTANT C : INTEGER := N/S;
	CONSTANT M_K : INTEGER := K/D;
	CONSTANT M_S : INTEGER := N/D;
	
	SIGNAL SP,SN		: STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL WKEY	: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL CNT,NCNT,L	: STD_LOGIC_VECTOR(R-1 DOWNTO 0);

	SIGNAL SBC_IN, SBC_OUT : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL SHC_IN, SHC_OUT : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL MC_IN, MC_OUT : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL ARK_A, ARK_B : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL ARK_OUT : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL KS_IN, KS_OUT : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL KS_CNT : STD_LOGIC_VECTOR(R-1 DOWNTO 0);
	
	SIGNAL KR_EN,KR_LD : STD_LOGIC;
	SIGNAL KR_PI,KR_PO : STD_LOGIC_VECTOR(K-1 DOWNTO 0);
	SIGNAL KR_SI,KR_SO : STD_LOGIC_VECTOR(D-1 DOWNTO 0);
	SIGNAL DR_EN,DR_LD : STD_LOGIC;
	SIGNAL DR_PI,DR_PO : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL DR_SI,DR_SO : STD_LOGIC_VECTOR(D-1 DOWNTO 0);

begin

	BUSY <= '0' WHEN (SP = "000") ELSE '1';
	DONE <= '1' WHEN (SP = "101") ELSE '0';

	SBC_IN <= DR_PO;
	SHC_IN <= SBC_OUT;
	MC_IN <= SHC_OUT;

	ARK_A <= MC_OUT WHEN (SP = "011") ELSE SBC_OUT WHEN (SP = "100") ELSE DR_PO WHEN (SP = "010") ELSE (OTHERS => '0');
	ARK_B <= WKEY WHEN (SP = "010" OR SP = "100") ELSE KS_OUT WHEN (SP = "011") ELSE (OTHERS => '0');
	ARK_OUT <= ARK_A XOR ARK_B;

	KS_CNT <= CNT WHEN (SP = "011") ELSE (OTHERS => '0');
	
	G3 : IF N = 128 GENERATE
		WKEY <= KR_PO;
		KS_IN <= KR_PO;
	END GENERATE;

	G4 : IF N = 64 GENERATE
		WKEY <= KR_PO(127 DOWNTO 64) XOR KR_PO(63 DOWNTO 0);
		KS_IN <= KR_PO(127 DOWNTO 64) WHEN ((CNT(0) = '1') AND SP = "011") ELSE 
					KR_PO(63 DOWNTO 0) WHEN ((CNT(0) = '0') AND SP = "011") ELSE (OTHERS => '0');
	END GENERATe;
	
	
	KR_EN <= '1' WHEN (SP = "001" OR SP = "101") ELSE '0';
	KR_LD <= '0';
	KR_PI <= KR_PO;
	KR_SI <= Q WHEN (SP = "001") ELSE (OTHERS => '0');
	
	DR_EN <= '1' WHEN (((SP = "001") AND (CNT < M_S)) OR (SP > "001")) ELSE '0';
	DR_LD <= '1' WHEN ((SP = "010") OR (SP = "011") OR (SP = "100")) ELSE '0';
	DR_PI <= ARK_OUT;
	DR_SI <= P WHEN (SP = "001") ELSE (OTHERS => '0');
	
	T <= DR_SO WHEN (SP = "101") ELSE (OTHERS => '0');
	
	G0 : IF N = 64 GENERATE
		L <= "01110";
	END GENERATE;
	
	G1 : IF N = 128 GENERATE
		L <= "10010";
	END GENERATE;

	P1 : PROCESS(SP, START, CNT, L)
	BEGIN
		CASE SP IS
			WHEN "000" => --IDLE
				IF (START = '1') THEN
					SN <= "001";
				ELSE
					SN <= SP;
				END IF;
				NCNT <= (OTHERS => '0');
			WHEN "001" => --INITIALIZE
				IF (CNT = M_K-1) THEN
					SN <= "010";
				ELSE
					SN <= SP;
				END IF;
				NCNT <= CNT + '1';
			WHEN "010" => --ADD WHITENING KEY
				SN <= "011";					
				NCNT <= (OTHERS => '0');
			WHEN "011" => --ITERATE
				IF (CNT = L) THEN
					SN <= "100";
					NCNT <= CNT;
				ELSE
					SN <= SP;
					NCNT <= CNT + '1';
				END IF;
			WHEN "100" => --FINAL SUBSTITUTION AND KEY ADDITION
				SN <= "101";
				NCNT <= (OTHERS => '0');
			WHEN "101" => --PRODUCE RESULT
				IF (CNT = M_S-1) THEN
					SN <= "000";
				ELSE
					SN <= SP;
				END IF;
				NCNT <= CNT + '1';
			WHEN OTHERS => 
				SN <= (OTHERS => '0');
				NCNT <= (OTHERS => '0');
		END CASE;
	END PROCESS P1;

	P2 : PROCESS(CLK)
	BEGIN
		IF RISING_EDGE(CLK) THEN
			IF (RST = '1') THEN
				SP <= (OTHERS => '0');  
				CNT <= (OTHERS => '0');
			ELSE
				SP <= SN;
				CNT <= NCNT;
			END IF;
		END IF;
	END PROCESS P2;
	
	G2 : FOR I IN 0 TO S-1 GENERATE
		SBC : SubCell
			GENERIC MAP (N => C, I =>(I MOD 4))
			PORT MAP (S_IN=>SBC_IN((C-1)+((4*C)*(I/4))+((I MOD 4)*C) DOWNTO 0+((4*c)*(I/4))+((I MOD 4)*C)), S_OUT=>SBC_OUT((C-1)+((4*C)*(I/4))+((I MOD 4)*C) DOWNTO 0+((4*c)*(I/4))+((I MOD 4)*C)));
	END GENERATE;
	
	SHC : ShuffleCell
		GENERIC MAP(N =>N, C =>C)
		PORT MAP(STATE =>SHC_IN, NSTATE =>SHC_OUT);

	MC : MixColumn
		GENERIC MAP(N =>N)
		PORT MAP(STATE =>MC_IN, NSTATE =>MC_OUT);
	
	RK : RoundKeys
		GENERIC MAP(M =>N, R =>R)
		PORT MAP(KEY =>KS_IN, ROUND =>KS_CNT, NKEY =>KS_OUT);

	KEY_REG : universal_shift_reg
		GENERIC MAP(DEP =>M_K, DIR =>1, WID =>D)
		PORT MAP(CLK =>CLK, RST =>RST, EN =>KR_EN, LD =>KR_LD, PI =>KR_PI, PO =>KR_PO, SI =>KR_SI, SO =>KR_SO);
	
	STATE_REG : universal_shift_reg
		GENERIC MAP(DEP =>M_S, DIR =>1, WID =>D)
		PORT MAP(CLK =>CLK, RST =>RST, EN =>DR_EN, LD =>DR_LD, PI =>DR_PI, PO =>DR_PO, SI =>DR_SI, SO =>DR_SO);

end Behavioral;

