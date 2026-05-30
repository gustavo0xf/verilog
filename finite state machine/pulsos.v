module pulsos (
	input clk, S,
	output reg P
);
	// estados
	parameter inicio = 0; // 00
	parameter espera = 1; // 01
	parameter soma   = 2; // 10
	// registradores para o contador e para o estado atual
	reg [1:0]  estado;
	reg [32:0] counter;
	// parte combinacional
	always @(*) begin
		case (estado)
			inicio: begin
				P <= P;
			end
			espera: begin
				P <= P;
			end
			soma: begin
				P <= P + 1;
			end
		endcase
	end
	// parte sequencial
	always @(posedge clk) begin
		case (estado) begin
			inicio: begin
				counter <= counter + 1; // ja começa a contar desde o inicio
				if (S == 0) begin
					estado <= inicio;
				end
				else begin
					estado <= espera;
				end
			end
			espera: begin
				if (counter < 12) begin
					estado <= espera;
				end
				else begin
					if (S == 0) begin
						estado <= soma;
					end
					else begin
						counter <= 0;
						estado <= inicio;
					end
				end
			end
			soma: begin
				estado <= inicio;
			end
		end
	end
endmodule
