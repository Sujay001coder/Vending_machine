module top_module;
  //inputs
  reg clk;
    reg[2:0] in;
  reg rst;
  
  //output
  wire out;
    wire[2:0] change;
  
vending_machine t(
.clk(clk),
.rst(rst),
.in(in),
.out(out),
.change(change)
);
initial begin
//initialise inputs
    $monitor("On input=%0d,Vend=%0d,Change=%0d at time t=%0t",in,out,change,$time);
    //$strobe ("On input=%0d,Vend=%0d,Change=%0d at time t=%0t",in,out,change,$time);
    clk = 0;
#5 rst = 1;

#10 rst=0;
    in=4;
    #10 in=4;
    //#10 in=2;
   $finish;
end
always #5 clk = ~clk;
endmodule
