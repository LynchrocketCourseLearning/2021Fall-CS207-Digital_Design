# DIGITAL DESIGN ASSIGNMENT REPORT

<img src="./pic/LOGO.png" alt="LOGO" width=30% />

**Assignment ID: ** 4

**Student Name:** 刘乐奇

**Student ID:** 12011327



## PART 1: DIGITAL DESIGN THEORY 

1. The characteristic table of JK flip-flop is as below:

| $J$  | $K$  | $Q_t$ | $Q_{t+1}$ |
| :--: | :--: | :---: | :-------: |
|  0   |  0   |   0   |     0     |
|  0   |  0   |   1   |     1     |
|  0   |  1   |   0   |     0     |
|  0   |  1   |   1   |     0     |
|  1   |  0   |   0   |     1     |
|  1   |  0   |   1   |     1     |
|  1   |  1   |   0   |     1     |
|  1   |  1   |   1   |     0     |

The characteristic equation of JK flip-flop is as below:
$$
Q_{t+1} = JQ_t'+K'Q_t
$$
The characteristic table of T flip-flop is as below:

| $T$  | $Q_t$ | $Q_{t+1}$ |
| :--: | :---: | :-------: |
|  0   |   0   |     0     |
|  0   |   1   |     1     |
|  1   |   0   |     1     |
|  1   |   1   |     0     |

The characteristic equation of T flip-flop is as below:
$$
Q_{t+1} = T \oplus Q_t
$$

2. We can derive the state table from the input equations, where

$$
A_{t+1}=J_AA'+K_A'A=x'A'+AB' \\
B_{t+1}=J_BB'+K_B'B=xB'+AB
$$

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\4\pic\2_st.png" alt="2_st" style="zoom:50%;" />

​	The state diagram is as below.

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\4\pic\2_sd.png" alt="2_sd" style="zoom: 50%;" />

3. We can derive the state table as below. Here we need to use 3-bit to present.

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\4\pic\3_st.png" alt="3_st" style="zoom:50%;" />

We have the Karnaugh map and the input equations of each T flip-flop.

$T_C = AC+A'C'=(A \oplus C)'$

| C(col)\BA(row) |  00  |  01  |  11  |  10  |
| :------------: | :--: | :--: | :--: | :--: |
|       0        |  1   |      |      |  x   |
|       1        |      |  x   |  1   |      |

$T_B= B'C+BC'=B \oplus C$

| C(col)\BA(row) |  00  |  01  |  11  |  10  |
| :------------: | :--: | :--: | :--: | :--: |
|       0        |      |      |  1   |  x   |
|       1        |  1   |  x   |      |      |

$T_A= A'B+AB'=A \oplus B$

| C(col)\BA(row) |  00  |  01  |  11  |  10  |
| :------------: | :--: | :--: | :--: | :--: |
|       0        |      |  1   |      |  x   |
|       1        |      |  x   |      |  1   |

​	Then  the circuit diagram and state diagram are as below.

<div align = center>
<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\4\pic\3_cd.png" alt="3_cd" style="zoom:33%;" />
<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\4\pic\3_sd.png" alt="3_sd" style="zoom:33%;" />
</div>

​	It is clear that if we into the state `010` or `101` by mistake, we would never get out of them, vice versa.

​	To correct it, we can combine the valid circulation and the invalid circulation by reset $T_C$ as $T_C = A'C+AC'=A \oplus C$. Then we have the new circuit diagram and state diagram as below.

<div align = center>
<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\4\pic\3_cd2.png" alt="3_cd" style="zoom:33%;" />
<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\4\pic\3_sd2.png" alt="3_sd" style="zoom:33%;" />
</div>

4. From the graph, we have the boolean equations

$$
S=Q'x'y+Q'xy'+Qx'y'+Qxy=x \oplus y \oplus Q \\
C=xy+xQ+yQ \\
D=C=xy+xQ+yQ \\
Q(t+1)=D=xy+xQ+yQ
$$

​	From the boolean equation, we can derive the state table and state diagram as below

