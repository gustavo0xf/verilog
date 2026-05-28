module(
	input clk, rst, data
	output reg S
);
	// estados
	parameter inicio = 0; // 000
	parameter ler    = 1; // 001
	parameter stop	  = 2; // 010
	parameter tecla1 = 3; // 011
	parameter tecla2 = 4; // 100
	// contador, vetor temporario e estado atual. como sabemos que o contador só vai até 4, podemos usar um integer sem problemas
	integer i = 0;
	reg [2:0] estado;
	reg [3:0] tmp;
	// parte combinacional
	always @(*) begin
		case (estado)
			inicio:begin
				S <= 0;
			end
			ler:begin
				S <= S;
			end
			stop:begin
				S <= S;
			end
			tecla1:begin
				S <= 1;
			end
			tecla2:begin
				S <= 0;
			end
		endcase
	end
	// parte sequencial
	always @(posedge clk, negedge rst) begin
		if (~rst) begin
			estado <= incio;
		end
		else begin
			case (estado)
				inicio:begin
					if (data == 0) begin
						estado <= ler;
					end
					else begin
						estado <= inicio;
					end;
				end
				ler:begin
					if (i < 4) begin
						tmp[i] = data;
						i = i + 1;
						estado <= ler;
					end
					else begin
						i = 0;
						estado <= stop;
					end
				end
				stop:begin
					if (tmp == 4'b0001) begin
						estado <= tecla1;
					end
					else if (tmp == 4'b0010) begin
						estado <= tecla2;
					end
					else begin
						estado <= inicio;
					end
				end
				tecla1:begin
					estado <= inicio;
				end
				tecla2:begin
					estado <= inicio;
				end
			endcase
		end
	end
endmodule
