`ifndef TIMESCALE
`timescale 1ns/1ns
`endif

`define HCYCLE 10
`define PERIOD 20
`define MEM_DELAY 3

// Register specifiers
`define R0  5'd0
`define R31 5'd31

// Address of a register type
`define REG_ADDR_WIDTH 6
  
// Coding of the level of data availability for UR
`define LEVEL_TYPE_WIDTH 2

// Data available from the op2 of DI stage
`define LVL_RF_    2'b11
// Data available from the data_ual register of EX stage
`define LVL_EX_    2'b10
// Data available from the data_ecr register of MEM stage
`define LVL_MEM_   2'b01
// Data available only in the register bank
`define LVL_WB_    2'b00

// Starting boot address (after reset)
`define ADDR_INIT_  32'h00000000
`define INST_NOP_   32'h00000000

//INST_ROM parameter
`define INST_ROM_SIZE (4*1024) //4k word //2048
`define INST_ROM_ADDR_WIDTH 32
`define INST_ROM_DATA_WIDTH 32
`define INST_ROM_START 0
`define INST_ROM_LATENCY 10

//DATA_RAM parameter
`define DATA_RAM_SIZE (4*1024) //4k word //256
`define DATA_RAM_ADDR_WIDTH `INST_ROM_ADDR_WIDTH
`define DATA_RAM_DATA_WIDTH `INST_ROM_DATA_WIDTH
`define DATA_RAM_START 32'h00000000
`define DATA_RAM_MASK  32'h7fffffff
`define DATA_RAM_LATENCY 10

// Memory parameter 
`define MEM_ADDR_WIDTH 21 
`define MEM_SIZE 2097152
//2048

// Cache parameter
`define BLOCK_SIZE 4
`define INDEX_SIZE 9
`define TAG_SIZE 32 - `BLOCK_SIZE - `INDEX_SIZE 
`define LOG_BLOCK_SIZE 2

//
// SDRAM parameter
//
//`define ROWSTART        9           
//`define ROWSIZE         12
//`define COLSTART        0
//`define COLSIZE         9
//`define BANKSTART       20
//`define BANKSIZE        2

//`define BURST_MODE		0	// read/write burst
//`define INTERLEAVED		0	// sequential
//`define BURST_MODE		0	// read/write burst
//`define BURST_LENGTH  8	
//`define LOG_BURST_LENGTH  3	

//num of hardware interruption
`ifndef HW_IT_NUM
`define HW_IT_NUM 4
`endif 

`ifndef EXC_ENTRANCE
`define EXC_ENTRANCE 'h24
`endif

