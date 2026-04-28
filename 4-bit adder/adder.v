`timescale 1ns/1ps

module adder_1bit
(
    input  a, b, c,
    output s, cout
);

    assign s    = a ^ b ^ c;
    assign cout = (a & b) | ((a ^ b ) & c);

endmodule

module adder # (parameter N = 4)
(
    input  [N-1:0] a, b, // 2 vetores de 4 bits
    input          cin,  // carry in
    output [N-1:0] s,    // magnitude da soma
    output         cout  // carry out (MSB)
);

    wire [N:0] c;

    assign c[0] = cin;
    assign cout = c[N];

    for (genvar i = 0; i < N; i++) begin
       adder_1bit si (a[i], b[i], c[i], s[i], c[i + 1]); 
    end

endmodule