<div align = center>
<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\4\pic\4_st.png" alt="4_st" style="zoom:40%;" />
<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\4\pic\4_sd.png" alt="4_sd" style="zoom:30%;" />
</div>


5. 

​	We can derive the state diagram and state table as below.

<div align = center>
    <img src="D:\Lynchrocket\大二上\数字逻辑\assignment\4\pic\5_sd.png" alt="5_sd" style="zoom: 33%;" />
    <img src="D:\Lynchrocket\大二上\数字逻辑\assignment\4\pic\5_st.png" alt="5_st" style="zoom:50%;" />
</div>

​	And then, we have the input equation and output equation.
$$
input \ \ equation: D = Q(t) + x \\
output \ \ equation: F = Q(t) \oplus x
$$

​	The circuit diagram is as below.

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\4\pic\5_cd.png" alt="5_cd" style="zoom:50%;" />






## PART 2: DIGITAL DESIGN LAB (TASK 1)

### DESIGN

**(This part is always REQUIRED)**

*Describe the design of your system by providing the following information:*

- *Verilog design (provide the Verilog code)*. 

i. Implement the JK flip-flop (sensitive to positive edge of clock. an asynchronous reset signal which is low level active).

```verilog
`timescale 1ns / 1ps

module JKFF(
    input J, K, clk, rst,
    output reg Q,
    output Q_n
    );
    assign Q_n = ~Q;
    always @ (posedge clk, negedge rst)
        if(!rst) Q <= 1'b0;
        else case({J, K})
                2'b00: Q <= Q;
                2'b01: Q <= 1'b0;
                2'b10: Q <= 1'b1;
                2'b11: Q <= ~Q;
             endcase
endmodule
```

ii. Implement the sequential circuit in Task1 by using the JK flip-flop which is asked at the step1.

```verilog
`timescale 1ns / 1ps

module t1(
    input x, clk, rst,
    output A, B
    );
    reg clk_t, At, Bt;
    JKFF jka(.J(~x), .K(Bt), .Q(A),.clk(clk_t),.rst(rst));
    JKFF jkb(.J(x), .K(~At), .Q(B),.clk(clk_t),.rst(rst));
    always @(posedge clk) begin
        if(A==1)At=1;
        else At=0;
        if(B==1)Bt=1;
        else Bt=0;
        clk_t = 1;
    end
    always @(negedge clk)begin
        clk_t = 0;
    end
endmodule
```

- *Other design content, depending on the task requirement, to list a few:*

  - *State table*

  <img src="D:\Lynchrocket\大二上\数字逻辑\assignment\4\pic\2_st.png" alt="2_st" style="zoom:50%;" />

  - *Boolean expression*

  $$
  A_{t+1}=J_AA'+K_A'A=x'A'+AB' \\
  B_{t+1}=J_BB'+K_B'B=xB'+AB
  $$

  - *State diagram*

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\4\pic\2_sd.png" alt="2_sd" style="zoom: 50%;" />

### SIMULATION

**(This part is optional depending on the requirement of the lab task)**

*Describe how you build the test bench and do the simulation.* 

- *Using Verilog (provide the Verilog code)*

i. Verify the function of JK flip-flop.

```verilog
`timescale 1ns / 1ps

module JKFF_sim();
    reg j, k, clk, rst;
    wire q;
    
    JKFF jk(.rst(rst),.J(j), .K(k), .clk(clk),.Q(q));
    initial begin
        {j, k} = 2'b00;
        clk = 1'b0;
        rst = 1'b0;
        #10 clk = ~clk;
        rst = 1'b1;
        repeat(7) begin
            #10 clk = 1'b0;
            #10 {j, k} = {j, k} + 2'b01;
            #10 clk = 1'b1;
        end
        #10 $finish;
    end 
