library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Clock is

Port ( CLK_i   : in std_logic := '0';
		 en_i    : in std_logic;
	    B_i     : in std_logic;
	    S_i     : out std_logic);
 
end Clock;


architecture Behavioral of Clock is

begin

process(CLK_i)

begin

 if (rising_edge(CLK_i)) then
 
		if (en_i='0') then
 
				if (B_i = '1') then
					 S_i <= '1';
  
				end if;
				else
				S_i <= '0';
			end if;
		end if;

	end process;

end Behavioral;

			
