# DIGITAL DESIGN ASSIGNMENT REPORT

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\LOGO.png" alt="LOGO" style="zoom:30%;" />

**Assignment ID: ** 3

**Student Name:** 刘乐奇

**Student ID:** 12011327



## PART 1: DIGITAL DESIGN THEORY 

1. The Kargaugh map of boolean function F is as below:

| AB(col)\CD(row) |  00  |  01  |  11  |  10  |
| :-------------: | :--: | :--: | :--: | :--: |
|       00        |  1   |  1   |  0   |  0   |
|       01        |  0   |  1   |  0   |  0   |
|       11        |  0   |  1   |  1   |  0   |
|       10        |  1   |  1   |  1   |  1   |

​	We have the combinations (SOP) (0, 1, 8, 9) (1, 5, 9, 13) (9, 11, 13, 15) (8, 9, 10, 11) and (POS) (2, 3, 6, 7) (4, 6, 12, 14). So we can simplify F as

$F = B'C' + C'D + AD + AB' = (A+C')(B'+D)$

(a) AND-OR：$F = B'C' + C'D + AD + AB'$

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\1_a.png" alt="1_a" style="zoom:25%;" />

(b) NOR-OR: $F = (B+C)' + (C+D')' + (A'+D')' + (A'+B)'$

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\1_b.png" alt="1_b" style="zoom:25%;" />

(c) NAND-NAND: $F = ((B'C')'(C'D)'(AD)'(AB')')'$

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\1_c.png" alt="1_c" style="zoom:25%;" />

(d) OR-AND: $F = (A+C')(B'+D)$

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\1_d.png" alt="1_d" style="zoom:25%;" />

(e) NOR-NOR: $F = ((A+C)'+(B'+D)')'$

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\1_e.png" alt="1_e" style="zoom:25%;" />

(f) NAND-AND: $F = (A'C)'(BD')'$

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\1_f.png" alt="1_f" style="zoom:25%;" />



2. Truth-table:

![2_tt](D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\2_tt.png)

​	From the truth-table, we can obtain the boolean function, and simplify it by using Karnaugh map:

​	Parity generator: 
$$
p = (A'B'C'D + A'B'CD' + A'BC'D' + A'BCD + ABC'D + ABCD' + AB'C'D' + AB'CD)' \\ = (A'B'(C'D+CD') + (A'B+AB')C'D' + (A'B+AB')CD + AB(C'D+CD'))' \\ = ((A'B+AB')(C'D'+CD)+(A'B'+AB)(C'D+CD'))' \\ = ((A \oplus B)(C \oplus D)' + (A \oplus B)'(C \oplus D))' \\ = (A \oplus B \oplus C \oplus D)'
$$

| AB(col)\CD(row) |  00  |  01  |  11  |  10  |
| :-------------: | :--: | :--: | :--: | :--: |
|       00        |  1   |      |  1   |      |
|       01        |      |  1   |      |  1   |
|       11        |  1   |      |  1   |      |
|       10        |      |  1   |      |  1   |

​	Circuit diagram:

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\2_pg_dia.png" alt="2_pg_dia" style="zoom:50%;" />



​	Parity checker: (the simplify process is similar to that of parity generator)
$$
F = (A \oplus B \oplus C \oplus P)'
$$

| AB(col)\CP(row) |  00  |  01  |  11  |  10  |
| :-------------: | :--: | :--: | :--: | :--: |
|       00        |  1   |      |  1   |      |
|       01        |      |  1   |      |  1   |
|       11        |  1   |      |  1   |      |
|       10        |      |  1   |      |  1   |

​	Circuit diagram:

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\2_pc_dia.png" alt="2_pc_dia" style="zoom:50%;" />



3. According to the requests, we have the truth-table as below:

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\3_tt.png" alt="3" style="zoom:33%;" />

​	From the truth-table, we can obtain the boolean function of each output $A$, $B$, $C$, and simplify it by using Karnaugh map:

​	$A = y + xz$

| x(col)\yz(row) |  00  |  01  |  11  |  10  |
| :------------: | :--: | :--: | :--: | :--: |
|       0        |      |      |  1   |  1   |
|       1        |      |  1   |  1   |  1   |

​	$B = y'z' + x'y' + xyz$

| x(col)\yz(row) |  00  |  01  |  11  |  10  |
| :------------: | :--: | :--: | :--: | :--: |
|       0        |  1   |  1   |      |      |
|       1        |  1   |      |  1   |      |

​	$C = x'z + xz'$

| x(col)\yz(row) |  00  |  01  |  11  |  10  |
| :------------: | :--: | :--: | :--: | :--: |
|       0        |      |  1   |  1   |      |
|       1        |  1   |      |      |  1   |

​	Then we can obtain the circuit diagram as below: 

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\3_dia.png" alt="3_dia" style="zoom:50%;" />

​	Here I used Vivado RTL diagram to help me generate the circuit diagram, with the ddesign verilog code:

```verilog
`timescale 1ns / 1ps

module diagram(
    input x, y, z,
    output A, B, C
    );
    assign A = y | x & z;
    assign B = ~y & ~z | ~x & ~y | x & y & z;
    assign C = ~x & z | x & ~z;

endmodule
```

 

4.  Suppose we have multiplier $A$ and $B$ and product $C$, with 3-bit $A_2,A_1,A_0$, $B_2, B_1, B_0$ and $C_5,C_4,C_3,C_2,C_1,C_0$, respectively. The graph below is the circuit diagram, in which `3-bit full adder` is used to add the product of corresponding bits and the carry from the previous half adder.

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\4_mul.png" alt="4_mul" style="zoom:50%;" />

The design circuit diagram can be derived from the multiplication process.

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\4_cal.png" alt="4_cal" style="zoom:50%;" />

​	The truth table is:

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\4_tt.png" alt="4_tt" style="zoom: 80%;" />



5. 

(a) Since
$$
F(A,B,C,D)=\sum (1,3,5,8,10,14)
$$
then we have ports $D_1, D_3, D_5, D_8, D_{10}, D_{14}$ connected to $1$, and ports $D_0, D_2, D_4, D_6, D_7, D_9, D_{11}, D_{12}, D_{13}, D_{15}$ connected to $0$.

 (b) Since
$$
F(A,B,C,D)=\prod (4,7,11) = \sum (0,1,2,3,5,6,8,9,10,12,13,14,15)
$$
then we have ports $D_0, D_1, D_2, D_3, D_5, D_6, D_8, D_9, D_{10}, D_{12}, D_{13}, D_{14}, D_{15}$ connected to $1$, and ports $D_4, D_7, D_{11}$ connected to $0$.

6.  The truth-table:

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\6_tt.png" alt="6_tt" style="zoom:50%;" />

​	The circuit diagram: 

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\6.png" alt="6" style="zoom:50%;" />



## PART 2: DIGITAL DESIGN LAB (TASK 1)

### DESIGN

- *Verilog design*

74138 decoder: 

```verilog
`timescale 1ns / 1ps

module dec_74138(
    input I0,I1,I2,
    input EN,
    output reg [7:0] y
    );

  always@* begin
       if(~EN)
           case({I2,I1,I0})
           3'b000:y=8'b00000001;
           3'b001:y=8'b00000010;  
           3'b010:y=8'b00000100;  
           3'b011:y=8'b00001000;  
           3'b100:y=8'b00010000; 
           3'b101:y=8'b00100000;  
           3'b110:y=8'b01000000;            
           3'b111:y=8'b10000000;
           endcase
       else y=8'b00000000;
    end   
endmodule
```

4-16 decoder:

```verilog
`timescale 1ns / 1ps

module dec_4_16(
    input I0,I1,I2,I3,
    output [15:0] y
    );
    
    dec_74138 d1(.I0(I0),.I1(I1),.I2(I2),.EN(I3),.y(y[7:0]));
    dec_74138 d2(.I0(I0),.I1(I1),.I2(I2),.EN(~I3),.y(y[15:8]));
    
endmodule
```



### SIMULATION

- *Using Verilog (provide the Verilog code)*

74138 decoder:

```verilog
`timescale 1ns / 1ps

module dec_74138_sim();
    reg I0,I1,I2,EN;
    wire [7:0] y;
    
    dec_74138 d(.I0(I0),.I1(I1),.I2(I2),.EN(EN),.y(y));
    initial begin
        EN = 1'b0;
        {I2,I1,I0} = 3'b000;
        repeat(7) #10 {I2,I1,I0} = {I2,I1,I0} + 1'b1;
        #10 $finish;
    end
    
endmodule
```

4-16 decoder:

```verilog
`timescale 1ns / 1ps

module dec_4_16_sim();
    reg I0,I1,I2,I3;
    wire [15:0] y;
    
    dec_4_16 d(.I0(I0),.I1(I1),.I2(I2),.I3(I3),.y(y));
    initial begin
        {I3,I2,I1,I0} = 4'b0000;
        repeat(15) #10 {I3,I2,I1,I0} = {I3,I2,I1,I0} + 1'b1;
        #10 $finish;
    end
    
endmodule
```



- *The waveform of simulation result (provide screenshots)*

74138 decoder:

![t1_74138_sim](D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\t1_74138_sim.png)

4-16 decoder:

![t1_4_16_sim](D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\t1_4_16_sim.png)



- *The description on whether the simulation result is the same as the truth-table, and whether the function of the design meets the expectation.*

​	Here I did not negated the output. So in 74138, if {I2, I1, I0} = 3'b001, then the output is y1; in 4-16 decoder, if {I3, I2, I1, I0} = 4'b0110, then the output is y6. The result of the simulation is well matched to the expectation.



### CONSTRAINT FILE AND TESTING

**(This part is optional depending on the requirement of the lab task)**

*Describe how you test your design on the Minisys Practice platform* 

- *Constraint file (provide the screenshots on the feature of a pin and the binding info between pins and the input /output ports)*

```verilog
set_property IOSTANDARD LVCMOS33 [get_ports I0]
set_property IOSTANDARD LVCMOS33 [get_ports I1]
set_property IOSTANDARD LVCMOS33 [get_ports I2]
set_property IOSTANDARD LVCMOS33 [get_ports I3]
set_property IOSTANDARD LVCMOS33 [get_ports {y[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[0]}]

set_property PACKAGE_PIN Y8 [get_ports I3]
set_property PACKAGE_PIN Y7 [get_ports I2]
set_property PACKAGE_PIN W9 [get_ports I1]
set_property PACKAGE_PIN Y9 [get_ports I0]

set_property PACKAGE_PIN K17 [get_ports {y[0]}]
set_property PACKAGE_PIN L13 [get_ports {y[1]}]
set_property PACKAGE_PIN M13 [get_ports {y[2]}]
set_property PACKAGE_PIN K14 [get_ports {y[3]}]
set_property PACKAGE_PIN K13 [get_ports {y[4]}]
set_property PACKAGE_PIN M20 [get_ports {y[5]}]
set_property PACKAGE_PIN N20 [get_ports {y[6]}]
set_property PACKAGE_PIN N19 [get_ports {y[7]}]
set_property PACKAGE_PIN M17 [get_ports {y[8]}]
set_property PACKAGE_PIN M16 [get_ports {y[9]}]
set_property PACKAGE_PIN M15 [get_ports {y[10]}]
set_property PACKAGE_PIN K16 [get_ports {y[11]}]
set_property PACKAGE_PIN L16 [get_ports {y[12]}]
set_property PACKAGE_PIN L15 [get_ports {y[13]}]
set_property PACKAGE_PIN L14 [get_ports {y[14]}]
set_property PACKAGE_PIN J17 [get_ports {y[15]}]
```

- *The testing result (provide the screenshots (at least 3 testing scenes) to show the state of inputs and outputs along with the related descriptions.*

1.  Description of the pin

​	The left-most four switches are performing as 4-bit input, $I_0$ to $I_3$ from left to right. The 16 lights above the switches are indicating the states of the output, $y_0$ to $y_{15}$ from left to right.

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\t1\description.png" alt="description" style="zoom:50%;" />

2. $\{ I_3,I_2,I_1,I_0 \} = 4'b0000$, the left-most light ($y_0$) is on. 

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\t1\y0.jpg" alt="y0" style="zoom:50%;" />

3. $\{ I_3,I_2,I_1,I_0 \} = 4'b0100$, the light $y_4$ is on. 

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\t1\y4.jpg" alt="y4" style="zoom:50%;" />

4. $\{ I_3,I_2,I_1,I_0 \} = 4'b1001$, the light $y_9$ is on. 

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\t1\y9.jpg" alt="y9" style="zoom:50%;" />

5. $\{ I_3,I_2,I_1,I_0 \} = 4'b1100$, the light $y_{12}$ is on. 

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\t1\y12.jpg" alt="y12" style="zoom:50%;" />

6. $\{ I_3,I_2,I_1,I_0 \} = 4'b1111$, the light $y_{15}$ is on. 

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\t1\y15.jpg" alt="y15" style="zoom:50%;" />



### THE DESCRIPTION OF OPERATION

**(This part is always REQUIRED unless you can get full marks for this lab task)**

*Describe the problems that occurred while in the lab and your solution. Any suggestions are welcomed.*

- *Problems and solutions*

1. Sometimes the Vivado would not work, then I closed it and reopenit or even reboot my computer.
2. Some lights of the board did not work, making me confused when some test cases out of my expectation.



## PART 2: DIGITAL DESIGN LAB (TASK 2)

### DESIGN

- *Boolean function*

$$
Y = A'B'C'D'+BD+AC+B'CD'+A'B'D' \\ = A'B'C'D' + A'B'CD' + AB'CD' + A'BC'D + A'BCD + ABC'D + ABCD + AB'CD + ABCD' \\ = \sum (0,2,5,7,10,11,13,14,15)
$$

- *Karnaugh map*

| AB(col)\CD(row) |  00  |  01  |  11  |  10  |
| :-------------: | :--: | :--: | :--: | :--: |
|       00        |  1   |      |      |  1   |
|       01        |      |  1   |  1   |      |
|       11        |      |  1   |  1   |  1   |
|       10        |      |      |  1   |  1   |

- *Truth table*

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\t2_tt.png" alt="t2_tt" style="zoom:50%;" />



- *Verilog design*

74151 multiplexer: mux_74151

```verilog
`timescale 1ns / 1ps

module mux_74151(
    input EN, S0, S1, S2, 
    input D0, D1, D2, D3, D4, D5, D6, D7,
    output reg  Y, W
    );

    always @* begin
        if(~EN) 
            case({S2, S1, S0})
                3'b000: Y = D0;
                3'b001: Y = D1;
                3'b010: Y = D2;
                3'b011: Y = D3;
                3'b100: Y = D4;
                3'b101: Y = D5;
                3'b110: Y = D6;
                3'b111: Y = D7;
            endcase        
        else
            Y = 1'b0;
        assign W = ~Y;
    end
endmodule
```

(a) data flow: func_df

```verilog
`timescale 1ns / 1ps

module func_df(
    input A,B,C,D,
    output Y,W
    );
    
    assign Y = (~A&~B&~C&~D)|(B&D)|(A&C)|(~B&C&~D)|(~A&~B&~D);
    assign W = ~Y;
endmodule
```

(b) one 74151: func_1mux

```verilog
`timescale 1ns / 1ps

module func_1mux(
    input en,a,b,c,d,
    output y,w
    );
     mux_74151 mu(
           .EN(en),.S0(c),.S1(b),.S2(a),
           .D0(~d),
           .D1(~d),
           .D2(d),
           .D3(d),
           .D4(1'b0),
           .D5(1'b1),
           .D6(d),
           .D7(1'b1),
           .Y(y),.W(w)
           );
endmodule
```

(c) two 74151: func_2mux

```verilog
`timescale 1ns / 1ps

module func_2mux(
    input en,a,b,c,d,
    output y,w
    );
    wire y1,w1,y2,w2;
     mux_74151 mu1(
           .EN(a),.S0(d),.S1(c),.S2(b),
           .D0(1'b1),
           .D1(1'b0),
           .D2(1'b1),
           .D3(1'b0),
           .D4(1'b0),
           .D5(1'b1),
           .D6(1'b0),
           .D7(1'b1),
           .Y(y1),.W(w1)
           ); 
           
     mux_74151 mu2(
           .EN(~a),.S0(d),.S1(c),.S2(b),
           .D0(1'b0),
           .D1(1'b0),
           .D2(1'b1),
           .D3(1'b1),
           .D4(1'b0),
           .D5(1'b0),
           .D6(1'b1),
           .D7(1'b1),
           .Y(y2),.W(w2)
           );        
    
    assign y = y1|y2;
    assign w = w1&w2;
    
endmodule
```



### SIMULATION

- *Using Verilog (provide the Verilog code)*

74151: 

```verilog
`timescale 1ns / 1ps

module mux_74151_sim();
    reg en,a,b,c;
    reg t0,t1,t2,t3,t4,t5,t6,t7;
    wire y,w;
    
    mux_74151 mu(
        .EN(en),.S0(c),.S1(b),.S2(a),
        .D0(t0),
        .D1(t1),
        .D2(t2),
        .D3(t3),
        .D4(t4),
        .D5(t5),
        .D6(t6),
        .D7(t7),
        .Y(y),.W(w));
    
    initial begin
        en = 1'b1;
        {t7,t6,t5,t4,t3,t2,t1,t0} = 8'b00000000;
        #10
        en = 1'b0;
        {a,b,c} = 3'b000;{t7,t6,t5,t4,t3,t2,t1,t0} = 8'b00000001;
        #10 {a,b,c} = 3'b001;{t7,t6,t5,t4,t3,t2,t1,t0} = 8'b00000010;
        #10 {a,b,c} = 3'b010;{t7,t6,t5,t4,t3,t2,t1,t0} = 8'b00000100;
        #10 {a,b,c} = 3'b011;{t7,t6,t5,t4,t3,t2,t1,t0} = 8'b00001000;
        #10 {a,b,c} = 3'b100;{t7,t6,t5,t4,t3,t2,t1,t0} = 8'b00010000;
        #10 {a,b,c} = 3'b101;{t7,t6,t5,t4,t3,t2,t1,t0} = 8'b00100000;
        #10 {a,b,c} = 3'b110;{t7,t6,t5,t4,t3,t2,t1,t0} = 8'b01000000;
        #10 {a,b,c} = 3'b111;{t7,t6,t5,t4,t3,t2,t1,t0} = 8'b10000000;
        
        #10 $finish;
    end
    
endmodule
```

func_df, func_1mux, func_2mux:

```verilog
`timescale 1ns / 1ps

module func_sim();
    reg en,a,b,c,d;
    wire y_f,w_f,y1,w1,y2,w2;
    
    func_df fun(.A(a),.B(b),.C(c),.D(d),.Y(y_f),.W(w_f));
    func_1mux f1(.en(en),.a(a),.b(b),.c(c),.d(d),.y(y1),.w(w1));
    func_2mux f2(.en(en),.a(a),.b(b),.c(c),.d(d),.y(y2),.w(w2));
    initial begin
        en = 1'b0;
        {a,b,c,d} = 4'b0000;
         repeat(15) #10 {a,b,c,d} = {a,b,c,d} + 4'b0001;
         #10 $finish;
    end
       
endmodule
```



- *The waveform of simulation result (provide screenshots)*

mux_74151:

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\t2_mux_74151.png" alt="t2_mux_74151" style="zoom:50%;" />

| variables |           description           |
| :-------: | :-----------------------------: |
|    en     |   enable signal, 0 for enable   |
|   a,b,c   | input, from high to low {a,b,c} |
|    y,w    |         output, w = ~y          |

func_df, func_1mux, func_2mux:

<img src="D:\Lynchrocket\大二上\数字逻辑\assignment\3\pic\t2_sim.png" alt="t2_sim" style="zoom:50%;" />

| variables |           description           |
| :-------: | :-----------------------------: |
|    en     |   enable signal, 0 for enable   |
|  a,b,c,d  | input, from high to low {a,b,c} |
|  y_f,w_f  |        output of func_df        |
|   y1,w1   |       output of func_1mux       |
|   y2,w2   |       output of func_2mux       |

- *The description on whether the simulation result is the same as the truth-table, and whether the function of the design meets the expectation.*

​	The result is well matched the expectation. And I did not negate the result.

### THE DESCRIPTION OF OPERATION

1. The corresponding ports are needed to be noticed.