// Type for the alu control
`define ALU_CTRL_WIDTH 29

//############################ NO OPERATION ########################
`define ALU_OP_NONE   `ALU_CTRL_WIDTH'b00000000000000000000000000000
//############################ ADD & SUB ###########################
`define ALU_OP_ADD    `ALU_CTRL_WIDTH'b10000000000000000000000000000 // op1 + op2 signed 
`define ALU_OP_ADDU   `ALU_CTRL_WIDTH'b01000000000000000000000000000 // op1 + op2 unsigned
`define ALU_OP_SUB    `ALU_CTRL_WIDTH'b00100000000000000000000000000 // op1 - op2 signed
`define ALU_OP_SUBU   `ALU_CTRL_WIDTH'b00010000000000000000000000000 // op1 - op2 unsigned
`define ALU_OP_SLT    `ALU_CTRL_WIDTH'b00001000000000000000000000000 // op1 < op2 (signed)
`define ALU_OP_SLTU   `ALU_CTRL_WIDTH'b00000100000000000000000000000 // op1 < op2 (unsigned)
//############################ Logical #############################
`define ALU_OP_AND    `ALU_CTRL_WIDTH'b00000010000000000000000000000
`define ALU_OP_OR     `ALU_CTRL_WIDTH'b00000001000000000000000000000
`define ALU_OP_XOR    `ALU_CTRL_WIDTH'b00000000100000000000000000000
`define ALU_OP_NOR    `ALU_CTRL_WIDTH'b00000000010000000000000000000
//############################ Shifts ##############################
`define ALU_OP_SLL    `ALU_CTRL_WIDTH'b00000000001000000000000000000 
`define ALU_OP_SRL    `ALU_CTRL_WIDTH'b00000000000100000000000000000 
`define ALU_OP_SRA    `ALU_CTRL_WIDTH'b00000000000010000000000000000
//########################### LUI ##################################
`define ALU_OP_LUI    `ALU_CTRL_WIDTH'b00000000000001000000000000000 //load 16bits imm into reg
//########################### MISC #################################
`define ALU_OP_OP2    `ALU_CTRL_WIDTH'b00000000000000100000000000000 //return op2
//########################### Branch Tests #########################
`define ALU_OP_EQ     `ALU_CTRL_WIDTH'b00000000000000010000000000000 // op1 == op2
`define ALU_OP_NEQ    `ALU_CTRL_WIDTH'b00000000000000001000000000000 // op1 != op2
`define ALU_OP_LTZ    `ALU_CTRL_WIDTH'b00000000000000000100000000000 // op1 < 0
`define ALU_OP_GTZ    `ALU_CTRL_WIDTH'b00000000000000000010000000000 // op1 > 0
`define ALU_OP_LEZ    `ALU_CTRL_WIDTH'b00000000000000000001000000000 // op1 <= 0
`define ALU_OP_GEZ    `ALU_CTRL_WIDTH'b00000000000000000000100000000 // op1 >= 0
//########################## MUL&DIV OPERATIONS#####################
`define ALU_OP_MULT   `ALU_CTRL_WIDTH'b00000000000000000000010000000 //op1 * op2 signed 
`define ALU_OP_MULTU  `ALU_CTRL_WIDTH'b00000000000000000000001000000 //op1 * op2 unsigned
`define ALU_OP_DIV    `ALU_CTRL_WIDTH'b00000000000000000000000100000 //op1 / op2 signed 
`define ALU_OP_DIVU   `ALU_CTRL_WIDTH'b00000000000000000000000010000 //op1 / op2 unsigned 
`define ALU_OP_MFHI   `ALU_CTRL_WIDTH'b00000000000000000000000001000 //move from hi
`define ALU_OP_MFLO   `ALU_CTRL_WIDTH'b00000000000000000000000000100 //move from lo
`define ALU_OP_MTHI   `ALU_CTRL_WIDTH'b00000000000000000000000000010 //move to hi
`define ALU_OP_MTLO   `ALU_CTRL_WIDTH'b00000000000000000000000000001 //move to lo

//alu optype definition
`define ALU_TYPE_ADD   5'b00001
`define ALU_TYPE_LOGIC 5'b00010
`define ALU_TYPE_SHIFT 5'b00100
`define ALU_TYPE_MUL   5'b01000
`define ALU_TYPE_MISC  5'b10000
`define ALU_TYPE_WIDTH 5

/*
//////////////////////////////////////////////////////////////////////////////////////
// Instruction decoding format in micro-instructions table
////////////////////////////////////////////////////////////////////////////////////////
bra(3)                    // Branch instruction,10:branch 01: jmp(i.e. j,jal,jr,jalr)
link(1)                   // Branch with link : the return address is saved in a register
alu_code(ALU_CTRL_WIDTH)  // Operation code for the alu
op_mem(1)                 // Memory operation needed
r_w(1)                    // Read/Write selection in memory
mem_op_type(7)            //specify the type of the mem operation 
                          //0000000 no mem operation
                          //1000000 word operation,i.e. lw,sw
                          //0100000 half word operation(signed),i.e. lh,sh
                          //0010000 half word operation(unsigned),i.e. lhu
                          //0001000 byte operation(signed),i.e. lb,sb
                          //0000100 byte operation(unsigned),i.e. lbu
                          //0000010 word left operation,i.e. lwl,swl
                          //0000001 word right operation,i.e. lwr,swr
exc_type(5)               // Unconditionnal exception cause to generate
cop_org1(1)               // Source register 1 : general register if 0, coprocessor register if 1
cop_org2(1)               // Source register 2 : general register if 0, coprocessor register if 1
use_reg1(1)               // Use data1 from regfile as first oprand, it has higher priority than use_imm1
use_reg2(1)               // Use data2 from regfile as second oprand, it has higher priority than use_imm1
imm1_sel(1)               // Origin of immediate operand 1
imm2_sel(1)               // Origin of immediate operand 2
level(`LVL_TYPE_WIDTH)    // Data availability stage for the bypass
ecr_reg(1)                // Writing the result in a register
bank_des(1)               // Register bank selection : GPR if 0, coprocessor system if 1
des_sel(2)                // Destination register address : Rt, Rd, $31, $0 
*/


