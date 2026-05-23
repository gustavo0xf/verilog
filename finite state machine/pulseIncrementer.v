module pulseIncrementer (
    output reg [7:0] S,
    input clock,
    input rst
);
    // estados
    parameter init         = 2'b00;
    parameter pulseCounter = 2'b01;
    parameter sumS         = 2'b10;
    /* registradores para gerenciar o estado atual e contador
    / 3 estados (00, 01 e 11) = 2 bits */
    reg [1:0] estado_atual;
    reg [2:0] i;
    // parte combinacional
    always @(*) begin
        case (estado_atual)
            init: begin
                S = 8'd0;
            end
            pulseCounter: begin
                S = S;
            end
            sumS: begin
                S = S + 1'b1;
            end
            default: begin
                S = 8'd0;
            end
        endcase
    end
    // parte sequencial
    always @(posedge clock or negedge rst) begin
        if (~rst) begin
            estado_atual <= init;
            i            <= 3'd0;
        end else begin
            case (estado_atual)
                init: begin
                    i            <= 3'd0;
                    estado_atual <= pulseCounter; // Avança após o pulso do RST (0 -> 1 -> 0)
                end
                pulseCounter: begin
                    if (i < 3'd5) begin
                        i            <= i + 1'b1;
                        estado_atual <= pulseCounter;
                    end else 
                      begin
                        estado_atual <= sumS;
                      end
                end
                sumS: begin
                    i <= 3'd0;
                    if (S >= 8'd200) begin
                        estado_atual <= init;
                    end else 
                      begin
                        estado_atual <= pulseCounter;
                    end
                end

                default: begin
                    estado_atual <= init;
                end
            endcase
        end
    end

endmodule
