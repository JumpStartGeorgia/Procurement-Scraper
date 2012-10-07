if (gon.tender_pie_chart)
	{
    var w = 220,
    h = 125,
    r = 60;

    var vis = d3.select("div#tender_piechart")
        .append("svg:svg")
					.attr("id", "tender_chart")
        .data([gon.gender_pie_data])
		      .attr("width", w)
		      .attr("height", h)
					.attr("x", 5) // for placement when exporting svg
					.attr("y", 50) // for placement when exporting svg
        .append("svg:g")
          .attr("transform", "translate(" + (+ r + 51) + "," + r + ")")



    var svg = d3.select("div#tender_piechart svg")
        .append("svg:circle")
		      .attr("cx", 18.64)
		      .attr("cy", 25.952)
					.attr("fill", '#4e6e9a')
					.attr("r", 4.86);

		svg = d3.select("div#tender_piechart svg")
        .append("svg:circle")
		      .attr("cx", 150.827)
		      .attr("cy", 25.954)
					.attr("fill", '#c63860')
					.attr("r", 4.862)
					.attr("transform", 'translate(55.743846,0.04603201)');

    var arc = d3.svg.arc()
        .outerRadius(r);

    var pie = d3.layout.pie()
        .value(function(d) { return d.value; });

    var arcs = vis.selectAll("g.slice")
        .data(pie)
        .enter()
          .append("svg:g")
            .attr("class", "slice");
        arcs.append("svg:path")
          .attr("fill", function(d, i) { return gon.tender_pie_chart[i].color } )
          .attr("d", arc);

        arcs.append("svg:text")
          .attr("transform", function(d) {
		        d.innerRadius = 0;
		        d.outerRadius = r;
		        return "translate(" + arc.centroid(d) + ")";
          })
          .attr("text-anchor", "middle")
          .attr("style", "fill: #fff;")
          .text(function(d, i) { return gon.tender_pie_chart[i].label; });

  }
