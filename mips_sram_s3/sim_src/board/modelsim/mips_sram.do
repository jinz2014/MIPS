# design path
set PATH      "C:/Users/Jin/Desktop/CSCE611/mips_sram_s3"

# Altera project 
set FPGA_PATH "$PATH/proj"

# simulation source files
set SRC_PATH  "$PATH/sim_src"

# top-level memory module
set MEM_PATH  "$SRC_PATH/memory"

# processor hdl
set PROC_PATH "$SRC_PATH/rtl"

# processor and memory parameters and defines
set INC_PATH  "$SRC_PATH/include"

# top-level testbench
set TEST_PATH "$SRC_PATH/testbench/"

# precompiled Altera sim lib
set LIB_PATH  "C:/altera/qshare/verilog_libs"

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}

vlib rtl_work
vmap work rtl_work
vmap altera_mf_ver $LIB_PATH/altera_mf_ver
vmap cycloneii_ver $LIB_PATH/cycloneii_ver
vmap lpm_ver       $LIB_PATH/lpm_ver

#--------------------------------------------------------- 
# single-cycle processor sources
#--------------------------------------------------------- 

vlog -work work +incdir+$INC_PATH $TEST_PATH/TestBench.v +libext+.v \
      -y $INC_PATH -y $PROC_PATH -y $FPGA_PATH -y $MEM_PATH

#vsim -L altera_mf_ver -L cycloneii_ver -L lpm_ver -t ns -voptargs=+acc work.TestBench
vsim -L altera_mf_ver -t ns -voptargs=+acc work.TestBench

# add wave 
#source mips_wave.do
