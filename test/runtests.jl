# using Test
using DataAndPlotting

# filename = "array.h5"

# arr = initialize()
# rm(filename, force = true)
# output(arr,"../temp/array2.h5")

# arr2 = input("../temp/array2.h5")

# @test isequal(arr2,arr)

plotname = "array.plot"
arr = initialize()
makeplot(arr, plotname)
