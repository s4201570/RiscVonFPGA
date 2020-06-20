
////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                example
////////////////////////////////////////////////////////////////////////////////////////////////////
// -- Descr: Verilog header generated by InstantSOC 1.1.0 by FPGA-cores.com
// -- Date:  03-06-2020 22:34:24
// -- Src:   c:\InstantSOC\Project1\example.cpp
////////////////////////////////////////////////////////////////////////////////////////////////////

// ----------------
// -- LICENSE
// ----------------
// -- Copyright (C) 2019 FPGA-Cores.com. 
// -- This code is only free to use for non-commercial use and for evaluation purpose.
// -- Commercial use needs a commercial license - contact FPGA-Cores.com.
// -- The code is generated on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// 
// -- -------------
// -- DISCLAIMER
// -- -------------
// -- THIS CODE GENERATED BY TOOLS FROM FPGA-Cores.com IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
// -- THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL FPGA-Cores.com OR ANY 
// -- OF THEIR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
// -- PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
// -- WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS CODE, EVEN IF 
// -- ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// --
// -- Without limiting the foregoing, FPGA-Cores.com make no warranty that:
// --    * the code will meet your requirements.
// --    * the code will be uninterrupted, timely, secure or error-free.
// --    * the results that may be obtained from the use of the code will be effective, accurate or reliable.
// --    * the quality of the code will meet your expectations.
// --    * any errors in the tools will be corrected.
// --
// -- The generated code and its documentation:
// --    * could include technical or other mistakes, inaccuracies or typographical errors. 
// --    * may be out of date and FPGA-Cores.com, its contributors, and FPGA Cores make no commitment to update such materials.
// --
// -- The use of the generated code is done at your own discretion and risk and with agreement 
// -- that you will be solely responsible for any damage to your system or loss of data that results from such activities. 
// -- No advice or information, whether oral or written, obtained by you from FPGA-Cores.com, its website, shall create any warranty for the code.
// 

module example(
    input  clk,
    output uart_tx,
    output [15:0] LEDs,
    output accel_SCLK,
    output accel_MOSI,
    input  accel_MISO,
    output accel_SSn,
    output [7:0] s7_seg,
    output [7:0] s7_sel
);
endmodule
