LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY TestBench IS
END TestBench;
 
ARCHITECTURE behavior OF TestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PWM
    PORT(
         clk : IN  std_logic;
         pr_in : IN  std_logic;
         pr_de : IN  std_logic;
         PWM_OUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal pr_in : std_logic := '0';
   signal pr_de : std_logic := '0';

 	--Outputs
   signal PWM_OUT : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PWM PORT MAP (
          clk => clk,
          pr_in => pr_in,
          pr_de => pr_de,
          PWM_OUT => PWM_OUT
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

 -- Stimulus process
   stim_proc: process
   begin  
	wait for 100 ns;	

wait for clk_period*10;

		pr_in <= '1';
		wait for 20 ns;
		pr_de <= '1';
		wait for 100 ns;
		pr_in <= '0';
		wait for 20 ns;
		pr_de <= '0';
		wait for 300 ns;
		
		pr_de <= '1';
		wait for 20 ns;
		pr_in <= '1';
		wait for 100 ns;
		pr_de <= '0';
		wait for 20 ns;
		pr_in <= '0';
		wait for 300 ns;
		
	

      wait;
   end process;

END;
