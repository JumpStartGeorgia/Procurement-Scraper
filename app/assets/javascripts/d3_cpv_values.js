if (gon.top_cpv_estimated_values){
var w = 400,
    h = 260,
    labelpad = 10,
    x = d3.scale.linear().domain([0, d3.max(gon.top_cpv_estimated_values, function(d) {return d.sum_value;})]).range([0, w]),
    y = d3.scale.ordinal().domain(d3.range(gon.top_cpv_estimated_values.length)).rangeBands([0, h], .2);

var vis = d3.select("#top_cpv_estimated_values_barchart")
  .append("svg:svg")
    .attr("width", w + 100)
    .attr("height", h + 20)
  .append("svg:g")
    .attr("transform", "translate(75,0)");

var bars = vis.selectAll("g.bar")
    .data(gon.top_cpv_estimated_values)
  .enter().append("svg:g")
    .attr("class", "bar")
    .attr("transform", function(d, i) { return "translate(" + labelpad + "," + y(i) + ")"; });

bars.append("svg:rect")
    .attr("fill", "#666" )
    .attr("width", function(d, i) { return gon.top_cpv_estimated_values[i].sum_value * w / 300000; })
    .attr("height", y.rangeBand());

bars.append("svg:text")
    .attr("x", function(d, i) { return gon.top_cpv_estimated_values[i].sum_value * w / 300000; })
    .attr("y", y.rangeBand())
    .attr("dx", -3)
    .attr("dy", "-0.50em")
    .attr("text-anchor", "end")
		.style("fill", "white")
    .text(function(d, i) { return gon.top_cpv_estimated_values[i].sum_formatted_value; });

bars.append("svg:text")
    .attr("x", 0)
    .attr("y", 10 + y.rangeBand() / 2)
    .attr("dx", -6)
    .attr("dy", "-0.45em")
    .attr("text-anchor", "end")
    .text(function(d, i)  {return gon.top_cpv_estimated_values[i].cpv_number; });


var rules = vis.selectAll("g.rule")
    .data(x.ticks(7))
  .enter().append("svg:g")
    .attr("class", "rule")
    .attr("transform", function(d) { return "translate(" + x(d) + ", 0)"; });

rules.append("svg:line")
    .attr("y1", 0)
    .attr("y2", h)
    .attr("x1", labelpad)
    .attr("x2", labelpad)
    .attr("stroke", "black")
    .attr("stroke-opacity", .3);


rules.append("svg:text")
    .attr("y", h + 8)
    .attr("x", labelpad)
    .attr("dy", ".61em")
    .attr("text-anchor", "middle")
    .text(x.tickFormat(1));


}
