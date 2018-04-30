`ifndef _alu_control
`define _alu_control

module  alu_control(
            input wire [5:0] funct,
            input wire [1:0] aluop,
            output reg [3:0]  aluctl);
            
        reg [3:0] _funct;
        always @(*)begin 
            case(funct[3:0])
                0: _funct=
                    