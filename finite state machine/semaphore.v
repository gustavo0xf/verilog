module semaforo(
	input clk, rst,
	output reg red, yellow, green
);
	// states
	parameter stop    = 0;
	parameter caution = 1;
	parameter go      = 2;
	// current state and counter
	reg [1:0]  state;
	reg [31:0] counter = 0;
	// combinational part
	always @(*) begin
		case (estado)
			stop: begin
				red    <= 1;
				yellow <= 0;
				green  <= 0;
			end
			caution: begin
				red    <= 0;
				yellow <= 1;
				green  <= 0;
			end
			go: begin
				red    <= 0;
				yellow <= 0;
				green  <= 1;
			end
		endcase
	end
	// sequential part
	always @(posedge clk, negedge rst) begin
		if (~rst) begin
			state <= stop;
		end
		else begin
			case (state)
				stop: begin
					if (counter < 10) begin
						counter <= counter + 1;
					end
					else begin
						counter <= 0;
						state   <= caution;
					end
				end
				caution: begin
					if (counter < 5) begin
						counter <= counter + 1;
					end
					else begin
						counter <= 0;
						state   <= go;
					end
				end
				go: begin
					if (counter < 20) begin
						counter <= counter + 1;
					end
					else begin
						counter <= 0;
						state   <= stop;
					end
				end
			endcase
		end
	end
endmodule
