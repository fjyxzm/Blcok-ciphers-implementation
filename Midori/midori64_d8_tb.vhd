--------------------------------------------------------------------------------
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY midori64_d8_tb IS
END midori64_d8_tb;
 
ARCHITECTURE behavior OF midori64_d8_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TOP
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         P : IN  std_logic_vector(7 downto 0);
         Q : IN  std_logic_vector(7 downto 0);
         START : IN  std_logic;
         T : OUT  std_logic_vector(7 downto 0);
         BUSY : OUT  std_logic;
         DONE : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal P : std_logic_vector(7 downto 0) := (others => '0');
   signal Q : std_logic_vector(7 downto 0) := (others => '0');
   signal START : std_logic := '0';

 	--Outputs
   signal T : std_logic_vector(7 downto 0);
   signal BUSY : std_logic;
   signal DONE : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 1000 ps;
	--constant CLK_period : time := 6018 ps;
	
	signal ref_output : std_logic_vector(63 downto 0) := (others => '0');
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TOP PORT MAP (
          CLK => CLK,
          RST => RST,
          P => P,
          Q => Q,
          START => START,
          T => T,
          BUSY => BUSY,
          DONE => DONE
        );

   -- Clock process definitions
   CLK_process :process (clk)
   begin
		clk <= not clk after CLK_PERIOD/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      RST <= '1';
      wait for CLK_period;
		RST <= '0';
		wait for CLK_period;
		START <= '1';
		wait for CLK_period;
		START <= '0';
		P <= x"24";
		Q <= x"86";
		wait for CLK_period;
		P <= x"2c";
		Q <= x"d7";
		wait for CLK_period;
		P <= x"f0";
		Q <= x"de";
		wait for CLK_period;
		P <= x"3d";
		Q <= x"b3";
		wait for CLK_period;
		P <= x"5b";
		Q <= x"c3";
		wait for CLK_period;
		P <= x"68";
		Q <= x"58";
		wait for CLK_period;
		P <= x"78";
		Q <= x"3b";
		wait for CLK_period;
		P <= x"e9";
		Q <= x"3f";
		wait for CLK_period;
		P <= x"00";
		Q <= x"b5";
		wait for CLK_period;
		Q <= x"01";
		wait for CLK_period;
		Q <= x"90";
		wait for CLK_period;
		Q <= x"68";
		wait for CLK_period;
		Q <= x"e3";
		wait for CLK_period;
		Q <= x"a2";
		wait for CLK_period;
		Q <= x"c8";
		wait for CLK_period;
		Q <= x"fb";
		wait for CLK_period;
		Q <= x"fb";
		wait for CLK_period;
		Q <= x"00";
		ref_output <= x"dc109d0726cdcb66";
		wait for CLK_period*50;
		START <= '1';
		wait for CLK_period;
		START <= '0';
		P <= x"00";
		Q <= x"00";
		wait for CLK_period*16;
		ref_output <= x"a944dbb2adecc9c3";
		wait for CLK_period*50;

      wait;
   end process;

END;
