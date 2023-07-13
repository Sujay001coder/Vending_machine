module test;
reg clock,reset;
reg [2:0]coin;
wire vend;
wire [2:0]state;
wire [2:0]change;

//THE PARAMETERS FOR THE COIN AND STATE
  parameter [2:0]IDLE=3'b000;
  parameter [2:0]FIVE=3'b001;
  parameter [2:0]TEN=3'b010;
  parameter [2:0]FIFTEEN=3'b011;
  parameter [2:0]TWENTY=3'b100;
  parameter [2:0]TWENTYFIVE=3'b101;
  parameter [2:0]FIVE_RUPEE=3'b001;
  parameter [2:0]TEN_RUPEE=3'b010;
  parameter [2:0]FIFTEEN_RUPEE=3'b011;
  parameter [2:0]TWENTY_RUPEE=3'b101;
 
initial begin
$display("Time\tcoin\tdrink\treset\tclock\tstate\tchange");
$monitor("%g\t%b\t%b\t%b\t%b\t%d\t%d",$time,coin,vend,reset,clock,state,change);
$dumpvars;
$dumpfile("file.vcd"); // Dump output file.
clock=0;

  #2 coin=TWENTY_RUPEE;
  #2 coin=FIVE_RUPEE;
  #2 coin=TWENTY_RUPEE;
  #2 reset=1;
#10 $finish;
end
always
#1 clock=~clock;
initial begin
if (reset)
coin=2'b00;
end
fsm inst1(clock,reset,coin,vend,state,change);
endmodule
