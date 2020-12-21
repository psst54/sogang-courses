set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {CLK_IBUF}]

set_property IOSTANDARD LVCMOS18 [get_ports J]
set_property IOSTANDARD LVCMOS18 [get_ports K]
set_property IOSTANDARD LVCMOS18 [get_ports CLK]
set_property IOSTANDARD LVCMOS18 [get_ports Q]
set_property IOSTANDARD LVCMOS18 [get_ports Qc]

set_property PACKAGE_PIN J4 [get_ports J]
set_property PACKAGE_PIN L3 [get_ports K]
set_property PACKAGE_PIN K3 [get_ports CLK]
set_property PACKAGE_PIN F15 [get_ports Q]
set_property PACKAGE_PIN F13 [get_ports Qc]