//branch encodings 
`define tBRA  3'b001
`define tJR   3'b010
`define tJMP  3'b100
`define tNBRA 3'b000

//branch link encodings
`define tLINK  1'b1
`define tNLINK 1'b0

//memory operation encodings
`define tOP_MEM  1'b1
`define tNOP_MEM 1'b0

//memory read/write encodings
`define tWRITE 1'b1 
`define tREAD  1'b0
`define tNULL  1'bx

//memory operation type encodings
`define tMEM_OP_NULL   7'b0000000 //no mem operation
`define tMEM_OP_WORD   7'b1000000 //word operation,i.e. lw,sw
`define tMEM_OP_HWORD  7'b0100000 //half word operation(signed),i.e. lh,sh
`define tMEM_OP_HWORDU 7'b0010000 //half word operation(unsigned),i.e. lhu
`define tMEM_OP_BYTE   7'b0001000 //byte operation(signed),i.e. lb,sb
`define tMEM_OP_BYTEU  7'b0000100 //byte operation(unsigned),i.e. lbu
`define tMEM_OP_WL     7'b0000010 //word left operation,i.e. lwl,swl
`define tMEM_OP_WR     7'b0000001 //word right operation,i.e. lwr,swr

//offset type encodings
`define tOFS_JMP     2'b00   //For j and jal, break, syscall, etc, offset={pc[31:29],imm26,2'b0}
`define tOFS_BRANCH  2'b01   //For conditional branches, offset= signed_ext({imm16,2'b0})
`define tOFS_MEM     2'b10   //For memory operation, offset = signed_ext(imm16)
`define tOFS_NULL    2'b11   //don't care offset,no used

`define EXC_TYPE_WIDTH 5
// execution type definition
`define tEXC_NONE         5'b00000
`define tEXC_SYSCALL      5'b00001
`define tEXC_BREAK        5'b00010
`define tEXC_COP0         5'b00100
`define tEXC_OVERFLOW     5'b01000
`define tEXC_ILLEGAL_INST 5'b10000

//cop_reg and bank_des  value definition
`define tCOP_REG 1'b1 //coprocessor register sel
`define tGEN_REG 1'b0 //general register sel
`define tNO_REG  1'bx //don't care

//use_reg1 value encoding
`define tUSE_REG1  1'b1
`define tNUSE_REG1 1'b0

//use_reg2 value encoding
`define tUSE_REG2  1'b1
`define tNUSE_REG2 1'b0

//imm_sel1 value encoding
`define tIMM1_SEL  1'b1
`define tIMM1_NSEL 1'b0

//imm_sel2 value encoding
`define tIMM2_SEL  1'b1
`define tIMM2_NSEL 1'b0

// 16-bit immediate operand extension encoding
`define tIMM_SEXT 1'b1
`define tIMM_ZEXT 1'b0

//register write encoding
`define tWE  1'b1
`define tNWE 1'b0

//destination register write select encoding
`define tD_RT  2'b00
`define tD_RD  2'b01
`define tD_31  2'b10
`define tD_00  2'b11 

// The long encoding sequence is as follows:
// bra |  link  | alu_code    | op_mem |  r_w   | mem_op_type  | 
// exc_cause   | cop_org1 | cop_org2 | use_reg1 |  use_reg2  | 
// imm1_sel  |imm2_sel | imm_ext | level |ecr_reg|bank_des|des_sel

`define DE__INVALID\
{`tNBRA, `tNLINK,`ALU_OP_NONE ,`tNOP_MEM,`tNULL ,`tMEM_OP_NULL,\
 `tEXC_ILLEGAL_INST,`tGEN_REG,`tGEN_REG,`tNUSE_REG1,`tNUSE_REG2,\
 `tIMM1_NSEL,`tIMM2_NSEL,`tIMM_ZEXT,  `LVL_RF_,`tNWE,`tNO_REG ,`tD_00}
 
