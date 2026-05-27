# study notes on verilog

## basic structure
- for each circuit that we project, we can create a module for them and at the end, assemble all modules
  
  ```verilog
  module mux2for1 (
    input a,b;
    output c;
  );
  ```

## data types
- input: data physical entry
  
  ```verilog
  input a, b, c, d;
  ```
  
- output: data physical exit
  ```verilog
  output e, f, g;
  ```
  
- reg: register or an array of flip flop's
  
  ```verilog
  reg [7:0] vector; // 8 bit vector
  ```
  
- wire: like a bridge for internal communication
  
  ```verilog
  wire [3:0] internal; // 4 bit wire for inmodule communication
  ```
  
- real: like the floats on common programming languages. virtual data type
  
  ```verilog
  real valladolid;
  ```
  
- integer: just like any other common programming languages. virtual data type.
  
  ```verilog
  integer counter;
  Interger array [1:64]; // 64 positions array
  ```
  
## numbers

- we can represent numbers on verilog on many formats, like: binary, octal, decimal (default) and hexadecimal. to write they on verilog, we can follow this simple pattern: `(bits)'(base)(value)`

  ```verilog
  5'd32     // (dec) 32. or just 32.
  6'b110110 // (dec) 54
  3'o101    // (dec) 65
  4'hAF     // (dec) 175
  ```

## parameters

- to make the code more legible, we can define parameters, that are just like aliases, for data types or for any other things that we judge necessary. for example, when we are developing a finite state machine, on each state is a binary number, we can define parameters to them. 

   ```verilog
    // maquina de estados de uma questao de prova.
    parameter inicio = 3'b000;
    parameter ler    = 3'b001;
    parameter stop   = 3'b011;
    parameter T1     = 3'b100;
    parameter T2     = 3'b101;
    ```

## combinational

- now, our circuits are splitted on two parts, combinational, to handle the logical operations/outputs and sequential, to manage the possible states of the circuit. on both of them, we use the `always` directive, that basically defines an event that happens at some circunstance

  ```verilog
  always @(*) begin
    // instructions
  end
  ```

## sequential

- the sequential part, as we know, depends on clock pulses to change between the states. so, we need to pass the clock and reset signals as parameters of our `always`

  ```verilog
  always @(posedge clock, negedge rst) begin
    if (~rst) begin
      // instructions
    end
    else begin
      // instructions
    end
  end
  ```

- the example below uses positive edge triggered clock, but we can have a negative edge triggered clock too.

  ```verilog
  always @(negedge clock, posedge rst) begin
    if (rst) begin
      // instructions
    end
    else begin
      // instructions
    end
  end
  ```

## conditionals

- as the many programming languages, on verilog we have `if` and `case` directives to built conditionals. `case` is indispensable on FSM

  ```verilog
  if (cond1) begin
    // instructions
  end
  else if (cond2) begin
    // instructions
  end
  else if (cond3) begin
    // instructions
  end
  else begin
    // instructions
  end
  ```

  ```verilog
  // questao de prova
  case (estado)
    inicio: begin
      if (data == 0) begin
        estado <= ler; // atribuição não-blocante
      end
    end
    ler: begin
      if (i <= 3) begin
        vet[i] <= data;
        i <= i + 1;
      end
      else begin
        estado <= stop;
        i <= 0;
      end
    end
    stop: begin
      case (vet)
        "1010"  : estado <= tecla2;
        "1001"  : estado <= tecla1;
        default : inicio;
      endcase
    end
    tecla1: begin
      estado <= inicio;
    end
    tecla2: begin
      estado <= inicio;
    end
  endcase
  ```

## examples

- N bits counter

  ```verilog
  module contador_generico #(parameter N = 8)(
      input clk,
      input rst,
      input enable,   
      output reg [N-1:0] S
  );
  
      always @(posedge clk or negedge rst) begin
          if (!reset_n) begin
              q <= {N{1'b0}}; // zera
          end else if (enable) begin
              q <= q + 1'b1;  // incrementa
          end
      end
  
  endmodule
  ```

- FSM scheme

  ```verilog
  module finiteStateMachine (
      input clk,
      input rst,
      output reg [7:0] output
  );
      // based on states quantity, you need to calculate how many bits (n) are needed to express all of them. example: 3 states = 2 bits
      parameter state1 = 2'b00;
      parameter state2 = 2'b01;
      parameter state3 = 2'b10;
      // to manage the states on the sequential always, we need a n bit register too. in this example, we only need a 2 bits register.
      reg [1:0] currentState;
      // combinational part. here, AND ONLY HERE, we can WRITE to the outputs
      always @(*) begin
          case (currentState)
              state1: begin
                  output = 8'd0;
              end
              state2: begin
                  output = output;
              end
              state3: begin
                  output = output + 1'b1;
              end
              default: state1
                  output = 8'd0;
              end
          endcase
      end
      // sequential part. logic of our state machine
      always @(posedge clock or negedge rst) begin
          if (~rst) begin
              currentState <= state1;
          end else begin
              case (currentState)
                  state1: begin
                      // logic
                  end
                  state2: begin
                      // logic
                  end
                  state3: begin
                      // logic
                  end
                  default: state1
                      currentState <= state1;
                  end
              endcase
          end
      end
  
  endmodule
  ```
