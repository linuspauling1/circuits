//latches: sr,d
//ffs: d,de,dr,sr,t,jk
`timescale 1ns/1ns

//sr
module sr(
    input clk,set,rst,
    output reg q
);

always @ * begin
    if(clk) begin
        case({set,rst})
            2'b01 : q <= 1'b0;
            2'b10 : q <= 1'b1;
        endcase
    end
end

endmodule
//sr_tb
module sr_tb(
    output reg clk,set,rst,
    output q
);

sr cut(.clk(clk),.set(set),.rst(rst),.q(q));

initial $dumpvars(0,sr_tb);

initial begin
    clk = 1'b0;
    repeat (10)
    #50 clk = ~clk;
end

initial begin
    set = 1'b0;
    #60 set = 1'b1;
    #30 set = 1'b0;
    #50 set = 1'b1;
    #130 set = 1'b0;
    #70 set = 1'b1;
    #70 set = 1'b0;
    #60 set = 1'b1;
end

initial begin
    rst = 1'b1;
    #60 rst = 1'b0;
    #30 rst = 1'b1;
    #50 rst = 1'b0;
    #130 rst = 1'b1;
    #70 rst = 1'b0;
    #70 rst = 1'b1;
    #60 rst = 1'b0;
end

endmodule

//d
module d(
    input clk,d,
    output reg q
);

always @ * begin
    if(clk) q <= d;
end

endmodule
//d_tb
module d_tb(
    output reg clk,d,
    output q
);

d cut(.clk(clk),.d(d),.q(q));

initial $dumpvars(0,d_tb);

initial begin
    clk = 1'b0;
    repeat (10)
    #50 clk = ~clk;
end

initial begin
    d = 1'b0;
    #60 d = 1'b1;
    #30 d = 1'b0;
    #50 d = 1'b1;
    #130 d = 1'b0;
    #70 d = 1'b1;
    #70 d = 1'b0;
    #60 d = 1'b1;
end

endmodule

//ff_d
module ff_d(
    input clk,d,
    output reg q
);

initial q = 1'b0;

always @(posedge clk) q <= d;

endmodule
//ff_d_tb
module ff_d_tb(
    output reg clk,d,
    output q
);

ff_d cut(.clk(clk),.d(d),.q(q));

initial $dumpvars(0,ff_d_tb);

initial begin
    clk = 1'd0;
    repeat (10)
    #50 clk = ~clk;
end

initial begin
    d = 1'd0;
    #60 d = 1'd1;
    #30 d = 1'd0;
    #50 d = 1'd1;
    #70 d = 1'd0;
    #150 d = 1'd1;
    #50 d = 1'd0;
    #50 d = 1'd1;
end

endmodule

//ff_d_en
module ff_d_en(
    input clk,en,d,
    output reg q
);

always @(posedge clk) begin
    if(en) q <= d;
end

endmodule
//ff_d_en_tb
module ff_d_en_tb(
    output reg clk,en,d,
    output q
);

ff_d_en cut(.clk(clk),.en(en),.d(d),.q(q));

initial $dumpvars(0,ff_d_en_tb);

initial begin
    clk = 1'd0;
    repeat (10)
    #50 clk = ~clk;
end

initial begin
    d = 1'd0;
    #60 d = 1'd1;
    #30 d = 1'd0;
    #50 d = 1'd1;
    #70 d = 1'd0;
    #150 d = 1'd1;
    #50 d = 1'd0;
    #30 d = 1'd1;
end

initial begin
    en = 1'd1;
    #350 en = 1'd0;
    #450 en = 1'd1;
end

endmodule

//d_r
module ff_d_r(
    input clk,d,rst,
    output reg q
);

always @(posedge clk or posedge rst) begin
    if(rst) q <= 1'b0;
    else q <= d;
end

endmodule
//d_r_tb
module ff_d_r_tb(
    output reg clk,d,rst,
    output q
);

ff_d_r cut(.clk(clk),.d(d),.rst(rst),.q(q));

initial $dumpvars(0,ff_d_r_tb);

initial begin
    clk = 1'd0;
    repeat (10)
    #50 clk = ~clk;
end

initial begin
    d = 1'd0;
    #60 d = 1'd1;
    #30 d = 1'd0;
    #50 d = 1'd1;
    #70 d = 1'd0;
    #150 d = 1'd1;
    #50 d = 1'd0;
    #50 d = 1'd1;
end

initial begin
    rst = 1'd1;
    #50 rst = 1'd0;
    #180 rst = 1'd1;
    #10 rst = 1'd0;
end

endmodule

//sr
module ff_sr(
    input clk,set,rst,
    output reg q
);

always @(posedge clk) begin
    if(set && !rst) q <= 1'd1;
    else if(!set && rst) q <= 1'd0;
end

endmodule
//sr_tb
module ff_sr_tb(
    output reg clk,set,rst,
    output q
);

ff_sr cut(.clk(clk),.set(set),.rst(rst),.q(q));

initial $dumpvars(0,ff_sr_tb);

initial begin
    clk = 1'd0;
    repeat (10)
    #50 clk = ~clk;
end

initial begin
    set = 1'd0;
    #60 set = 1'd1;
    #30 set = 1'd0;
    #50 set = 1'd1;
    #70 set = 1'd0;
    #150 set = 1'd1;
    #50 set = 1'd0;
    #50 set = 1'd1;
end

initial begin
    rst = 1'd1;
    #60 rst = 1'd0;
    #30 rst = 1'd1;
    #50 rst = 1'd0;
    #70 rst = 1'd1;
    #150 rst = 1'd0;
    #50 rst = 1'd1;
    #50 rst = 1'd0;
end

endmodule

//t
module ff_t(
    input clk,toggle,
    output reg q
);

initial q = 0;

always @(posedge clk) begin
    if(toggle) q <= ~q;
    else q <= q;
end

endmodule
//t_tb
module ff_t_tb(
    output reg clk,toggle,
    output q
);

ff_t cut(.clk(clk),.toggle(toggle),.q(q));

initial $dumpvars(0,ff_t_tb);

initial begin
    clk = 1'd0;
    repeat (10)
    #50 clk = ~clk;
end

initial begin
    toggle = 1'd0;
    #60 toggle = 1'd1;
    #30 toggle = 1'd0;
    #50 toggle = 1'd1;
    #70 toggle = 1'd0;
    #120 toggle = 1'd1;
    #50 toggle = 1'd0;
    #50 toggle = 1'd1;
end

endmodule

//ff_jk
module ff_jk(
    input clk,j,k,
    output reg q
);

always @(posedge clk) begin
    case({k,j})
        2'b00 : q <= q;
        2'b01 : q <= 1'b1;
        2'b10 : q <= 1'b0;
        2'b11 : q <= ~q;
    endcase
end 

endmodule
//ff_jk_tb
module ff_jk_tb(
    output reg clk,j,k,
    output q
);

ff_jk cut(.clk(clk),.j(j),.k(k),.q(q));

initial $dumpvars(0,ff_jk_tb);

initial begin
    clk = 1'd0;
    repeat (10)
    #50 clk = ~clk;
end

initial begin
    j = 1'd0;
    #60 j = 1'd1;
    #30 j = 1'd0;
    #50 j = 1'd1;
    #70 j = 1'd0;
    #150 j = 1'd1;
    #50 j = 1'd0;
    #50 j = 1'd1;
end

initial begin
    k = 1'd1;
    #60 k = 1'd0;
    #30 k = 1'd1;
    #50 k = 1'd0;
    #70 k = 1'd1;
    #150 k = 1'd0;
    #50 k = 1'd1;
    #50 k = 1'd0;
end

endmodule

//sa se proiecteze un bistabil cu validare folosind
//un multiplexor de 2:1 si un bistabil D

//multiplexor 2:1
module mux2_1(
    input sel,
    input [1:0] in,
    output reg o
);

always @ * o = in[sel];

endmodule
//tb multiplexor 2:1
module mux2_1_tb(
    output reg sel,
    output reg [1:0] in,
    output o
);

mux2_1 cut(.sel(sel),.in(in),.o(o));

integer i;

initial $dumpvars(0,mux2_1_tb);

initial begin
    for(i = 0;i < 8;i = i + 1)
       #100 {in,sel} = i; 
end

endmodule

//circuit ce foloseste mux2_1 si ff_d
module d_en(
    input clk,d,en,
    output o
);

wire f,g;

mux2_1 i0(.sel(en),.in({d,f}),.o(g));
ff_d i1(.clk(clk),.d(g),.q(f));

assign o = f;

endmodule
//tb circuit
module d_en_tb(
    output reg clk,d,en,
    output o
);

d_en cut(.clk(clk),.d(d),.en(en),.o(o));

initial $dumpvars(0,d_en_tb);

initial begin
    clk = 1'd0;
    repeat (10)
    #50 clk = ~clk;
end

initial begin
    d = 1'd0;
    #60 d = 1'd1;
    #30 d = 1'd0;
    #50 d = 1'd1;
    #70 d = 1'd0;
    #150 d = 1'd1;
    #50 d = 1'd0;
    #30 d = 1'd1;
end

initial begin
    en = 1'd1;
    #350 en = 1'd0;
    #450 en = 1'd1;
end

endmodule

//implementarea latchurilor rs cu porti
//implementare poarta nor
module sau_nu(input x,y,output reg z); 
always @ * z = ~ (x | y);
endmodule
//immplementare latch
module sr_gates(
    input s,r,
    output reg q,q_bar
);
initial q = 1'd0;
initial q = 1'd1;
wire f,g;
sau_nu i0(.x(r),.y(g),.z(f));
sau_nu i1(.x(s),.y(f),.z(g));
always @ * begin
    q = f;
    q_bar = g;
end
endmodule
//tb pentru latchurile rs cu porti
module sr_gates_tb(
    output reg s,r,
    output q,q_bar
);

sr_gates cut(.s(s),.r(r),.q(q),.q_bar(q_bar));

initial $dumpvars(0,sr_gates_tb);

initial begin
    {s,r} = 2'b01;
    #50 {s,r} = 2'b10;
    #50 {s,r} = 2'b01;
    #50 {s,r} = 2'b00;
    #50 {s,r} = 2'b11;//stare interzisa
end

endmodule


//multiple of 3
module mul_3(
    input clk,in,
    output reg out
);

reg f;
wire g,h;

always @ * begin
    f = in & ~ (g | h);
    out = in | g | h;
end

ff_d i0(.clk(clk),.d(f),.q(g));
ff_d i1(.clk(clk),.d(g),.q(h));

endmodule
//tb mul_3
module mul_3_tb(
    output reg clk,in,
    output out
);

mul_3 cut(.clk(clk),.in(in),.out(out));

initial $dumpvars(0,mul_3_tb);

initial begin
    clk = 1'd1;
    repeat (30)
    #50 clk = ~ clk;
end

initial begin
    in = 1'd0;
    #101 in = 1'd1;
    #101 in = 1'd0;
    #301 in = 1'd1;
    #201 in = 1'd0;
    #301 in = 1'd1;
    #301 in = 1'd0;
end

endmodule