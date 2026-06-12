program clock_test (clock_if.TB vif);
covergroup cg @(posedge vif.clk);
cp_rst : coverpoint vif.rst {
bins asserted = {1};
bins deasserted = {0};
bins toggle = (0 => 1), (1 => 0);
}
cp_sec : coverpoint vif.sec {
bins sec_vals[] = {[0:59]};
bins sec_rollover = (59 => 0);
}
cp_min : coverpoint vif.min {
bins min_vals[] = {[0:59]};
bins min_rollover = (59 => 0);
}
cross cp_sec, cp_min ;
endgroup
cg coverage_inst=new();
property sec_limit;
@(posedge vif.clk)
disable iff(vif.rst)
vif.sec <= 6'd59;
endproperty
property min_limit;
@(posedge vif.clk)
disable iff(vif.rst)
vif.min<=6'd59;
endproperty
assert property(sec_limit)
else $error("seconds exceeded 59!");
assert property(min_limit)
else $error("minutes exceeded 59!");
initial begin
vif.rst = 1;
repeat(2) @(posedge vif.clk);
vif.rst = 0;
repeat(4200) @(posedge vif.clk);
vif.rst = 1;
repeat(2) @(posedge vif.clk);
$display("simulation completed successfully");
$display("Coverage = %0.2f%%",
coverage_inst.get_inst_coverage());
$finish;
end
endprogram
