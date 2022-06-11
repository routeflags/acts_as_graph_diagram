// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import * as d3 from "d3";

// See Force layout | D3 in Depth https://www.d3indepth.com/force-layout/

const svg = d3.select("svg"),
  width = +svg.attr("width"),
  height = +svg.attr("height");

const simulation = d3.forceSimulation()
  .force("link", d3.forceLink()
    .id(function (d) {
      return d.id;
    }))
  .force("charge", d3.forceManyBody())
  .force("center", d3.forceCenter(width / 2, height / 2));

d3.json("http://127.0.0.1:3000/data_network").then(function (graph) {
  const link = svg
    .append("g")
    .attr("class", "links")
    .selectAll("line")
    .data(graph.links)
    .enter()
    .append("line")
    .style("stroke", "#aaa");

  const node = svg
    .append("g")
    .attr("class", "nodes")
    .selectAll("circle")
    .data(graph.nodes)
    .enter()
    .append("circle")
    .attr("r", 6)

  const label = svg
    .append("g")
    .attr("class", "labels")
    .selectAll("text")
    .data(graph.nodes)
    .enter()
    .append("text")
    .attr("class", "label")
    .text(function (d) {
      return d.name;
    });

  simulation
    .nodes(graph.nodes)
    .on("tick", ticked);

  simulation.force("link")
    .links(graph.links);

  function ticked() {
    link
      .attr("x1", function (d) {
        return d.source.x;
      })
      .attr("y1", function (d) {
        return d.source.y;
      })
      .attr("x2", function (d) {
        return d.target.x;
      })
      .attr("y2", function (d) {
        return d.target.y;
      });

    node
      .attr("cx", function (d) {
        return d.x;
      })
      .attr("cy", function (d) {
        return d.y;
      });

    label
      .attr("x", function (d) {
        return d.x + 8;
      })
      .attr("y", function (d) {
        return d.y + 3;
      });
  }
});