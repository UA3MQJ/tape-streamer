`timescale 1ns/1ns

//    1 us =   1 MHz
//  100 ns =  10 MHz
//   10 ns = 100 MHz
//    1 ns =   1 GHz
//  zx spectrum freq - 3.5 MHz (285.71428571429 ns(p) ~ 286 / 2 = 143 ns)
//  3500000 ticks = 1s
//
// tape
//     2168          2168          667        1710      855
//   +------+      +------+      +-----+     +----+    +---+   +--
//   |      | 2168 |      | 2168 |     | 735 |    |1710|   |855|
// --+      +------+      +------+     +-----+    +----+   +---+
//
//   |    Pilot                  |  SYN      |   1     |  0    |
//   |<------------------------->|<--------->|<------->|<----->|<--...
//
//   Pilot ~= 619,4 мкс. Freq ~= 810 Hz (1.25ms). Time 5s - header, 2s - data.
//   Sync. ?? 0 - 0.19мс, 1 - 0.21мс.
//   Data. 0 - 2047hz (0.489мс). 1 - 1023hz (0.978мс)
//   
//
//  Logical struct
//       |<-size->|
//  BYTE -  DATA  - BYTE
//   ^------------------ 00h - header or FFh data. or other for users
//           ^---------- data some bytes
//                 ^---- CRC  with header byte
//  
//  Pilot tone 5s for header types 0..7, for >7 - 2s.

///  Byte
//        1 - Type. 
//              0 - Basic program,
//              1 - digital array,
//              2 - symbol array,
//              3 - byte file (code or screen)
//     2-11 - File name in ASCII, or without name (first byte - 255)
//    12-13 - File size
//    14-15 - For type=0 - start program number (or first byte 80H if no autostart)
//            for type=3 - load address
//            for type=1,2 - 2st byte contain array name (one ASCII symbol)
//
//
// standard file contain 2 blocks
// 1 - header 17 bytes
// 2 - data


module testbench();

reg tb_clk;


initial
begin
    $dumpfile("bench.vcd");
    $dumpvars(0,testbench);

    $display("starting testbench!!!!");

	tb_clk <= 0;
	repeat (3500000) begin
		#143;
		tb_clk <= 1;
		#143;
		tb_clk <= 0;
	end
	
    $display("finished OK!");
    $finish;

end

endmodule