endmodule
```

ii. Verify the function of the sequential circuit in Task1-step2.

```verilog
`timescale 1ns / 1ps

module t1_sim();
    reg x, clk, rst;
    wire a, b;
    t1 t(.x(x),.A(a),.B(b),.clk(clk));
    initial begin
        x = 1'b0;
        clk = 1'b0;
        rst = 1'b0;
        #10 rst = 1'b1;
        repeat(15) begin
            #10 clk = 1'b1;
            #10 x = ~x;
            #10 clk = 1'b0;
        end
        #10 $finish;
    end
endmodule
```

- *The waveform of simulation result (provide screenshots)*

i. Verify the function of JK flip-flop.

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\4\pic\t1_jk_sim.png" alt="t1_jk_sim" style="zoom:50%;" />

ii. Verify the function of the sequential circuit in Task1-step2.

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\4\pic\t1_sim.png" alt="t1_sim" style="zoom:50%;" />

- *The description on whether the simulation result is the same as the truth-table, and whether the function of the design meets the expectation.*

​	The detail description is in the graph. The result meets the expectation.

### THE DESCRIPTION OF OPERATION

**(This part is always REQUIRED unless you can get full marks for this lab task)**

*Describe the problems that occurred while in the lab and your solution. Any suggestions are welcomed.*

- *Problems and solutions*

## PART 2: DIGITAL DESIGN LAB (TASK 2)

### DESIGN

**(This part is always REQUIRED)**

*Describe the design of your system by providing the following information:*

- *Verilog design (provide the Verilog code)*. 

i. Implement 74195.

```verilog
`timescale 1ns / 1ps

module sr_74195 (
    input MR_n, CP, PE_n, J, K_n,
    input [3:0] D,
    output reg [3:0] Q,
    output Q_n
    );
    wire K;
    assign K = ~K_n;
    assign Q_n = ~Q[0];
    always @(posedge CP, negedge MR_n) begin
        if(!MR_n) Q <= 4'b0000;
        else begin
            if(!PE_n) Q <= D;
            else case ({J, K})
                    2'b00: {Q[3],Q[2],Q[1],Q[0]} <= {Q[2],Q[1],Q[0],Q[0]};
                    2'b01: {Q[3],Q[2],Q[1],Q[0]} <= {Q[2],Q[1],Q[0],1'b0};
                    2'b10: {Q[3],Q[2],Q[1],Q[0]} <= {Q[2],Q[1],Q[0],1'b1};
                    2'b11: {Q[3],Q[2],Q[1],Q[0]} <= {Q[2],Q[1],Q[0],~Q[0]};
            endcase
        end
    end
endmodule
```

ii. Implement a 4-bits JOHNSON-COUNTER by using one chip of 74195 

```verilog
`timescale 1ns / 1ps

module jc (
    input clk,
    input rst_n,
    output [3:0] out
    );
    reg J, K_n;
    sr_74195 sr(.MR_n(rst_n),.PE_n(1'b1),.CP(clk),.J(J),.K_n(K_n),.D(4'b0000),.Q(out));
    always @ (posedge clk, negedge rst_n) begin
        if(rst_n) begin
            if(out[3]) {J,K_n} <= 2'b00;
            else {J,K_n} <= 2'b11;
        end
    end
endmodule
```

- *Other design content, depending on the task requirement, to list a few:*

  - *State table*

  <img src="D:\Lynchrocket\大二上\数字逻辑\assignment\4\pic\t2_st.png" alt="t2_st" style="zoom:50%;" />

### SIMULATION

**(This part is optional depending on the requirement of the lab task)**

*Describe how you build the test bench and do the simulation.* 

- *Using Verilog (provide the Verilog code)*

i. Verify the function of 74195

```verilog
`timescale 1ns / 1ps

module sr_74195_sim();
    reg MR_n, CP, PE_n, J, K_n;
    wire [3:0] Q;
    wire Q_n;
    
    sr_74195 sr(.MR_n(MR_n),.CP(CP),.PE_n(PE_n),.J(J),.K_n(K_n),.Q(Q),.Q_n(Q_n));
    initial begin
        CP = 1'b0;
        MR_n = 1'b0;
        #10 CP = ~CP;
        MR_n = 1'b1;
        PE_n = 1'b1;
        {J, K_n} = 2'b00;
        repeat(9) begin
            #10 CP = ~CP;
            {J, K_n} = {J, K_n} + 2'b01;
        end
        #10 $finish;
    end
