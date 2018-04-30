@echo off
set xv_path=D:\\vivado\\vivadofile\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto 625fc68662504d3589edfbce46f3d659 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L xpm -L blk_mem_gen_v8_3_3 -L unisims_ver -L unimacro_ver -L secureip --snapshot test_behav xil_defaultlib.test xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
