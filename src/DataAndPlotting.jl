module DataAndPlotting
using HDF5
using Plots

const ki = 3
const kj = 3

const ni = 30
const nj = 20

function index2coord(i,ni)
  @assert ni > 1
  @assert 1 <= i <= ni
  (i-1)/(ni-1)
end

#set up standing wave
export initialize
function initialize()
  arr = zeros(Float64, ni, nj)
  for j in 1:nj, i in 1:ni
  x = index2coord(i,ni)
  y = index2coord(j,nj)
  arr[i,j] = sin(2*pi*ki*x)*sin(2*pi*kj*y)
  end
  arr
end

#write data to file
export output
function output(arr::Array{Float64,2},filename::String)
  h5write(filename,"data",arr)
end

# Read data from file
export input
function input(filename::String)
  arr = h5read(filename,"data") # , (i:ni, j:nj)
end

export makeplot
function makeplot(arr::Array{Float64,2})
  x = range(0, stop = 1, length = ni)
  y = range(0, stop = 1, length = nj)
  # p = plot((x,y,arr, st = [:surface, :contourf]))
  data = [["z"=>arr, "type"=>"surface"]]
  layout = [
  "title" => "Random Stuff",
  "autosize" => false,
  "width" => 500,
  "height" => 500,
  "margin" => [
    "l" => 65,
    "r" => 50,
    "b" => 65,
    "t" => 90]]
    response = Plotly.plot(data, ["layout" => layout, "filename" => "elevations-3d-surface", "fileopt" => "overwrite"])
end

export makeplot2
function makeplot2(arr::Array{Float64,2}, filename::String)
  heatmap(arr, clim = (-1.0,1.0), color=:viridis)
  savefig(filename)
end






end # module
