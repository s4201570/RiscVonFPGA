#include <math.h>

#include "fc_io.h"
#include "fc_system.h"

short Read_ADXL362(FC_IO_SPI& spi, U8 reg)
{
    U8 buff[4] = {0x0B, reg, 0x00, 0x00 };
    spi.WriteRead( buff, buff, 4 );

    return buff[3]<<8|buff[2];
}

int int_to_char(int num)
{
    return (fabs(num) + 48);
}

U32 To7Seg(int d) 
{
    switch(d) {
        case 0: return 0x3F; break; //    	0x7E	on	on	on	on	on	on	off
        case 1: return 0x06; break; //    	0x30	off	on	on	off	off	off	off
        case 2: return 0x5B; break; //    	0x6D	on	on	off	on	on	off	on
        case 3: return 0x4F; break; //    	0x79	on	on	on	on	off	off	on
        case 4: return 0x66; break; //    	0x33	off	on	on	off	off	on	on
        case 5: return 0x6D; break; //    	0x5B	on	off	on	on	off	on	on
        case 6: return 0x7D; break; //    	0x5F	on	off	on	on	on	on	on
        case 7: return 0x07; break; //    	0x70	on	on	on	off	off	off	off
        case 8: return 0x7F; break; //    	0x7F	on	on	on	on	on	on	on
        case 9: return 0x6F; break; //    	0x7B	on	on	on	on	off	on	on
        //case '-': return 0x40; break; //	    0x47	on	off	off	off	on	on	on}
        default: return 0x00;
    }
}

void SetDisplay(FC_IO_SegmentDisplay& d, int di, int value)
{
    bool neg = value < 0;
    value = abs(value);
    
    // Rightmost digit
    d.SetDisplay( ~To7Seg(value%10),di);
    
    value /= 10;
    
    d.SetDisplay( ~(To7Seg(value%10)|0x80),di+1);  // Add decimal dot
    
    value /= 10;
    
    // Leftmost value digit
    if(value!=0)
        d.SetDisplay( ~To7Seg(value),di+2); 
    else
        d.SetDisplay( ~(0x00),di+2); 

    // Add sign mark
    if(neg)
        d.SetDisplay( ~(0x40),di+3);
    else
        d.SetDisplay( ~(0x00),di+3);
}

int main()
{
    //% hw_begin
    FC_IO_Clk clk(100);
    FC_IO_UART_TX uart_tx(115200,32);
    FC_IO_Out LEDs(16);
    FC_IO_SPI accel(1000000,0,8);
    FC_System_Timer timer;
    FC_IO_SegmentDisplay s7(8,8,0);
    //% hw_end

    uart_tx << "Hello World!\r\n";
    int led_pos = 0x80;   // One active LED in the middle
    int sum = 0;

    U8 start[3] = {0x0A,0x2D,0x02};
    accel.StartWrite( start, 3 );     // Start the ADXL362 accelerometer 
    accel.WaitReady();

    timer.Start(1, TU_us);
    for (;;)
    {

        timer.Sleep(200,TU_ms);

        float x = Read_ADXL362(accel,0x0E); 
        float y = Read_ADXL362(accel,0x10); 
        float z = Read_ADXL362(accel,0x12); 

        int roll = atanf( x/sqrtf(powf(y,2.0)+powf(z,2.0))  ) * 573.0f;
        int pitch = atanf( y/sqrtf(powf(x,2.0)+powf(z,2.0))  ) * 573.0f;

        // Write angles to UART with 1 decimal

        if (( roll >= 0) && (pitch >= 0)) 
        {
            uart_tx << "\r" 
                << int_to_char( (roll/100)%10 ) << int_to_char( (roll/10)%10 ) << "." << " \t" 
                << int_to_char( (pitch/100)%10 ) << int_to_char( (pitch/10)%10 ) << "." << " \t";
        } else if (( roll < 0) && (pitch >= 0)) 
        {
            uart_tx << "\r" << '-' 
                << int_to_char( (roll/100)%10 ) << int_to_char( (roll/10)%10 ) << "." << " \t" 
                << int_to_char( (pitch/100)%10 ) << int_to_char( (pitch/10)%10 ) << "." << " \t";
        } else if (( roll < 0) && (pitch < 0)) 
        {
            uart_tx << "\r" << '-' 
                << int_to_char( (roll/100)%10 ) << int_to_char( (roll/10)%10 ) << "." << " \t" 
                << '-' << int_to_char( (pitch/100)%10 )  << int_to_char( (pitch/10)%10 )<< "." << " \t";
        } else if (( roll >= 0) && (pitch < 0)) 
        {
            uart_tx << "\r" 
                << int_to_char( (roll/100)%10 ) << int_to_char( (roll/10)%10 ) << "." << " \t" 
                << '-' << int_to_char( (pitch/100)%10 ) << int_to_char( (pitch/10)%10 ) << "." << " \t";
        }

        SetDisplay(s7,0,roll);
        SetDisplay(s7,4,pitch);

        // Calculate a rolling-LED effect based on pitch angle
        sum += pitch;
        if(sum<-250) {
            if(led_pos!=0x01)
                led_pos >>= 1;    // Shift the active LED right
            sum = 0;
        } else if (sum>250) {
            if(led_pos!=0x01<<15)
                led_pos <<= 1;    // Shift the active LED left
            sum = 0;
        }

        LEDs = led_pos;
    }
}
