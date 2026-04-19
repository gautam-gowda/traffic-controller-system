module traffic_controller (
    input clock,
    input reset,
    input emergency_a,
    input emergency_b,

    output reg a_green,
    output reg a_yellow,
    output reg a_red,

    output reg b_green,
    output reg b_yellow,
    output reg b_red
);

//state encoding 
parameter s0=2'b00;
parameter s1=2'b01;
parameter s2=2'b10;
parameter s3=2'b11;

// to store counters and current state 
reg [3:0] counter;
reg[1:0] state;

always @(posedge clock or posedge reset) begin
    if (reset) begin
        state <=0;
        counter <=4'd0;
    end
    else if (emergency_a && emergency_b) begin
        state <= s0;
        counter <= 4'd0;
    end
    else if (emergency_a) begin
        state <= s0;
        counter <=4'd0;
    end
    else if (emergency_b) begin
        state <= s2;
        counter <=4'd0;
    end
    //fsm
    else begin
        counter <= counter + 1'b1;
    end
    case (state)
        s0: begin
            if (counter==10) begin
                state <= s1;
                counter <= 4'd0;
            end
        end 
        s1: begin
            if (counter==4) begin
                state <= s2;
                counter <= 4'd0;
            end
        end
        s2: begin
            if (counter==10) begin
                state<=s3;
                counter <= 4'd0;
            end
        end
        s3:begin
            if (counter==4) begin
                state <= s0;
                counter <= 4'd0;
            end
        end
     
    endcase
end

// output logic
always @(*) begin
    a_green=0;a_red=0;a_yellow=0;
    b_green=0;b_red=0;b_yellow=0;

    case (state)
        s0:begin
            a_green=1;
            b_red=1;
        end 
        s1: begin
            a_yellow=1;
            b_red=1;
        end
        s2: begin
            a_red=1;
            b_green=1;
        end
        s3:begin
            a_red=1;
            b_yellow=1;
        end
    
         
    endcase

end

endmodule
