from nanovg import vg,colorRGBAf

def draw():

    # test font rendering
    txt = "Hello World - From submodule"
    # print vg.textBounds(0,0,txt)
    # print vg.textMetrics(1.)
    # print vg.textBreakLines(txt)

    vg.fontFace("light")
    vg.fontSize(24.0)
    vg.fillColor(colorRGBAf(1.,0.,1.,1.))
    vg.text(15.0, 230.0, txt)