endmodule
```

ii. Verify the function of the sequential circuit in Task2-step

```verilog
`timescale 1ns / 1ps

module jc_sim();
    reg clk;
    reg rst_n;
    wire [3:0] out;

    jc u(.clk(clk),.rst_n(rst_n),.out(out));

    initial begin
        clk = 1'b0;
        rst_n = 1'b0;
        #10 rst_n = ~rst_n;   
        repeat(20) begin
            #10 clk = ~clk;
        end
        #10 $finish;
    end
endmodule
```

- *The waveform of simulation result (provide screenshots)*

i. Verify the function of 74195

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\4\pic\t2_74195_sim.png" alt="t2_74195_sim" style="zoom:50%;" />

ii. Verify the function of the sequential circuit in Task2-step

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\4\pic\t2_jc_sim.png" alt="t2_jc_sim" style="zoom:50%;" />

- *The description on whether the simulation result is the same as the truth-table, and whether the function of the design meets the expectation.*

​	For `74195`, when `MR_n` is in low level active and `CP` in posedge, the output `Q` will be initialized as `4'b0000`, which can be seen in the first interval of the waveform of `74195`. After that, I set `MR_n` and `PE_n` as `1'b1`, making it get into state changing. As `J` and `K_n` change with time, the output `Q` will also change. The result of the simulation of `74195` well matches the expectation.

​	For `Johnson counter`, when `rst_n` is in low level active, the output `Q` will be initialized as `4'b0000`. After that, as `clk` changes with time, the output `Q` will also change in the pre-defined state. The result of the simulation of `Johnson counter` well matches the expectation.

### THE DESCRIPTION OF OPERATION

**(This part is always REQUIRED unless you can get full marks for this lab task)**

*Describe the problems that occurred while in the lab and your solution. Any suggestions are welcomed.*

- *Problems and solutions*

​	The construction of `74195` is hard to comprehend.

## PART 2: DIGITAL DESIGN LAB (TASK 3)

### DESIGN

**(This part is always REQUIRED)**

*Describe the design of your system by providing the following information:*

- *Verilog design (provide the Verilog code)*. 

top.v

```verilog
`timescale 1ns / 1ps
module top ( 
    input clk, rst, sw,
    output[7:0] tube_en,
    output[7:0] tube_out
);
    wire clk_delayed;
    // divide frequency
    fre_div #(500) div(clk, rst, clk_delayed);
    //scan
    show s(.clk_delayed(clk_delayed),.rst(rst),.sw(sw),.tube_en(tube_en),.tube_out(tube_out));
endmodule
```

fre_div.v

```verilog
`timescale 1ns / 1ps
module fre_div #(parameter frequency = 500)(
    input clk,
    input rst,
    output reg clk_delayed
);
    reg[31:0] count;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count<=0;
            clk_delayed = 0;
        end
        else begin
            if(count == ((10000_0000 / frequency)>>1)-1)begin
                clk_delayed = ~clk_delayed;
                count<=0;
            end
            else
                count<=count+1;
        end
    end
endmodule
```

show.v

