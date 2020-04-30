library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PWM is
port (
   clk: in std_logic; 
   pr_in: in std_logic; 
   pr_de: in std_logic; 
   PWM_OUT: out std_logic 
  );
end PWM;

architecture Behavioral of PWM is

 component Clock 
 
 Port (  CLK_i : in std_logic;
			en_i : in std_logic;
			B_i : in std_logic;
			S_i : out std_logic
  );
 end component;
 
 signal slow_clk_en: std_logic:='0'; 
 signal counter_slow: std_logic_vector(27 downto 0):=(others => '0');
 signal tmp1,tmp2,duty_inc: std_logic;
 signal tmp3,tmp4,duty_dec: std_logic;
 signal counter_PWM: std_logic_vector(3 downto 0):=(others => '0');
 signal pr_cy: std_logic_vector(3 downto 0):=x"5";
 
begin


 process(clk)
 
 begin
 
  if(rising_edge(clk)) then
     counter_slow <= counter_slow + x"0000001";
   
			if(counter_slow>=x"0000001") then 
            counter_slow <= x"0000000";
   end if;
	
  end if;
  
 end process;

 slow_clk_en <= '1' when counter_slow = x"000001" else '0';
 stage0: Clock port map(clk,slow_clk_en , pr_in, tmp1);
 stage1: Clock port map(clk,slow_clk_en , tmp1, tmp2); 
 duty_inc <=  tmp1 and (not tmp2) and slow_clk_en;
 stage2: Clock port map(clk,slow_clk_en , pr_de, tmp3);
 stage3: Clock port map(clk,slow_clk_en , tmp3, tmp4); 
 duty_dec <=  tmp3 and (not tmp4) and slow_clk_en;

 process(clk)
 
 begin
 
  if(rising_edge(clk)) then
  
			if(duty_inc='1' and pr_cy <= x"9") then
            pr_cy <= pr_cy + x"1";
				
			elsif(duty_dec='1' and pr_cy>=x"1") then
               pr_cy <= pr_cy - x"1";
   end if;
	
  end if;
  
 end process;

 process(clk)
 begin
  if(rising_edge(clk)) then
     counter_PWM <= counter_PWM + x"1";
	  
			if(counter_PWM>=x"9") then
            counter_PWM <= x"0";
   end if;
	
  end if;
  
 end process;
 
 PWM_OUT <= '1' when counter_PWM < pr_cy else '0';
end Behavioral;