`define DE__SLL\
{`tNBRA,`tNLINK, `ALU_OP_SLL,`tNOP_MEM,`tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tNUSE_REG1, `tUSE_REG2,\
 `tIMM1_SEL ,`tIMM2_NSEL,`tIMM_ZEXT,  `LVL_EX_,`tWE,`tGEN_REG,`tD_RD}

`define DE__SRL\
{`tNBRA, `tNLINK, `ALU_OP_SRL, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tNUSE_REG1, `tUSE_REG2,\
 `tIMM1_SEL , `tIMM2_NSEL, `tIMM_ZEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_RD}

`define DE__SRA\
{`tNBRA, `tNLINK, `ALU_OP_SRA, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tNUSE_REG1, `tUSE_REG2,\
 `tIMM1_SEL , `tIMM2_NSEL, `tIMM_ZEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_RD}
         
`define DE__SLLV\
{`tNBRA, `tNLINK, `ALU_OP_SLL, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1 , `tUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_ZEXT,  `LVL_EX_ , `tWE, `tGEN_REG, `tD_RD}

`define DE__SRLV\
{`tNBRA, `tNLINK, `ALU_OP_SRL, `tNOP_MEM, `tNULL , `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_ZEXT,  `LVL_EX_ , `tWE , `tGEN_REG, `tD_RD}

`define DE__SRAV\
{`tNBRA, `tNLINK, `ALU_OP_SRA, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_ZEXT,  `LVL_EX_ , `tWE , `tGEN_REG, `tD_RD}

//mul & div
//`define DE__MULT    {`tNBRA, `tNLINK, `ALU_OP_MULT , `tNOP_MEM, `tNULL , `tMEM_OP_NULL  , `tEXC_NONE    , `tGEN_REG, `tGEN_REG, `tUSE_REG1 , `tUSE_REG2 , `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_EXT,  `LVL_EX_ , `tNWE, `tNO_REG , `tD_00}// MULT
//`define DE__MULTU   {`tNBRA, `tNLINK, `ALU_OP_MULTU, `tNOP_MEM, `tNULL , `tMEM_OP_NULL  , `tEXC_NONE    , `tGEN_REG, `tGEN_REG, `tUSE_REG1 , `tUSE_REG2 , `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_EXT,  `LVL_EX_ , `tNWE, `tNO_REG , `tD_00}// MULTU
//`define DE__DIV     {`tNBRA, `tNLINK, `ALU_OP_DIV  , `tNOP_MEM, `tNULL , `tMEM_OP_NULL  , `tEXC_NONE    , `tGEN_REG, `tGEN_REG, `tUSE_REG1 , `tUSE_REG2 , `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_EXT,  `LVL_EX_ , `tNWE, `tNO_REG , `tD_00}// DIV
//`define DE__DIVU    {`tNBRA, `tNLINK, `ALU_OP_DIVU , `tNOP_MEM, `tNULL , `tMEM_OP_NULL  , `tEXC_NONE    , `tGEN_REG, `tGEN_REG, `tUSE_REG1 , `tUSE_REG2 , `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_EXT,  `LVL_EX_ , `tNWE, `tNO_REG , `tD_00}// DIVU
//`define DE__MFHI    {`tNBRA, `tNLINK, `ALU_OP_MFHI , `tNOP_MEM, `tNULL , `tMEM_OP_NULL  , `tEXC_NONE    , `tGEN_REG, `tGEN_REG, `tNUSE_REG1, `tNUSE_REG2, `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_EXT,  `LVL_EX_ , `tWE , `tGEN_REG, `tD_RD}// MFHI
//`define DE__MTHI    {`tNBRA, `tNLINK, `ALU_OP_MTHI , `tNOP_MEM, `tNULL , `tMEM_OP_NULL  , `tEXC_NONE    , `tGEN_REG, `tGEN_REG, `tUSE_REG1 , `tNUSE_REG2, `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_EXT,  `LVL_RF_ , `tNWE, `tNO_REG , `tD_00}// MTHI
//`define DE__MFLO    {`tNBRA, `tNLINK, `ALU_OP_MFLO , `tNOP_MEM, `tNULL , `tMEM_OP_NULL  , `tEXC_NONE    , `tGEN_REG, `tGEN_REG, `tNUSE_REG1, `tNUSE_REG2, `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_EXT,  `LVL_EX_ , `tWE , `tGEN_REG, `tD_RD}// MFLO
//`define DE__MTLO    {`tNBRA, `tNLINK, `ALU_OP_MTLO , `tNOP_MEM, `tNULL , `tMEM_OP_NULL  , `tEXC_NONE    , `tGEN_REG, `tGEN_REG, `tUSE_REG1 , `tNUSE_REG2, `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_EXT,  `LVL_RF_ , `tNWE, `tNO_REG , `tD_00}// MTLO

