# Active-HDL design settings
set dsnname Sdram_TB
set dsn $curdir
log $dsn/log/vsimsa.log
alib Sdram_TB.lib
set worklib Sdram_TB
# end of Active-HDL design settings

cd $dsn
alog -v2k -dbg i:/CSCE611/mips_sram_s3/sim_src/board/multi_sdram/command.v
alog -v2k -dbg i:/CSCE611/mips_sram_s3/sim_src/board/multi_sdram/control_interface.v
alog -v2k -dbg i:/CSCE611/mips_sram_s3/sim_src/board/multi_sdram/mt48lc8m16a2.v
alog -v2k -dbg i:/CSCE611/mips_sram_s3/sim_src/board/multi_sdram/multi_sdram.v
alog -v2k -dbg i:/CSCE611/mips_sram_s3/sim_src/board/multi_sdram/sdr_data_path.v
alog -v2k -dbg i:/CSCE611/mips_sram_s3/sim_src/board/multi_sdram/sdram_controller.v
alog -v2k -dbg i:/CSCE611/mips_sram_s3/sim_src/board/multi_sdram/sdram_multiplexer.v
alog -v2k -dbg "i:/CSCE611/mips_sram_s3/sim_src/board/multi_sdram/sdram_tb.v"
