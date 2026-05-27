// 4 bit adder
module adder(
    input [3:0]      magA, magB,  // magnitudes de A e B
    input            sA, sB,      // sinais de A e B
	output reg       sSum,       // sinal da soma
    output reg [4:0] sum         // magnitude da soma
); 

    reg [5:0] a, b; // registrador para o tratamento de sinal
    // parte combinacional
    always @(*) begin
    	a = sA ? -a : a;
    	b = sB ? -b : b;
        {sSum, sum} = a + b;
    	sum = sSum ? -res : res;
    end

endmodule
