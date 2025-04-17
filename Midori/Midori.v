----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:34:32 06/22/2020 
-- Design Name: 
-- Module Name:    Midori_enc - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Midori_enc is
    port (
        clk     : in  std_logic;
        rst     : in  std_logic;
        du_ctr  : out std_logic_vector(4 downto 0);
        du_en   : out std_logic_vector(2 downto 0);
        du_ld   : out std_logic;
        io_en   : in  std_logic;
        io_rdy  : out std_logic;
        trig    : out std_logic
    );
end Midori_enc;

-- =================================================================================================
-- architecture
-- =================================================================================================
architecture behavioural of Midori_enc is

    -- ---------------------------------------------------------------------------------------------
    -- constant declaration
    -- ---------------------------------------------------------------------------------------------
    constant FSM_TYPE   : string    := "COMPACT";
    constant ROUNDS     : natural   := 31;
    constant BYTES      : natural   := 8;
    
    -- ---------------------------------------------------------------------------------------------
    -- type declaration
    -- ---------------------------------------------------------------------------------------------
    type state_type is (BOOT, IDLE, LD0, LD1, ENC, ULD);
    
    -- ---------------------------------------------------------------------------------------------
    -- signal declaration
    -- ---------------------------------------------------------------------------------------------
    signal ctr                                  : natural range 1 to ROUNDS;--    
    signal ctr_en, ctr_clr, ctr_fl_b, ctr_fl_r  : std_logic;
    signal s_reg, s_next                        : state_type;
    
    -- ---------------------------------------------------------------------------------------------
    -- attribute declarations
    -- ---------------------------------------------------------------------------------------------
    attribute FSM_ENCODING : string;
    attribute FSM_ENCODING of s_reg	: signal is FSM_TYPE;
    
begin
    
    -- ---------------------------------------------------------------------------------------------
    -- counter assignment
    -- ---------------------------------------------------------------------------------------------
    process (clk)
    begin
        if (clk'event and clk='1') then
            if (rst='1') then
                ctr <= 1;
            elsif (ctr_en='1') then
                if (ctr_clr='1') then--     ־1
                    ctr <= 1;
                else
                    ctr <= ctr + 1;
                end if;
            end if;
        end if;
    end process;
    
    process (ctr)
    begin
        if (ctr=BYTES) then
            ctr_fl_b  <= '1';--     ־
        else
            ctr_fl_b  <= '0';
        end if;
    end process;
    
    process (ctr)
    begin
        if (ctr=ROUNDS) then--      ־
            ctr_fl_r  <= '1';
        else
            ctr_fl_r  <= '0';
        end if;
    end process;
    
    -- ---------------------------------------------------------------------------------------------
    -- finite state machine
    -- ---------------------------------------------------------------------------------------------
    -- state update
    process (clk)
    begin
        if (clk'event and clk='1') then
            if (rst='1') then
                s_reg   <= BOOT;
            else
                s_reg   <= s_next;
            end if;
        end if;
    end process;
    
    -- next state
    process (s_reg, io_en, ctr_fl_b, ctr_fl_r)
    begin
        -- default assignments
        ctr_en  <= '0';
        ctr_clr <= '0';
        du_en   <= "000";
        du_ld   <= '0';
        io_rdy	<= '0';
        trig    <= '1';
        
        -- fsm
        case s_reg is
            -- boot
            when BOOT =>
                s_next  <= IDLE;
            
            -- idle
            when IDLE =>
                io_rdy  <= '1';
                if (io_en='1') then
                    ctr_en  <= '1';
                    du_en   <= "011";
                    s_next  <= LD0;
                else 
                    trig    <= '0';
                    s_next  <= IDLE;
                end if;
            
            -- load data
            when LD0 =>
                ctr_en  <= '1';
                du_en   <= "011";
                if (ctr_fl_b='1') then
                    ctr_clr <= '1';
                    s_next  <= LD1;
                else
                    s_next  <= LD0;
                end if;
                
            when LD1 =>
                ctr_en  <= '1';
                du_en   <= "010";
                if (ctr_fl_b='1') then
                    ctr_clr <= '1';
                    s_next  <= ENC;
                else
                    s_next  <= LD1;
                end if;    
                
            -- data encryption
            when ENC =>
                ctr_en  <= '1';
                du_en   <= "011";
                du_ld   <= '1';
                if (ctr_fl_r='1') then
                    ctr_clr <= '1';
                    s_next  <= ULD;
                else
                    s_next  <= ENC;
                end if;
                
            -- unload data
            when ULD =>
                ctr_en  <= '1';
                du_en   <= "101";
                io_rdy  <= '1';
                if (ctr_fl_b='1') then
                    ctr_clr <= '1';
                    s_next  <= IDLE;
                else
                    s_next  <= ULD;
                end if;
                
        end case;
    end process;
    
    -- ---------------------------------------------------------------------------------------------
    -- signal assignment
    -- ---------------------------------------------------------------------------------------------
    du_ctr <= std_logic_vector(to_unsigned(ctr, 5));
    
end behavioural;
