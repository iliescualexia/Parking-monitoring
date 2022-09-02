library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;  

entity parcare is
	 generic (N:integer:=4);	   ---nr total de locuri in parcare
	Port(
	clk: in std_logic;
	reset: in std_logic;
	i1: in std_logic_vector(1 downto 0);	 ---i1(0) primul senzor din prima intrare, i1(1) al doilea senzor din prima intrare
	i2: in std_logic_vector(1 downto 0);	 ---i2(0) primul senzor din a doua intrare, i2(1) al doilea senzor din a doua intrare
	o1: in std_logic_vector(1 downto 0);     ---o1(0) primul senzor din prima iesire, o1(1) al doilea senzor din prima iesire
	o2: in std_logic_vector(1 downto 0);	 ---o2(0) primul senzor din a doua iesire, o2(1) al doilea senzor din a doua iesire
	nr_locuri_disponibile: out integer;
	FULL: out std_logic;  
	EMPTY: out std_logic
	);
end entity;	

architecture arhi_parcare of parcare is	   

signal aux: integer:=N;		
signal full_aux: std_logic:='0';
signal empty_aux: std_logic:='1';

begin
 	
process(clk,reset,aux)	
begin
	if reset='1' then aux<=N;
	elsif clk='1' and clk'event then	
		if full_aux='0' then
			
			if i1="11" then aux<=aux-1;
			end if;				   
		
			if i2="11" then aux<=aux-1;
			end if;
		end if;
		
		if empty_aux='0' then 
			
			if o1="11" then aux<=aux+1;
			end if;		 
		
			if o2="11" then aux<=aux+1;	 
			end if;
		end if;
		
	end if;
	if aux=N then empty_aux<='1';
	else empty_aux<='0';	
	end if;		
	if aux=0 then full_aux<='1';
	else full_aux<='0'; 
	end if;
end process;
nr_locuri_disponibile<=aux;
FULL<=full_aux;
EMPTY<=empty_aux;
end arhi_parcare;