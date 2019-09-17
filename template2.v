module ff ( input data, input c, input r, output q);
reg q;
always @(posedge c or negedge r) 
begin
 if(r==1'b0)
  q <= 1'b0; 
 else 
  q <= data; 
end 
endmodule //End 


module stateMem(input clk,input res,input A, output p2,p1,p0,c2,c1,c0);
reg [5:0] StateMachine [0:31]; // Exemplo com 4 linhas (2 bits de endereço) e largura 5 bits
initial
begin
StateMachine[0] = 6'h13; // statemachine[linha] = conteúdo da linha
StateMachine[1] = 6'h14;
StateMachine[2] = 6'h30;
StateMachine[3] = 6'h32;

StateMachine[5] = 6'h12;
StateMachine[6] = 6'h29;

StateMachine[8] = 6'h13;
StateMachine[9] = 6'h14;
StateMachine[10] = 6'h28;
StateMachine[11] = 6'h12;

StateMachine[13] = 6'h32;
StateMachine[14] = 6'h19;

StateMachine[16] = 6'h03;
StateMachine[17] = 6'h04;
StateMachine[18] = 6'h00;
StateMachine[19] = 6'h02;

StateMachine[21] = 6'h02;
StateMachine[22] = 6'h01;

StateMachine[24] = 6'h0B;
StateMachine[25] = 6'h14;
StateMachine[26] = 6'h00;
StateMachine[27] = 6'h0A;

StateMachine[29] = 6'h0A;
StateMachine[30] = 6'h01;


end
wire [3:0] address; 
wire [8:0] dout;   
assign dout = StateMachine[address]; // captura a saida da memoria (proximo,saidas)
// saidas nos bits 2, 1, 0 (exemplo)..
assign p2 = dout[5];
assign p1 = dout[4];
assign p0 = dout[3];
assign c2 = dout[2];
assign c1 = dout[1];
assign c0 = dout[0];
// flip flop de estados, Proximo estado nos bits 3 e 4 (exemplo).
ff st0(dout[6],clk,res,address[0]);
ff st1(dout[7],clk,res,address[1]);
ff st2(dout[8],clk,res,address[2]);

assign address[3] = A;

endmodule

module main;
reg c,res;
wire r,g,y;


//statePorta FSM(c,res,saidas....);
stateMem FSM(c,res,saidas....);


initial
    c = 1'b0;
  always
    c= #(1) ~c;

// visualizar formas de onda usar gtkwave out.vcd
initial  begin
     $dumpfile ("out.vcd"); 
     $dumpvars; 
   end 

  initial 
    begin
     $monitor($time," c %b res %b saidas...",c,res,saidas....);
      #1 res=0;
      #1 res=1;
      #12;
      $finish ;
    end
endmodule

