set_property ALLOW_COMBINATORIAL_LOOPS true [get_nets q]
set_property ALLOW_COMBINATORIAL_LOOPS true [get_nets q_OBUF]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_IBUF]

set_property IOSTANDARD LVCMOS18 [get_ports q[1]]
set_property IOSTANDARD LVCMOS18 [get_ports q[0]]
set_property IOSTANDARD LVCMOS18 [get_ports clk]

set_property PACKAGE_PIN F15 [get_ports q[1]]
set_property PACKAGE_PIN F13 [get_ports q[0]]
set_property PACKAGE_PIN J4 [get_ports clk]