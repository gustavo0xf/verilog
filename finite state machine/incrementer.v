module incrementer (
	input clk, rst,
	output reg [9:0] S
);
	// estados
	parameter inicio	  = 0;
	parameter conta_pulso = 1;
	parameter checa200	  = 2;
	// estado atual e contador
	reg [1:0]  estado;
	reg [31:0] counter;
	// parte combinacional
	always @(*) begin
		case(estado)
			inicio: begin
				S <= 0;
			end
			conta_pulso: begin
				S <= S;
			end
			checa200: begin
				S <= S + 1;
			end
		endcase
	end
	// parte sequencial
	always @(posedge clk, negedge rst) begin
		if (~rst) begin
			estado <= inicio;
		end
		else begin
			case (estado)
				inicio: begin
					estado <= conta_pulso;
					counter <= 0;
				end
				conta_pulso: begin
					if (counter < 5) begin
						counter <= counter + 1;
						estado <= conta_pulso;
					end
					else begin
						estado <= checa200;
					end
				end
				checa200: begin
					counter <= 0;
					if (S > 200) begin
						estado <= init;
					end
					else begin
						estado <= conta_pulso;
					end
				end
			endcase
		end
	end
endmodule
