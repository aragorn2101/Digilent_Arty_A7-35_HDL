# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a35ticsg324-1L

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/aragorn/Documents/FPGA/colour_chooser2_vhd/colour_chooser2_vhd.cache/wt [current_project]
set_property parent.project_path /home/aragorn/Documents/FPGA/colour_chooser2_vhd/colour_chooser2_vhd.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part_repo_paths /home/aragorn/Digilent_Board_files_for_Vivado [current_project]
set_property board_part digilentinc.com:arty-a7-35:part0:1.0 [current_project]
set_property ip_output_repo /home/aragorn/Documents/FPGA/colour_chooser2_vhd/colour_chooser2_vhd.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  /home/aragorn/Documents/FPGA/colour_chooser2_vhd/colour_chooser2_vhd.srcs/sources_1/imports/FPGA/PWMLED.vhd
  /home/aragorn/Documents/FPGA/colour_chooser2_vhd/colour_chooser2_vhd.srcs/sources_1/imports/FPGA/debounce.vhd
  /home/aragorn/Documents/FPGA/colour_chooser2_vhd/colour_chooser2_vhd.srcs/sources_1/new/main.vhd
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/aragorn/Documents/FPGA/colour_chooser2_vhd/colour_chooser2_vhd.srcs/constrs_1/imports/Digilent_XDC/Arty-A7-35-Master.xdc
set_property used_in_implementation false [get_files /home/aragorn/Documents/FPGA/colour_chooser2_vhd/colour_chooser2_vhd.srcs/constrs_1/imports/Digilent_XDC/Arty-A7-35-Master.xdc]

set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top main -part xc7a35ticsg324-1L


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef main.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file main_utilization_synth.rpt -pb main_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]