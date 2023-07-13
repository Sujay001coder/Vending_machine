module fsm(clock,reset,coin,vend,state,change);
//these are the inputs and the outputs.
input clock;
input reset;
input [2:0]coin;
output vend;
output [2:0]state;
output [2:0]change;

reg vend;
reg [2:0]change;
wire [2:0]coin;

  parameter [2:0]FIVE_RUPEE=3'b001;
  parameter [2:0]TEN_RUPEE=3'b010;
  parameter [2:0]FIFTEEN_RUPEE=3'b011;
  parameter [2:0]TWENTY_RUPEE=3'b101;
  
  parameter [2:0]IDLE=3'b000;
  parameter [2:0]FIVE=3'b001;
  parameter [2:0]TEN=3'b010;
  parameter [2:0]FIFTEEN=3'b011;
  parameter [2:0]TWENTY=3'b100;
  parameter [2:0]TWENTYFIVE=3'b101;
reg [2:0]state,next_state;
always @(state or coin)
begin
next_state=0; 
case(state)
  IDLE: case(coin) //THIS IS THE IDLE STATE
FIVE_RUPEE: next_state =FIVE;
TEN_RUPEE: next_state =TEN;
TWENTY_RUPEE: next_state =TWENTY;
default: next_state =IDLE;
endcase
  FIVE: case(coin) 
FIVE_RUPEE: next_state =TEN;
TEN_RUPEE: next_state =FIFTEEN;
TWENTY_RUPEE: next_state =TWENTYFIVE; //change=0
default: next_state =FIVE;
endcase
  TEN: case(coin) //THIS IS THE THIRD STATE
FIVE_RUPEE: next_state =FIFTEEN;
TEN_RUPEE: next_state =TWENTY;
TWENTY_RUPEE: next_state =IDLE; //change=0
default: next_state =TEN;
endcase
  FIFTEEN: case(coin) //THIS IS THE FOURTH STATE
FIVE_RUPEE: next_state =TWENTY;
TEN_RUPEE: next_state =TWENTYFIVE;
TWENTY_RUPEE: next_state =IDLE; 
default: next_state =FIFTEEN;
endcase
  TWENTY: case(coin) //THIS IS THE FIFTH STATE
FIVE_RUPEE: next_state =TWENTYFIVE;
TEN_RUPEE: next_state=IDLE; //change=0
TWENTY_RUPEE: next_state =IDLE; 
default: next_state =TWENTY;
endcase
TWENTYFIVE: next_state =IDLE;
default : next_state =IDLE;
endcase
end
  always @(posedge clock)
begin //WHENEVER I GIVE A RESET I HAVE TO MAKE THE STATE TO IDLE AND VEND TO 1
if(reset) begin
state <= IDLE;
vend <= 1'b0;
 change <= 3'b000;
end //THE CNGE ALSO HAS TO BECOME NONE
else state <= next_state;

 case (state) 
IDLE: begin vend <= 1'b0;
  change <=3'd0;
end
   FIVE: begin 
    
     if (coin==TWENTY_RUPEE) begin
        vend <= 1'b0;
       change <=3'd0;
     end
     else begin
        vend <= 1'b0;
       change <=3'd0;
     end
       end
     TEN: begin
        
       if (coin==TWENTY_RUPEE) begin 
     vend <= 1'b1;
    change <=3'd0; 
       end
  else  begin
     vend <= 1'b0;
    change <= 3'd0;
  end
    end
  FIFTEEN : begin
    if (coin==TWENTY_RUPEE) begin
      vend <= 1'b1; 
      change <=FIVE_RUPEE;
  end
    else begin
       vend <= 1'b0; 
      change<=3'd0;
    end
  end
    TWENTY : begin 
       
      if (coin==TEN_RUPEE) begin
        vend <= 1'b1;
        change <=3'd0;
      end
      else if (coin==TWENTY_RUPEE) begin
        vend <= 1'b1;
        change <=TEN_RUPEE;
      end
    end
        TWENTYFIVE : begin
          if(coin==FIVE_RUPEE) begin
          vend <= 1'b1;
          change <=3'd0;
          end
          else if(coin==TEN_RUPEE) begin
            vend <= 1'b1;
          change <=FIVE_RUPEE;
          end
          else begin
            vend <= 1'b1;
          change <=FIFTEEN_RUPEE;
          end
        end
default: state <= IDLE;
endcase
end
endmodule
