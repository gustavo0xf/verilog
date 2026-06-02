module debounce (
	input clk, rst, A,
	output reg S
);
	// estados
	parameter inicio       = 0; // 00
	parameter debounce     = 1; // 01
	parameter inverteLed   = 2; // 10
	parameter esperaSoltar = 3; // 11
	// estado atual e contador
	reg [1:0] estado;
	reg [32:0] counter = 0;
	// parte combinacional
	always @(*) begin
		case (estado)
			inicio: begin
				S <= S;
			end
			debounce: begin
				S <= S;
			end
			inverteLed: begin
				S <= ~S;
			end
			esperaSoltar: begin
				S <= S;
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
					if (A == 1) begin
						estado <= debounce;
					end
				end
				debounce: begin
					if (counter < 1600000 - 1) begin
						counter <= counter + 1;
					end
					else begin
						estado <= inverteLed;
					end
				end
				inverteLed: begin
					counter <= 0;
					estado <= esperaSoltar;
				end
				esperaSoltar: begin
					if (A == 0) begin
						estado <= inicio;
					end
				end
			endcase
		end
	end
