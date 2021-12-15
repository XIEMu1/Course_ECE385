//-------------------------------------------------------------------------
//    Player.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  12-08-2017                               --
//    Spring 2018 Distribution                                           --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  player_1 (  
                input       Clk,                // 50 MHz clock
                            Reset,              // Active-high reset signal
                            frame_clk,          // The clock indicating a new frame (~60Hz)
                input [9:0] DrawX, DrawY,       // Current pixel coordinates
				input [7:0]	keycode,				 // keyboard press
               output logic is_player_1             // Whether current pixel belongs to ball or background
              );
    
    parameter [9:0] Player_X_Center = 10'd320;  // Center position on the X axis
    parameter [9:0] Player_Y_Center = 10'd240;  // Center position on the Y axis
    parameter [9:0] Player_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [9:0] Player_X_Max = 10'd639;     // Rightmost point on the X axis
    parameter [9:0] Player_Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter [9:0] Player_Y_Max = 10'd479;     // Bottommost point on the Y axis
    parameter [9:0] Player_X_Step = 10'd1;      // Step size on the X axis
    parameter [9:0] Player_Y_Step = 10'd1;      // Step size on the Y axis
    parameter [9:0] Player_Size = 10'd4;        // Player size
    parameter [9:0] Player_Vel = 10'd4;
    
    logic [9:0] Player_X_Pos, Player_X_Motion, Player_Y_Pos, Player_Y_Motion;
    logic [9:0] Player_X_Pos_in, Player_X_Motion_in, Player_Y_Pos_in, Player_Y_Motion_in;
    
    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
    // Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            Player_X_Pos <= Player_X_Max / 3;
            Player_Y_Pos <= Player_Y_Center;
            Player_X_Motion <= 10'd000;
            Player_Y_Motion <= Player_Y_Step;
        end
        else
        begin
            Player_X_Pos <= Player_X_Pos_in;
            Player_Y_Pos <= Player_Y_Pos_in;
            Player_X_Motion <= Player_X_Motion_in;
            Player_Y_Motion <= Player_Y_Motion_in;
        end
    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        Player_X_Pos_in = Player_X_Pos;
        Player_Y_Pos_in = Player_Y_Pos;
        Player_X_Motion_in = Player_X_Motion;
        Player_Y_Motion_in = Player_Y_Motion;
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
		  
				case(keycode)
					// key A, clear y directional motion and moving left
					8'h04: begin
								Player_X_Motion_in = Player_X_Motion + (~(Player_Vel) + 1'b1);
								Player_Y_Motion_in = Player_Y_Motion;
							end
							
					// key D, clear y directional motion and moving left
					8'h07: begin
								Player_X_Motion_in = Player_X_Motion + Player_Vel;
								Player_Y_Motion_in = Player_Y_Motion;
							end
					
					// key W, clear x directional motion and moving up
					8'h1a: begin
								Player_X_Motion_in = Player_X_Motion;
								Player_Y_Motion_in = Player_Y_Motion + (~(Player_Vel) + 1'b1) * 5;
							end
					
					// // key S, clear x directional motion and moving down
					// 8'h16: begin
					// 			Player_X_Motion_in = 10'h000;
					// 			Player_Y_Motion_in = Player_Y_Step;
					// 		end
							
					// default does nothing
					default:
						begin
						end
				endcase

            // Friction Effect at X direction
            if (Player_X_Motion != 10'b000) begin
                if (Player_X_Motion <= Player_Vel) begin
                    Player_X_Motion_in = Player_X_Motion + (~(Player_X_Step) + 1'b1);
                end
                if (Player_X_Motion > Player_Vel) begin
                    Player_X_Motion_in = Player_X_Motion + Player_X_Step;
                end
            end	

            // Be careful when using comparators with "logic" datatype because compiler treats 
            //   both sides of the operator as UNSIGNED numbers.
            // e.g. Player_Y_Pos - Player_Size <= Player_Y_Min 
            // If Player_Y_Pos is 0, then Player_Y_Pos - Player_Size will not be -4, but rather a large positive number.
            
            // Player is at the top edge, BOUNCE!
            if ( Player_Y_Pos <= Player_Y_Min + Player_Size ) begin 
                Player_Y_Motion_in = Player_Y_Step;
                Player_Y_Pos_in = Player_Y_Pos + Player_Y_Motion_in;
            end
            // Player is at the middle, ACCELERATE
            else if ( Player_Y_Pos + Player_Size + Player_Size<= Player_Y_Max ) begin
                Player_Y_Motion_in = Player_Y_Step + Player_Y_Motion;
                Player_Y_Pos_in = Player_Y_Pos + Player_Y_Motion_in;
            end
            // Player is at the bottom edge, STOP and TELEPORT
            else if( Player_Y_Pos + Player_Size >= Player_Y_Max ) begin  
                if ( Player_Y_Motion != 10'd000 ) begin
                    Player_Y_Motion_in = 10'd000;  //(~(Player_Y_Step) + 1'b1);  // 2's complement.  
                end
                Player_Y_Pos_in = Player_Y_Max - Player_Size - 10'd002;
            end
            else Player_Y_Pos_in = Player_Y_Pos + Player_Y_Motion_in;
            
					 
            // Player is at the right edge, BOUNCE!
            if( Player_X_Pos + Player_Size >= Player_X_Max ) begin 
                Player_X_Motion_in = (~(Player_X_Step) + 1'b1);  // 2's complement.  
            end
            // Player is at the left edge, BOUNCE!
            else if ( Player_X_Pos <= Player_X_Min + Player_Size ) begin 
                Player_X_Motion_in = Player_X_Step;
            end
					 
            // Update the ball's position with its motion
            Player_X_Pos_in = Player_X_Pos + Player_X_Motion_in;
            
        end
        
        /**************************************************************************************
            ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
            Hidden Question #2/2:
               Notice that Player_Y_Pos is updated using Player_Y_Motion. 
              Will the new value of Player_Y_Motion be used when Player_Y_Pos is updated, or the old? 
              What is the difference between writing
                "Player_Y_Pos_in = Player_Y_Pos + Player_Y_Motion;" and 
                "Player_Y_Pos_in = Player_Y_Pos + Player_Y_Motion_in;"?
              How will this impact behavior of the ball during a bounce, and how might that interact with a response to a keypress?
              Give an answer in your Post-Lab.
        **************************************************************************************/
    end
    
    // Compute whether the pixel corresponds to ball or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX, DistY, Size;
    assign DistX = DrawX - Player_X_Pos;
    assign DistY = DrawY - Player_Y_Pos;
    assign Size = Player_Size;
    always_comb begin
        if ( ( DistX*DistX + DistY*DistY) <= (Size*Size) ) 
            is_player_1 = 1'b1;
        else
            is_player_1 = 1'b0;
        /* The ball's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end
    
endmodule


module  player_2 ( 
                input       Clk,                // 50 MHz clock
                            Reset,              // Active-high reset signal
                            frame_clk,          // The clock indicating a new frame (~60Hz)
                input [9:0] DrawX, DrawY,       // Current pixel coordinates
				input [7:0]	keycode,				 // keyboard press
               output logic is_player_2             // Whether current pixel belongs to ball or background
              );
    
    parameter [9:0] Player_X_Center = 10'd320;  // Center position on the X axis
    parameter [9:0] Player_Y_Center = 10'd240;  // Center position on the Y axis
    parameter [9:0] Player_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [9:0] Player_X_Max = 10'd639;     // Rightmost point on the X axis
    parameter [9:0] Player_Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter [9:0] Player_Y_Max = 10'd479;     // Bottommost point on the Y axis
    parameter [9:0] Player_X_Step = 10'd1;      // Step size on the X axis
    parameter [9:0] Player_Y_Step = 10'd1;      // Step size on the Y axis
    parameter [9:0] Player_Size = 10'd4;        // Player size
    parameter [9:0] Player_Vel = 10'd4;
    
    logic [9:0] Player_X_Pos, Player_X_Motion, Player_Y_Pos, Player_Y_Motion;
    logic [9:0] Player_X_Pos_in, Player_X_Motion_in, Player_Y_Pos_in, Player_Y_Motion_in;
    
    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
    // Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            Player_X_Pos <= Player_X_Max * 2 / 3;
            Player_Y_Pos <= Player_Y_Center;
            Player_X_Motion <= 10'd000;
            Player_Y_Motion <= Player_Y_Step;
        end
        else
        begin
            Player_X_Pos <= Player_X_Pos_in;
            Player_Y_Pos <= Player_Y_Pos_in;
            Player_X_Motion <= Player_X_Motion_in;
            Player_Y_Motion <= Player_Y_Motion_in;
        end
    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        Player_X_Pos_in = Player_X_Pos;
        Player_Y_Pos_in = Player_Y_Pos;
        Player_X_Motion_in = Player_X_Motion;
        Player_Y_Motion_in = Player_Y_Motion;
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
		  
				case(keycode)
					// key A, clear y directional motion and moving left
					8'h50: begin
								Player_X_Motion_in = Player_X_Motion + (~(Player_Vel) + 1'b1);
								Player_Y_Motion_in = Player_Y_Motion;
							end
							
					// key D, clear y directional motion and moving left
					8'h4f: begin
								Player_X_Motion_in = Player_X_Motion + Player_Vel;
								Player_Y_Motion_in = Player_Y_Motion;
							end
					
					// key W, clear x directional motion and moving up
					8'h52: begin
								Player_X_Motion_in = Player_X_Motion;
								Player_Y_Motion_in = Player_Y_Motion + (~(Player_Vel) + 1'b1) * 5;
							end
					
					// // key S, clear x directional motion and moving down
					// 8'h16: begin
					// 			Player_X_Motion_in = 10'h000;
					// 			Player_Y_Motion_in = Player_Y_Step;
					// 		end
							
					// default does nothing
					default:
						begin
						end
				endcase

            // Friction Effect at X direction
            if (Player_X_Motion != 10'b000) begin
                if (Player_X_Motion <= Player_Vel) begin
                    Player_X_Motion_in = Player_X_Motion + (~(Player_X_Step) + 1'b1);
                end
                if (Player_X_Motion > Player_Vel) begin
                    Player_X_Motion_in = Player_X_Motion + Player_X_Step;
                end
            end	

            // Be careful when using comparators with "logic" datatype because compiler treats 
            //   both sides of the operator as UNSIGNED numbers.
            // e.g. Player_Y_Pos - Player_Size <= Player_Y_Min 
            // If Player_Y_Pos is 0, then Player_Y_Pos - Player_Size will not be -4, but rather a large positive number.
            
            // Player is at the top edge, BOUNCE!
            if ( Player_Y_Pos <= Player_Y_Min + Player_Size ) begin 
                Player_Y_Motion_in = Player_Y_Step;
                Player_Y_Pos_in = Player_Y_Pos + Player_Y_Motion_in;
            end
            // Player is at the middle, ACCELERATE
            else if ( Player_Y_Pos + Player_Size + Player_Size<= Player_Y_Max ) begin
                Player_Y_Motion_in = Player_Y_Step + Player_Y_Motion;
                Player_Y_Pos_in = Player_Y_Pos + Player_Y_Motion_in;
            end
            // Player is at the bottom edge, STOP and TELEPORT
            else if( Player_Y_Pos + Player_Size >= Player_Y_Max ) begin  
                if ( Player_Y_Motion != 10'd000 ) begin
                    Player_Y_Motion_in = 10'd000;  //(~(Player_Y_Step) + 1'b1);  // 2's complement.  
                end
                Player_Y_Pos_in = Player_Y_Max - Player_Size - 10'd002;
            end
            else Player_Y_Pos_in = Player_Y_Pos + Player_Y_Motion_in;
            
					 
            // Player is at the right edge, BOUNCE!
            if( Player_X_Pos + Player_Size >= Player_X_Max ) begin 
                Player_X_Motion_in = (~(Player_X_Step) + 1'b1);  // 2's complement.  
            end
            // Player is at the left edge, BOUNCE!
            else if ( Player_X_Pos <= Player_X_Min + Player_Size ) begin 
                Player_X_Motion_in = Player_X_Step;
            end
					 
            // Update the ball's position with its motion
            Player_X_Pos_in = Player_X_Pos + Player_X_Motion_in;
            
        end
        
        /**************************************************************************************
            ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
            Hidden Question #2/2:
               Notice that Player_Y_Pos is updated using Player_Y_Motion. 
              Will the new value of Player_Y_Motion be used when Player_Y_Pos is updated, or the old? 
              What is the difference between writing
                "Player_Y_Pos_in = Player_Y_Pos + Player_Y_Motion;" and 
                "Player_Y_Pos_in = Player_Y_Pos + Player_Y_Motion_in;"?
              How will this impact behavior of the ball during a bounce, and how might that interact with a response to a keypress?
              Give an answer in your Post-Lab.
        **************************************************************************************/
    end
    
    // Compute whether the pixel corresponds to ball or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX, DistY, Size;
    assign DistX = DrawX - Player_X_Pos;
    assign DistY = DrawY - Player_Y_Pos;
    assign Size = Player_Size;
    always_comb begin
        if ( ( DistX*DistX + DistY*DistY) <= (Size*Size) ) 
            is_player_2 = 1'b1;
        else
            is_player_2 = 1'b0;
        /* The ball's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end
    
endmodule
