module(
	input clk,     // 32 MHz
	output reg f1, // 16 MHz = 32/2¹ -> 1º bit
	output reg f2, // 4  MHz = 32/2³ -> 3º bit
	output reg f3  // 1  MHz = 32/2⁵	-> 5º bit 
);
	// para construir um divisor de frequencias, tudo que precisamos é de um contador
	reg [4:0] counter = 0;
	// parte combinacional
	always @(*) begin
		f1 <= counter[0];
		f2 <= counter[2];
		f3 <= counter[4];
	end
	// parte sequencial
	always @(posedge clk) begin
		if (counter < 31) begin
			counter <= counter + 1; // inicializa o contador
		end
		else begin
			counter <= 0; // zerar o contador
		end
	end
endmodule
