// testbench
`timescale 1ns/1ps

module adder_tb;

    reg [3:0] a, b;
    reg       c;

    wire [3:0] s, s_gm;
    wire       cout, cout_gm;

    adder     dut (a, b, c, s,     cout);
    adder_gm  gm  (a, b, c, s_gm, cout_gm);

    initial begin
        a =  0; b = 0; c = 0; # 10;
        a =  3; b = 2; c = 0; # 10;
        a =  9; b = 2; c = 0; # 10;
        a = 10; b = 5; c = 0; # 10;
    end

    initial begin
        $monitor("@time=%d, %d + %d = %d",
        $time, a, b, s);
    end

endmodule