```verilog
`timescale 1ns / 1ps
module show ( 
    input clk_delayed, rst, sw,
    output[7:0] tube_en,
    output[7:0] tube_out
);
    reg[2:0] scan_cnt;
    reg[7:0] seg_out_reg;
    reg[7:0] seg_en_reg;
    assign tube_out = seg_out_reg;
    assign tube_en = ~seg_en_reg;

    //scan
    always @(posedge clk_delayed or posedge rst) begin
        if (rst) begin
            scan_cnt<=0;
        end
        else begin
            if(scan_cnt==3'b111)
                scan_cnt<=0;
            else
                scan_cnt <= scan_cnt+1;
        end
    end

    always @(scan_cnt) begin
        case (scan_cnt)
            7: seg_en_reg = 8'b1000_0000;
            6: seg_en_reg = 8'b0100_0000;
            5: seg_en_reg = 8'b0010_0000;
            4: seg_en_reg = 8'b0001_0000;
            3: seg_en_reg = 8'b0000_1000;
            2: seg_en_reg = 8'b0000_0100;
            1: seg_en_reg = 8'b0000_0010;
            0: seg_en_reg = 8'b0000_0001;
            default: seg_en_reg = 0;
        endcase
    end
    always @(scan_cnt) begin
        if(sw)
            case (scan_cnt)
                2: seg_out_reg = 8'b11111000; //7
                3: seg_out_reg = 8'b11000000; //0
                4: seg_out_reg = 8'b10100100; //2
                5: seg_out_reg = 8'b10110110; //s
                6: seg_out_reg = 8'b11000110; //c
                default: seg_out_reg=8'b11111111;
            endcase
        else
            case (scan_cnt)
                2: seg_out_reg = 8'b10001110; //F
                3: seg_out_reg = 8'b11111001; //1
                4: seg_out_reg = 8'b10100100; //2
                5: seg_out_reg = 8'b11000000; //0
                6: seg_out_reg = 8'b10100100; //2
                default: seg_out_reg=8'b11111111;
            endcase
    end
endmodule
```



### CONSTRAINT FILE AND TESTING

**(This part is optional depending on the requirement of the lab task)**

*Describe how you test your design on the Minisys Practice platform* 

- *Constraint file (provide the screenshots on the feature of a pin and the binding info between pins and the input /output ports)*

```verilog
set_property IOSTANDARD LVCMOS33 [get_ports {tube_en[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tube_en[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tube_en[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tube_en[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tube_en[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tube_en[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tube_en[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tube_en[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tube_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tube_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tube_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tube_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tube_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tube_out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tube_out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tube_out[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports sw]

set_property PACKAGE_PIN Y18 [get_ports clk]
set_property PACKAGE_PIN P20 [get_ports rst]
set_property PACKAGE_PIN W4 [get_ports sw]
set_property PACKAGE_PIN A18 [get_ports {tube_en[7]}]
set_property PACKAGE_PIN A20 [get_ports {tube_en[6]}]
set_property PACKAGE_PIN B20 [get_ports {tube_en[5]}]
set_property PACKAGE_PIN E18 [get_ports {tube_en[4]}]
set_property PACKAGE_PIN F18 [get_ports {tube_en[3]}]
set_property PACKAGE_PIN D19 [get_ports {tube_en[2]}]
set_property PACKAGE_PIN E19 [get_ports {tube_en[1]}]
set_property PACKAGE_PIN C19 [get_ports {tube_en[0]}]
set_property PACKAGE_PIN F15 [get_ports {tube_out[0]}]
set_property PACKAGE_PIN F13 [get_ports {tube_out[1]}]
set_property PACKAGE_PIN F14 [get_ports {tube_out[2]}]
set_property PACKAGE_PIN F16 [get_ports {tube_out[3]}]
set_property PACKAGE_PIN E17 [get_ports {tube_out[4]}]
set_property PACKAGE_PIN C14 [get_ports {tube_out[5]}]
set_property PACKAGE_PIN C15 [get_ports {tube_out[6]}]
set_property PACKAGE_PIN E13 [get_ports {tube_out[7]}]
```

- *The testing result (provide the screenshots (at least 3 testing scenes) to show the state of inputs and outputs along with the related descriptions.*

​	Switch-off

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\4\pic\t3_off.jpg" alt="t3_off" style="zoom:50%;" />

​	Switch-on

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\4\pic\t3_on.jpg" alt="t3_on" style="zoom:50%;" />

### THE DESCRIPTION OF OPERATION

**(This part is always REQUIRED unless you can get full marks for this lab task)**

*Describe the problems that occurred while in the lab and your solution. Any suggestions are welcomed.*

- *Problems and solutions*



