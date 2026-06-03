// 16 registradores de 16 bits cada
module ram16x16 (
	input data [15:0],  // dados
	input addr [3:0],   // endereço de destino
	input we, clk,      // write enable e clock
	output reg [15:0] q // saída
);
	// matriz da memoria
	reg [15:0] ram [15:0];
	// vetor para os endereços
	reg [3:0] addr_reg;
	// a cada ciclo de clock, rw na memoria
	always @(posedge clk) begin
		// w
		if (we) begin
			ram[addr_reg] <= data;
		end
		// r
		addr_reg <= addr;
	end
	// obter os dados da memoria
	assign q = ram[addr_reg];
endmodule
