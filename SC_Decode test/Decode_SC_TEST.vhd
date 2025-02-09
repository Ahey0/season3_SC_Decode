--DECODER 4*16--
library Ieee;
use ieee.std_logic_1164.all;
Entity Decoder4 is
 port(
      sel : in  std_logic_vector(3 downto 0) ;
      o   : out std_logic_vector(15 downto 0) 
      );
End Entity;
Architecture Decoder4_behave of Decoder4 is
signal  o1 : std_logic_vector(15 downto 0):="0000000000000001";
Begin
 process ( sel , o1 )
   begin
     case sel is
          when "0000" =>
               o1<="0000000000000001" ;
          when "0001" =>
               o1<="0000000000000010" ;
          when "0010" =>
               o1<="0000000000000100" ;
          when "0011" =>
               o1<="0000000000001000" ;
          when "0100" =>
               o1<="0000000000010000" ;
          when "0101" =>
               o1<="0000000000100000" ;
          when "0110" =>      
               o1<="0000000001000000" ;
          when "0111" =>
               o1<="0000000010000000" ;
          when "1000" =>
               o1<="0000000100000000" ;
          when "1001" =>   
               o1<="0000001000000000" ;
          when "1010" =>
               o1<="0000010000000000" ;
          when "1011" =>
               o1<="0000100000000000" ;
          when "1100" =>
               o1<="0001000000000000" ;
          when "1101" =>
               o1<="0010000000000000" ;
          when "1110" =>
               o1<="0100000000000000" ;
          when others =>
               o1<="1000000000000000" ;
     end case;
end process;
o<=o1;
End Architecture;
--SC--
library Ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_Unsigned.all;
Entity SC is
port( 
     clk   : in  std_logic                    ;
     clear : in  std_logic                    ;
     SCout : out std_logic_vector(3 downto 0) 
     );
End Entity;
Architecture SC_behave of SC is
Signal S_SCout : std_logic_vector(3 downto 0):="0000" ;
Begin
Process(clk)
variable  SS_SCout : std_logic_vector(3 downto 0):="0000" ;
    Begin
         if clk'event and clk='1' then
             if clear='1' or SS_SCout= "1111"  then
                S_SCout <= "0000" ;
                SS_SCout:= "0000" ;
             else
                S_SCout  <=  SS_SCout    ;
                SS_SCout :=  SS_SCout + "0001" ;
             end if;
         end if;
	end process;
SCout<= S_SCout;
End Architecture;
--Converter for segments--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
Entity CONVERTER is
port(
     INS      : in  std_logic_vector(15 downto 0)  ;
	  datadig1 : out integer  range 0 to 9          ;
	  datadig2 : out integer  range 0 to 9          ;
	  datadig3 : out integer  range 0 to 9          ;
	  datadig4 : out integer  range 0 to 9          ;
	  datadig5 : out integer  range 0 to 9          ;
	  clk      : in  std_logic
	  );
End Entity;
Architecture CONVERTER_Behave of CONVERTER is
signal data1     :  integer range 0 to 65535        ;
signal data2     :  integer range 0 to 65535        ;
signal data3     :  integer range 0 to 65535        ;
signal data4     :  integer range 0 to 65535        ;
signal data5     :  integer range 0 to 65535        ;
signal data6     :  integer range 0 to 65535        ;
signal OUTS     :  std_logic_vector(15 downto 0)  ;
Begin
		  OUTS      <= INS ;
		  data1      <= conv_integer(unsigned(OUTS));
		  datadig1  <= data1 rem 10  ;
		  data2      <= data1/10     ;
        datadig2  <= data2 rem 10  ;
		  data3      <= data2/10     ;
    	  datadig3  <= data3 rem 10  ;
        data4      <= data3/10     ;
		  datadig4  <= data4 rem 10  ;
		  data5      <= data4/10     ; 
		  datadig5  <= data5 rem 10  ;
End Architecture;
--clock controll --
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_Unsigned.all;
Entity Clock_controll_50MHZ_T_50HZ is 
  port(
        clkin   : in  std_logic     ;
        EN      : in  std_logic     ;
        reset   : in  std_logic     ;
        clkout  : out std_logic     
       );