`define DE__SUB\
{`tNBRA, `tNLINK, `ALU_OP_SUB, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_OVERFLOW, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_ZEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_RD}

`define DE__SUBU\
{`tNBRA, `tNLINK, `ALU_OP_SUBU, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_ZEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_RD}

`define DE__ADD\
{`tNBRA, `tNLINK, `ALU_OP_ADD, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_OVERFLOW, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_ZEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_RD}

`define DE__ADDU\
{`tNBRA, `tNLINK, `ALU_OP_ADDU, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2, \
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_ZEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_RD}

`define DE__ADDI\
{`tNBRA, `tNLINK, `ALU_OP_ADD, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_OVERFLOW, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tNUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_SEL, `tIMM_SEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_RT}

`define DE__ADDIU\
{`tNBRA, `tNLINK, `ALU_OP_ADDU, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tNUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_SEL, `tIMM_SEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_RT}

`define DE__SLT\
{`tNBRA, `tNLINK, `ALU_OP_SLT, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_ZEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_RD}

`define DE__SLTU\
{`tNBRA, `tNLINK, `ALU_OP_SLTU, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_ZEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_RD}

`define DE__SLTI\
{`tNBRA, `tNLINK, `ALU_OP_SLT, `tNOP_MEM, `tNULL, `tMEM_OP_NULL, `tEXC_NONE,\
 `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tNUSE_REG2, \
 `tIMM1_NSEL, `tIMM2_SEL, `tIMM_SEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_RT}

`define DE__SLTIU\
{`tNBRA, `tNLINK, `ALU_OP_SLTU, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tNUSE_REG2, \
 `tIMM1_NSEL, `tIMM2_SEL, `tIMM_SEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_RT}

//logical
`define DE__AND \
{`tNBRA, `tNLINK, `ALU_OP_AND, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2, \
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_ZEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_RD}

`define DE__NOR \
{`tNBRA, `tNLINK, `ALU_OP_NOR, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2, \
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_ZEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_RD}

`define DE__OR \
{`tNBRA, `tNLINK, `ALU_OP_OR, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2, \
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_ZEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_RD}

`define DE__XOR \
{`tNBRA, `tNLINK, `ALU_OP_XOR, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2, \
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_ZEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_RD}

`define DE__ANDI \
{`tNBRA, `tNLINK, `ALU_OP_AND, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tNUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_SEL, `tIMM_ZEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_RT}

`define DE__ORI \
{`tNBRA, `tNLINK, `ALU_OP_OR, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tNUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_SEL, `tIMM_ZEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_RT}

`define DE__XORI \
{`tNBRA, `tNLINK, `ALU_OP_XOR, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tNUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_SEL, `tIMM_ZEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_RT}

// LUI (`tNUSE_REG1->`tUSE_REG1, `tIMM2_NSEL->`tIMM2_SEL)
`define DE__LUI \
{`tNBRA, `tNLINK, `ALU_OP_LUI, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tNUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_SEL, `tIMM_ZEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_RT}

`define DE__JR \
{`tJR, `tNLINK, `ALU_OP_NONE, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tNUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_ZEXT,  `LVL_RF_, `tNWE, `tNO_REG, `tD_00}

`define DE__JALR \
{`tJR, `tLINK, `ALU_OP_NONE, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tNUSE_REG2, \
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_ZEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_RD}

`define DE__J \
{`tJMP, `tNLINK, `ALU_OP_NONE, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tNUSE_REG1, `tNUSE_REG2, \
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_ZEXT,  `LVL_RF_, `tNWE, `tNO_REG, `tD_00}

`define DE__JAL \
{`tJMP, `tLINK, `ALU_OP_NONE, `tNOP_MEM, `tNULL, `tMEM_OP_NULL, \
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tNUSE_REG1, `tNUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_ZEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_31}

`define DE__BGEZ \
{`tBRA, `tNLINK, `ALU_OP_GEZ, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tNUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_SEXT,  `LVL_RF_, `tNWE, `tNO_REG, `tD_00}

`define DE__BGEZAL \
{`tBRA, `tLINK, `ALU_OP_GEZ, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tNUSE_REG2, \
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_SEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_31}

`define DE__BLTZ \
{`tBRA, `tNLINK, `ALU_OP_LTZ, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tNUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_SEXT,  `LVL_RF_, `tNWE, `tNO_REG, `tD_00}

`define DE__BLTZAL \
{`tBRA, `tLINK, `ALU_OP_LTZ, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tNUSE_REG2, \
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_SEXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_31}

`define DE__BEQ \
{`tBRA, `tNLINK, `ALU_OP_EQ, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_SEXT,  `LVL_RF_, `tNWE, `tNO_REG, `tD_00}

