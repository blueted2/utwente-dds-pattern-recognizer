library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY pattern_recognizer IS
    PORT (
        data, reset, clk : IN std_logic;
        seg1, seg2 : OUT std_logic_vector(6 downto 0)
    ); 
END pattern_recognizer;

ARCHITECTURE behavior of pattern_recognizer IS

function int_to_7_seg(val : integer) return std_logic_vector IS 
    BEGIN
        case val is 
            when 0      => return "0000001";
            when 1      => return "1001111";
            when 2      => return "0010010";
            when 3      => return "0000110";
            when 4      => return "1001100";
            when 5      => return "0100100";
            when 6      => return "0100000";
            when 7      => return "0001111";
            when 8      => return "0000001";
            when 9      => return "0000100";
            when others => return "1111110";
        END case;
    END function;
BEGIN
    PROCESS(reset, clk)
        VARIABLE last_bits : std_logic_vector(4 DOWNTO 0);
        VARIABLE count, first_digit, second_digit : integer := 0;
        -- <your declarations>
        BEGIN
        -- no code here
        if reset='0' then -- reset is active low
            count := 0;
            last_bits := "00000";
            seg1 <= int_to_7_seg(-1);
            seg2 <= int_to_7_seg(-1);
            -- reset actions
        elsif rising_edge(clk) then
            -- shift last_bits to the left by one and append new data
            last_bits := last_bits(3 DOWNTO 0) & data;

            if count > 99 then
                -- in function int_to_7_seg it will return - -
                first_digit := -1;
                second_digit := -1;
            else
                first_digit := count mod 10;
                second_digit := (count - first_digit) / 10;
            end if;

            if last_bits = "11000" then
                count := count + 1;
            end if;

            seg1 <= int_to_7_seg(first_digit);
            seg2 <= int_to_7_seg(second_digit);

            -- seg1 <= "00" & std_logic_vector(last_bits);
            -- synchronous actions (sequential)
        end if;
        -- no code here
    END PROCESS;
END behavior;