End Entity;
Architecture Clock_Controll_50MHZ_T_50HZ_Behave of Clock_controll_50MHZ_T_50HZ is
signal clkout_s : std_logic := '0' ;
Begin 
Process (clkin)
variable CH : integer range 0 to 1000000 := 0  ; 
    begin
     if EN='1' then
        if reset='0' then 
         if clkin'event and clkin='1' then
             if CH = 1000000 then 
                CH := 0 ;
                clkout_s <= Not clkout_s ;
             else
                CH := CH + 1 ;
             end if;  
         end if ;
        else 
         CH := 0 ;
        end if;
      end if;
end process;
clkout <= clkout_s ;
End Architecture;
------------------------------
Library Ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_Unsigned.all;
Entity Decode_SC_TEST is
   Port(
        EN      : in  std_logic                      ;
        clear   : in  std_logic                      ;
        Reset   : in  std_logic                      ;
        clk     : in  std_logic                      ;
        outp    : out std_logic_vector(7 downto 0 )  ;
        switch  : in  std_logic                      ;
        dig1    : out std_logic_vector(6 downto 0)   ;
        dig2    : out std_logic_vector(6 downto 0)   ;
        dig3    : out std_logic_vector(6 downto 0)   ;
        dig4    : out std_logic_vector(6 downto 0)   ;
        dig5    : out std_logic_vector(6 downto 0)   
       );
End Entity ;
Architecture TB_Decode_SC_TEST of Decode_SC_TEST is
Component Decoder4 is
 port(
      sel : in  std_logic_vector(3 downto 0) ;
      o   : out std_logic_vector(15 downto 0) 
      );
End Component;
Component SC is
port( 
     clk   : in  std_logic                    ;
     clear : in  std_logic                    ;
     SCout : out std_logic_vector(3 downto 0) 
     );
End Component;
Component CONVERTER is
port(
     INS      : in  std_logic_vector(15 downto 0)  ;
	  datadig1 : out integer  range 0 to 9          ;
	  datadig2 : out integer  range 0 to 9          ;
	  datadig3 : out integer  range 0 to 9          ;
	  datadig4 : out integer  range 0 to 9          ;
	  datadig5 : out integer  range 0 to 9          ;
	  clk      : in  std_logic
	  );
End Component;
Component Clock_controll_50MHZ_T_50HZ is 
  port(
        clkin   : in  std_logic     ;
        EN      : in  std_logic     ;
        reset   : in  std_logic     ;
        clkout  : out std_logic     
       );
