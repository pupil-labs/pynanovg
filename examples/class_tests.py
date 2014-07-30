import numpy as np
import nanovg as nvg

xform = [0.0232,1.23,2.230088032,3.238023,4.23080832,5.290823]
extent = [0.,302.2]
c1 = nvg.Color()
c2 = nvg.Color(0.5, 0.5, 0.253, 0.0001)
p = nvg.Paint(0.32, 0.325, c1, c2, 1, 2)

# print "xform: ", p.xform
# print "extent: ", p.extent
# print "radius: ", p.radius
# print "feather: ", p.feather
# print "innerColor: ", p.innerColor
# print "outerColor: ", p.outerColor
# print "image: ", p.image
# print "repeat: ", p.repeat
print p.struct
print c1.struct