`define DE__BGTZ \
{`tBRA, `tNLINK, `ALU_OP_GTZ, `tNOP_MEM, `tNULL, `tMEM_OP_NULL, \
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tNUSE_REG2, \
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_SEXT,  `LVL_RF_, `tNWE, `tNO_REG, `tD_00}

`define DE__BLEZ \
{`tBRA, `tNLINK, `ALU_OP_LEZ, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tNUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_SEXT,  `LVL_RF_, `tNWE, `tNO_REG, `tD_00}

`define DE__BNE \
{`tBRA, `tNLINK, `ALU_OP_NEQ, `tNOP_MEM, `tNULL, `tMEM_OP_NULL,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_SEXT,  `LVL_RF_, `tNWE, `tNO_REG, `tD_00}

`define DE__LW \
{`tNBRA, `tNLINK, `ALU_OP_ADDU, `tOP_MEM, `tREAD, `tMEM_OP_WORD,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2, \
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_SEXT,  `LVL_WB_, `tWE, `tGEN_REG, `tD_RT}

`define DE__SW \
{`tNBRA, `tNLINK, `ALU_OP_ADDU, `tOP_MEM, `tWRITE, `tMEM_OP_WORD,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_SEXT,  `LVL_RF_, `tNWE, `tNO_REG, `tD_00}

`define DE__LB \
{`tNBRA, `tNLINK, `ALU_OP_ADDU, `tOP_MEM, `tREAD, `tMEM_OP_BYTE, \
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_SEXT,  `LVL_WB_, `tWE, `tGEN_REG, `tD_RT}

`define DE__LH \
{`tNBRA, `tNLINK, `ALU_OP_ADDU, `tOP_MEM, `tREAD, `tMEM_OP_HWORD,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_SEXT,  `LVL_WB_, `tWE, `tGEN_REG, `tD_RT}

//`define DE__LWL {`tNBRA, `tNLINK, `ALU_OP_ADDU, `tOP_MEM, `tREAD, `tMEM_OP_WL, `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2, `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_EXT,  `LVL_WB_, `tWE, `tGEN_REG, `tD_RT}// LWL

`define DE__LBU \
{`tNBRA, `tNLINK, `ALU_OP_ADDU, `tOP_MEM, `tREAD, `tMEM_OP_BYTEU,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_SEXT,  `LVL_WB_, `tWE, `tGEN_REG, `tD_RT}

`define DE__LHU \
{`tNBRA, `tNLINK, `ALU_OP_ADDU, `tOP_MEM, `tREAD, `tMEM_OP_HWORDU,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_SEXT,  `LVL_WB_, `tWE, `tGEN_REG, `tD_RT}

//`define DE__LWR     {`tNBRA, `tNLINK, `ALU_OP_ADDU, `tOP_MEM, `tREAD, `tMEM_OP_WR, `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2, `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_EXT,  `LVL_WB_, `tWE, `tGEN_REG, `tD_RT}// LWR

`define DE__SB \
{`tNBRA, `tNLINK, `ALU_OP_ADDU, `tOP_MEM, `tWRITE, `tMEM_OP_BYTE,\
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_SEXT,  `LVL_RF_, `tNWE, `tNO_REG, `tD_00}

`define DE__SH \
{`tNBRA, `tNLINK, `ALU_OP_ADDU, `tOP_MEM, `tWRITE, `tMEM_OP_HWORD, \
 `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2,\
 `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_SEXT,  `LVL_RF_, `tNWE, `tNO_REG, `tD_00}

//`define DE__SWL {`tNBRA, `tNLINK, `ALU_OP_ADDU, `tOP_MEM, `tWRITE, `tMEM_OP_WL, `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2, `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_EXT,  `LVL_RF_, `tNWE, `tNO_REG, `tD_00}// SWL

//`define DE__SWR     {`tNBRA, `tNLINK, `ALU_OP_ADDU, `tOP_MEM, `tWRITE, `tMEM_OP_WR, `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tUSE_REG2, `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_EXT,  `LVL_RF_, `tNWE, `tNO_REG, `tD_00}// SWR

//interrupt
//`define DE__SYSCALL {`tNBRA, `tNLINK, `ALU_OP_NONE, `tNOP_MEM, `tNULL, `tMEM_OP_NULL, `tEXC_SYSCALL, `tGEN_REG, `tGEN_REG, `tNUSE_REG1, `tNUSE_REG2, `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_EXT,  `LVL_RF_, `tNWE, `tNO_REG, `tD_00}// SYSCALL
//`define DE__BREAK   {`tNBRA, `tNLINK, `ALU_OP_NONE, `tNOP_MEM, `tNULL, `tMEM_OP_NULL, `tEXC_BREAK, `tGEN_REG, `tGEN_REG, `tNUSE_REG1, `tNUSE_REG2, `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_EXT,  `LVL_RF_, `tNWE, `tNO_REG, `tD_00}// BREAK
//cop0
//`define DE__COP0    {`tNBRA, `tNLINK, `ALU_OP_NONE, `tNOP_MEM, `tNULL, `tMEM_OP_NULL, `tEXC_COP0, `tGEN_REG, `tGEN_REG, `tNUSE_REG1, `tNUSE_REG2, `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_EXT,  `LVL_RF_, `tNWE, `tNO_REG, `tD_00}// COP0
//`define DE__MFC0    {`tNBRA, `tNLINK, `ALU_OP_OP2, `tNOP_MEM, `tNULL, `tMEM_OP_NULL, `tEXC_NONE, `tGEN_REG, `tCOP_REG, `tNUSE_REG1, `tUSE_REG2, `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_EXT,  `LVL_EX_, `tWE, `tGEN_REG, `tD_RD}// MFC0
//`define DE__MTC0    {`tNBRA, `tNLINK, `ALU_OP_OP2, `tNOP_MEM, `tNULL, `tMEM_OP_NULL, `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tNUSE_REG1, `tUSE_REG2, `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_EXT,  `LVL_EX_, `tWE, `tCOP_REG, `tD_RD}// MTC0
//`define DE__SWC0    {`tNBRA, `tNLINK, `ALU_OP_OP2, `tOP_MEM, `tWRITE, `tMEM_OP_NULL, `tEXC_NONE, `tGEN_REG, `tCOP_REG, `tUSE_REG1, `tUSE_REG2, `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_EXT,  `LVL_RF_, `tNWE, `tNO_REG, `tD_00}// SWC0
//`define DE__LWC0    {`tNBRA, `tNLINK, `ALU_OP_NONE, `tOP_MEM, `tREAD, `tMEM_OP_NULL, `tEXC_NONE, `tGEN_REG, `tGEN_REG, `tUSE_REG1, `tNUSE_REG2, `tIMM1_NSEL, `tIMM2_NSEL, `tIMM_EXT,  `LVL_WB_, `tWE, `tCOP_REG, `tD_RT}// LWC0

//totally 62 instructions mips1's 60 and the two instruction MTC0,MFC0

`define INST_DE_WIDTH_ (3+1+`ALU_CTRL_WIDTH+1+1+7+`EXC_TYPE_WIDTH+1+1+1+1+1+1+1+`LEVEL_TYPE_WIDTH+1+1+2)