End Component;
Signal clk0    : std_logic                    ;
signal CU      : std_logic_vector(3 downto 0) ;
signal S_DEC   : std_logic_vector(15 downto 0);
signal S_dig1  : integer  range 0 to 9        ;
signal S_dig2  : integer  range 0 to 9        ;
signal S_dig3  : integer  range 0 to 9        ;
signal S_dig4  : integer  range 0 to 9        ; 
signal S_dig5  : integer  range 0 to 9        ;
signal SS_dig1 : integer  range 0 to 9        ;
signal SS_dig2 : integer  range 0 to 9        ;
Begin
outp <= S_DEC(7 downto 0 ) ;
X1 : SC port map (clk0 ,clear,CU);  
X2 : Decoder4 port map (CU,S_DEC);
X3 : Clock_controll_50MHZ_T_50HZ port map (clk,EN,Reset,Clk0);
X4 : CONVERTER port map (S_DEC,S_Dig1,S_Dig2,S_Dig3,S_Dig4,S_Dig5,clk0);
X5 : CONVERTER port map (S_DEC,SS_Dig1,SS_Dig2,open,open,open,clk0);
Process(S_DEC,S_Dig1,S_Dig2,S_Dig3,S_Dig4,S_Dig5,SS_Dig1,SS_Dig2,clk0)
 Begin
      If clk0'event and clk0='1' then
         IF Switch='0' then
    Case S_dig1 IS 
		    When 0 =>
			     dig1<=Not "0111111" ;
			 when 1 => 
	           dig1<=Not "0000110" ;
			 when 2 =>
	           dig1<=Not "1011011" ;
		    when 3 =>
	           dig1<=Not "1001111" ;
		    when 4 =>
	           dig1<=Not "1100110" ;
		  	 when 5 =>
              dig1<=Not "1101101" ;
			 when 6 =>
	           dig1<=Not "1111101" ;
			 when 7 =>
	           dig1<=Not "0000111" ;
			 when 8 => 
	           dig1<=Not "1111111" ;
			 when 9 =>
	           dig1<=Not "1101111" ;		
		 End case;
		Case S_Dig2 IS 
		    When 0 =>
			     dig2<=Not "0111111" ;
			 when 1 => 
	           dig2<=Not "0000110" ;
			 when 2 =>
	           dig2<=Not "1011011" ;
		    when 3 =>
	           dig2<=Not "1001111" ;
		    when 4 =>
	           dig2<=Not "1100110" ;
		  	 when 5 =>
              dig2<=Not "1101101" ;
			 when 6 =>
	           dig2<=Not "1111101" ;
			 when 7 =>
	           dig2<=Not "0000111" ;
			 when 8 => 
	           dig2<=Not "1111111" ;
			 when 9 =>
	           dig2<=Not "1101111" ;		
		 End case; 
		 Case S_Dig3 IS 
		    When 0 =>
			     dig3<=Not "0111111" ;
			 when 1 => 
	           dig3<=Not "0000110" ;
			 when 2 =>
	           dig3<=Not "1011011" ;
		    when 3 =>
	           dig3<=Not "1001111" ;
		    when 4 =>
	           dig3<=Not "1100110" ;
		  	 when 5 =>
              dig3<=Not "1101101" ;
			 when 6 =>
	           dig3<=Not "1111101" ;
			 when 7 =>
	           dig3<=Not "0000111" ;
			 when 8 => 
	           dig3<=Not "1111111" ;
			 when 9 =>
	           dig3<=Not "1101111" ;		
		 End case;
		Case S_Dig4 IS 
		    When 0 =>
			     dig4<=Not "0111111" ;
			 when 1 => 
	           dig4<=Not "0000110" ;
			 when 2 =>
	           dig4<=Not "1011011" ;
		    when 3 =>
	           dig4<=Not "1100110" ;
		    when 4 =>
	           dig4<=Not "1110010" ;
		  	 when 5 =>
              dig4<=Not "1101101" ;
			 when 6 =>
	           dig4<=Not "1111101" ;
			 when 7 =>
	           dig4<=Not "0000111" ;
			 when 8 => 
	           dig4<=Not "1111111" ;
			 when 9 =>
	           dig4<=Not "1101111" ;		
		 End case; 
		 Case S_Dig5 IS 
		    When 0 =>
			     dig5<=Not "0111111" ;
			 when 1 => 
	           dig5<=Not "0000110" ;
			 when 2 =>
	           dig5<=Not "1011011" ;
		    when 3 =>
	           dig5<=Not "1001111" ;
		    when 4 =>
	           dig5<=Not "1100110" ;
		  	 when 5 =>
              dig5<=Not "1101101" ;
			 when 6 =>
	           dig5<=Not "1111101" ;
			 when 7 =>
	           dig5<=Not "0000111" ;
			 when 8 => 
	           dig5<=Not "1111111" ;
			 when 9 =>
	           dig5<=Not "1101111" ;		
		 End case;
      Elsif Switch='1' then
          dig5<=Not "0111111" ;
          dig4<=Not "0111111" ;
          dig3<=Not "0111111" ;
         Case SS_dig1 IS 
		    When 0 =>
			     dig1<=Not "0111111" ;
			 when 1 => 
	           dig1<=Not "0000110" ;
			 when 2 =>
	           dig1<=Not "1011011" ;
		    when 3 =>
	           dig1<=Not "1001111" ;
		    when 4 =>
	           dig1<=Not "1100110" ;
		  	 when 5 =>
              dig1<=Not "1101101" ;
			 when 6 =>
	           dig1<=Not "1111101" ;
			 when 7 =>
	           dig1<=Not "0000111" ;
			 when 8 => 
	           dig1<=Not "1111111" ;
			 when 9 =>
	           dig1<=Not "1101111" ;		
		 End case;
		Case SS_Dig2 IS 
		    When 0 =>
			     dig2<=Not "0111111" ;
			 when 1 => 
	           dig2<=Not "0000110" ;
			 when 2 =>
	           dig2<=Not "1011011" ;
		    when 3 =>
	           dig2<=Not "1001111" ;
		    when 4 =>
	           dig2<=Not "1100110" ;
		  	 when 5 =>
              dig2<=Not "1101101" ;
			 when 6 =>
	           dig2<=Not "1111101" ;
			 when 7 =>
	           dig2<=Not "0000111" ;
			 when 8 => 
	           dig2<=Not "1111111" ;
			 when 9 =>
	           dig2<=Not "1101111" ;		
		 End case; 
  End if;
End if;
End process;
End Architecture;
