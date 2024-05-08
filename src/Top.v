
`timescale 1ns / 1ps

module Top (output [7:0] response, input en, reset, input [9:0] challenge);
wire [7:0] count1, count2;
top_f2g uut1(count1, en, reset, challenge[4:0]);
top_f2g uut2(count2, en, reset, challenge[9:5]);
comp uut3(count1, count2, response);
endmodule

module f2g (output p, q, r, input a, b, c);
assign p=a;
assign q=a^b;
assign r=a^c;  
endmodule

module osc_f2g (output out, input en);
wire [4:0] p, q, r;
wire A;
f2g g0(p[0], q[0], r[0], A, 1'b1, 1'b1);
f2g g1(p[1], q[1], r[1], r[0], 1'b1, 1'b1);
f2g g2(p[2], q[2], r[2], q[1], 1'b1, 1'b1);
f2g g3(p[3], q[3], r[3], r[2], 1'b1, 1'b1);
f2g g4(p[4], q[4], r[4], q[3], 1'b1, 1'b1);
and a0(out, en, r[4]);
assign A=out;
endmodule

module top_f2g (output [7:0] count, input en, reset, input [4:0] sel);
wire [7:0] i;
wire mux_out;
genvar x;
generate
    for(x=0; x<7; x=x+1)
    begin
        (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *)
        osc_f2g f0(i[x], en);
    end
endgenerate

mux32 uut(i, sel, mux_out);

counter c(mux_out, reset, count);  
endmodule

module mux32(
    input wire[7:1] i,
    input wire[4:0] sel,
    output reg m_out
    );
   
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *)
    always @(*)

    begin
    case(sel)
        5'b00000: m_out=i[1];
        5'b00001: m_out=i[2];
        5'b00010: m_out=i[3];
        5'b00011: m_out=i[4];
        5'b00100: m_out=i[5];
        5'b00101: m_out=i[6];
        5'b00110: m_out=i[7];
        5'b00111: m_out=i[8];
        5'b01000: m_out=i[9];
        5'b01001: m_out=i[10];
        5'b01010: m_out=i[11];
        5'b01011: m_out=i[12];
        5'b01100: m_out=i[13];
        5'b01101: m_out=i[14];
        5'b01110: m_out=i[15];
        5'b01111: m_out=i[16];
        5'b10000: m_out=i[17];
        5'b10001: m_out=i[18];
        5'b10010: m_out=i[19];
        5'b10011: m_out=i[20];
        5'b10100: m_out=i[21];
        5'b10101: m_out=i[22];
        5'b10110: m_out=i[23];
        5'b10111: m_out=i[24];
        5'b11000: m_out=i[25];
        5'b11001: m_out=i[26];
        5'b11010: m_out=i[27];
        5'b11011: m_out=i[28];
        5'b11100: m_out=i[29];
        5'b11101: m_out=i[30];
        5'b11110: m_out=i[31];
        5'b11111: m_out=i[32];
    endcase  
    end
endmodule

module counter(
    input m_out,
    input reset,
    output reg[7:0] count
    );
   
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *)
    initial count=7'h00;
    always @(posedge m_out or posedge reset)
    begin
        if(reset)
            begin
                count = 0;
            end
        else
            begin
                count = count + 1;
            end
    end
endmodule

module comp(
    input [7:0] count1,
    input [7:0] count2,
    output reg[7:0] response
    );
   
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *)
   
    always @(count1 or count2)
        begin
            if(&count1 > &count2)
                begin
                    response <= count1;
                end
            else
                begin
                    response <= count2;
                end
        end
endmodule
