module register #(parameter w = 16)
                (input  logic Clk, Reset, Load, 
                input  logic [ w-1 : 0 ]  Data_In,
                output logic [ w-1 : 0 ]  Data_Out);

	logic [ w-1 : 0 ] Data;

    always_ff @ (posedge Clk)
    begin			
        Data_Out <= Data;
    end

    always_comb 
    begin
        Data = Data_Out;
        if (~Reset)
            Data = 0;
        else if (Load)
            Data = Data_In;
    end


endmodule
