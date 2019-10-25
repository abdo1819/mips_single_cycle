module fpregfile(input logic clk,
                input logic fwe, //regwrite
                input logic [4:0] fra1, fra2, fwa3,
                input logic [31:0] fwd3,
                output logic [31:0] frd1, frd2);

logic [31:0] frf[31:0];
// three ported register file
// read two ports combinationally
// write third port on rising edge of clk
// register 0 hardwired to 0
// note: for pipelined processor, write third port
// on falling edge of clk

always_ff @(posedge clk)
    if (fwe) frf[fwa3] <= fwd3;

    assign frd1 = (fra1 != 0) ? frf[fra1] : 0;
    assign frd2 = (fra2 != 0) ? frf[fra2] : 0;

endmodule
