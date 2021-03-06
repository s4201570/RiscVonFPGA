
----------------------------------------------------------------------------------------------------
--                                                example
----------------------------------------------------------------------------------------------------
-- Descr: VHDL generated by InstantSOC 1.1.0 by FPGA-cores.com
-- Date:  03-06-2020 22:34:24
-- Src:   c:\InstantSOC\Project1\example.cpp
----------------------------------------------------------------------------------------------------

----------------
-- LICENSE
----------------
-- Copyright (C) 2019 FPGA-Cores.com. 
-- This code is only free to use for non-commercial use and for evaluation purpose.
-- Commercial use needs a commercial license - contact FPGA-Cores.com.
-- The code is generated on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

-- -------------
-- DISCLAIMER
-- -------------
-- THIS CODE GENERATED BY TOOLS FROM FPGA-Cores.com IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
-- THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL FPGA-Cores.com OR ANY 
-- OF THEIR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
-- PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
-- WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS CODE, EVEN IF 
-- ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-- Without limiting the foregoing, FPGA-Cores.com make no warranty that:
--    * the code will meet your requirements.
--    * the code will be uninterrupted, timely, secure or error-free.
--    * the results that may be obtained from the use of the code will be effective, accurate or reliable.
--    * the quality of the code will meet your expectations.
--    * any errors in the tools will be corrected.
--
-- The generated code and its documentation:
--    * could include technical or other mistakes, inaccuracies or typographical errors. 
--    * may be out of date and FPGA-Cores.com, its contributors, and FPGA Cores make no commitment to update such materials.
--
-- The use of the generated code is done at your own discretion and risk and with agreement 
-- that you will be solely responsible for any damage to your system or loss of data that results from such activities. 
-- No advice or information, whether oral or written, obtained by you from FPGA-Cores.com, its website, shall create any warranty for the code.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity example_TB is
end entity;

architecture SIM of example_TB is

    component example is
    port(
        clk : in std_logic;
        uart_tx : out std_logic;
        LEDs : out std_logic_vector(15 downto 0);
        accel_SCLK : out std_logic;
        accel_MOSI : out std_logic;
        accel_MISO : in std_logic;
        accel_SSn : out std_logic;
        s7_seg : out std_logic_vector(7 downto 0);
        s7_sel : out std_logic_vector(7 downto 0)
    );
    end component;

    signal clk : std_logic := '0';
    signal uart_tx : std_logic := '0';
    signal uart_tx_rxd : std_logic_vector(7 downto 0) := x"00";
    signal LEDs : std_logic_vector(15 downto 0) := (others=>'0');
    signal accel_SCLK : std_logic := '0';
    signal accel_MOSI : std_logic := '0';
    signal accel_MISO : std_logic := '0';
    signal accel_SSn : std_logic := '0';
    signal s7_seg : std_logic_vector(7 downto 0) := (others=>'0');
    signal s7_sel : std_logic_vector(7 downto 0) := (others=>'0');

begin

    --- The Device Under Test ---
    DUT : example
    port map(
        clk => clk,
        uart_tx => uart_tx,
        LEDs => LEDs,
        accel_SCLK => accel_SCLK,
        accel_MOSI => accel_MOSI,
        accel_MISO => accel_MISO,
        accel_SSn => accel_SSn,
        s7_seg => s7_seg,
        s7_sel => s7_sel
    );

    -- Clock Generation 100 MHz
    clk <= not clk after 5 ns;



    --- Test process for UART_RX ---
    process is
        variable b : std_logic_vector(7 downto 0) := x"00";
    begin
        wait until uart_tx = '0';
        wait for 13.0208 us;
        for i in 0 to 7 loop
            b(i) := uart_tx;
            wait for 8.68056 us;
        end loop;
        uart_tx_rxd <= b;
    end process;



    --- SPI Test Process ---
    -- CPOL=0, CPHA=0
    process is        
        variable dout : unsigned(7 downto 0);
        variable li : integer := 5;
    begin
        accel_MISO <= '0';
        wait until accel_SSn = '0';
        dout := to_unsigned(li, 8); 
        accel_MISO <= dout(dout'high);
        for i in 0 to 7 loop
            wait until accel_SCLK = '0';
            dout := dout(dout'high-1 downto 0)&'0';
            accel_MISO <= dout(dout'high);
        end loop;
        wait until accel_SSn = '1';
        li := li + 1;
    end process;



end architecture;
