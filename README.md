# MIPS-MULTICYCLE
MIPS多周期处理器

## 实验内容：
- 仔细阅读教材7.4节(P240-255)内容 
- 完成MIPS多周期处理器设计 
- 用教材图7-60(P276)测试代码，测试上述设计 
- 参考《Multicycle Processor.pdf》完成设计、模拟 
- 在NEXYS4 DDR板上实现两位正整数加法运算，如12+34=046 

## 实验方案：
1.基础部分：
<br>	1)MIPS指令处理器可以分为程序计数器（计算PC值）、寄存器文件（读取指令中的rs、rt地址进行读写操作）、指令存储器（读取指令）、数据存储器（将计算结果进行存储）4个状态元件。不同的状态元件通过数据通路连接，并使用复用器，进行其他指令的数据拓展。
<br>	2）MIPS指令处理器通过读入instr，并通过真值表进行对应的解析，进行过相应的操作，基础部分的主译码器真值表如下：

<br>![图片](https://github.com/Indifference061/MIPS-MULTI/assets/87850383/410ffe0e-3cae-45ec-a1e9-1f0e1c5f0179)

<br>ALU译码器真值表：

<br>![图片](https://github.com/Indifference061/MIPS-MULTI/assets/87850383/97cfa807-87a7-4b51-a452-9710ce781dfe)

分别使用主译码器和ALU译码器对instr对应位置指令进行译码，产生一个2位的信号aluop，与funct信号决定alucontrol的值，作为alu计算选择信号。
<br>	3）多周期处理器与单周期的区别在于：每条指令的周期数不同，且只用一个加法器，一个存储器（用于取指和存数据），多出了5个寄存器和2个MUX
	<br>多周期处理器的原理图：
 
 <br>![图片](https://github.com/Indifference061/MIPS-MULTI/assets/87850383/bfcd95b8-6863-4af5-bc69-5d4bd21b461e)

 <br>	4）控制单元controller与单周期有所区别，主要区别在于maindec模块需要利用摩尔型状态机进行状态的转化，状态转化的原理图如下：
 
 <br>![图片](https://github.com/Indifference061/MIPS-MULTI/assets/87850383/45ee9772-0eea-40e9-ad94-8f802550fec8)
各个状态的真值表如下：

<br>![图片](https://github.com/Indifference061/MIPS-MULTI/assets/87850383/be1a7016-b8fa-4ace-89ca-b83ea5aa2c97)

<br>各个指令对应的opcode

<br>![图片](https://github.com/Indifference061/MIPS-MULTI/assets/87850383/13b3b652-0a74-4355-8fe1-68db209691c4)

<br>5）设计仿真文件对memfile.dat进行仿真测试。

2.上板部分：
1）需要增加andi指令，就需要在基础的部分，在maindec中增加表示andi的状态，并增加数据通路或者复用器。
各个状态对应control对应参数的赋值
指令	pcwrite,memwrite,irwrite,regwrite,alusrca,branch,iord	|memtoreg	| regdst	|alusrcb	|Pcsrc	|aluop
FETCH	1010000	0	0	01	00	000
DECODE	0000000	0	0	11	00	000
MEMADR	0000100	0	0	10	00	000
MEMRD	0000001	0	0	00	00	000
MEMWB	0001000	1	0	00	00	000
MEMWR	0100001	0	0	00	00	000
RTYPEEX	0000100	0	0	00	00	010
RTYPEWB	0001000	0	1	00	00	000
BEQEX	0000110	0	0	00	01	001
ADDIEX	0000100	0	0	10	00	000
ADDIWB	0001000	0	0	00	00	000
JEX	1000000	0	0	00	10	000
ANDIEX	0000100	0	0	10	00	100
ANDIWB	0001000	0	0	00	00	000

Alu译码器如下：
操作	Aluop|	Funct	|Alucontrol
Addi	000	    /	       010
Andi	100	    /	       000
Add	010	100000	010
Sub	010	100010	110
And	010	100100	000
Or	010	100101	001
Slt	010	101010	111
3.IO接口部分
增加IO模块，并用dMemoryDecoder模块将其dmem扩展，包括dmem，IO模块和7段数码管，并进行仿真
原理图如下：
主要增加了两个IO设备：16位开关输入和七段数码管进行加法结果输出，BTNR和BTNL作为状态端口分别控制数据的输入输出，当BTNR为1时，可输入新数据,  status[1]=1，当BTNL为1时，led已准备好，可输出新数据, status[0]=1。
	在IO模块中传入writeData，并根据控制端口以及addr[7]决定的Write使能对led进行计算结果赋值
	七段数码管的数据由IO传入，由switch[15:0],0000,led[11:0]构成，在数码管上进行分时显示。
