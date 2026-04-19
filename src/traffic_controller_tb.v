`timescale 1ns/1ps
module traffic_controller_tb;
reg clock,reset,emergency_a,emergency_b;
wire a_green,a_red,a_yellow,b_green,b_red,b_yellow;

traffic_controller DUT(
    .clock(clock),
    .reset(reset),
    .emergency_a(emergency_a),
    .emergency_b(emergency_b),
    .a_green(a_green),
    .a_yellow(a_yellow),
    .a_red(a_red),
    .b_red(b_red),
    .b_green(b_green),
    .b_yellow(b_yellow)
);

always #5 clock = ~clock;

initial begin
    $dumpfile("traffic_controller.vcd");
    $dumpvars(0,traffic_controller_tb);

    //system initialize 
    clock=0;
    reset=1;
    emergency_a=0;
    emergency_b=0;

    #12 reset = 0;

    #50;

    //test cases
    emergency_a=1;#10;
    emergency_b=0; #10;

    emergency_a=0;#10;
    emergency_b=1;#10;

    emergency_a=1;#10;
    emergency_b=1;#10 ; 

$finish;

end
endmodule