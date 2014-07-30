import logging
from glfw import *
import OpenGL
from OpenGL.GL import *

import nanovg as nvg

# create logger for the context of this function
logger = logging.getLogger(__name__)


def basic_gl_setup():
    glEnable( GL_POINT_SPRITE )
    glEnable(GL_VERTEX_PROGRAM_POINT_SIZE) # overwrite pointsize
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
    glEnable(GL_BLEND)
    glClearColor(0., 0., 0., 1.0)

def adjust_gl_view(w,h,window):
    """
    adjust view onto our scene.
    """
    h = max(h,1)
    w = max(w,1)

    hdpi_factor = glfwGetFramebufferSize(window)[0]/glfwGetWindowSize(window)[0]
    w,h = w*hdpi_factor,h*hdpi_factor
    glViewport(0, 0, w, h)

def clear_gl_screen():
    glClearColor(0.7, 0.7, 0.7, 1.0)
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT|GL_STENCIL_BUFFER_BIT)


def demo():
    global quit
    quit = False

    # Callback functions
    def on_resize(window,w, h):
        active_window = glfwGetCurrentContext()
        glfwMakeContextCurrent(window)
        # norm_size = normalize((w,h),glfwGetWindowSize(window))
        # fb_size = denormalize(norm_size,glfwGetFramebufferSize(window))
        adjust_gl_view(w,h,window)
        glfwMakeContextCurrent(active_window)

    def on_iconify(window,iconfied):
        pass

    def on_key(window, key, scancode, action, mods):
        # print "key pressed: ", key
        if action == GLFW_PRESS:
            if key == GLFW_KEY_ESCAPE:
                on_close(window)

    def on_char(window,char):
        pass

    def on_button(window,button, action, mods):
        pos = glfwGetCursorPos(window)
        # pos = normalize(pos,glfwGetWindowSize(window))
        # pos = denormalize(pos,(frame.img.shape[1],frame.img.shape[0]) ) # Position in img pixels

    def on_pos(window,x, y):
        pass

    def on_scroll(window,x,y):
        pass

    def on_close(window):
        global quit
        quit = True
        logger.info('Process closing from window')


    def draw_lines(x, y, w):
        for i in range(60):
            sw = (i+0.5)*.1
            vg.strokeWidth(sw)
            vg.beginPath()
            vg.moveTo(x,y)
            vg.lineTo(x+1000.,y)
            vg.stroke()
            y += 10.

    def draw_bezier():
        pass

    # get glfw started
    glfwInit()
    width, height = (1000,600)
    window = glfwCreateWindow(width, height, "NanoVG Demo", None, None)
    glfwSetWindowPos(window,0,0)

    # Register callbacks window
    glfwSetWindowSizeCallback(window,on_resize)
    glfwSetWindowCloseCallback(window,on_close)
    glfwSetWindowIconifyCallback(window,on_iconify)
    glfwSetKeyCallback(window,on_key)
    glfwSetCharCallback(window,on_char)
    glfwSetMouseButtonCallback(window,on_button)
    glfwSetCursorPosCallback(window,on_pos)
    glfwSetScrollCallback(window,on_scroll)


    # glfwMakeContextCurrent(window)
    basic_gl_setup()

    glfwSwapInterval(0)
    glfwMakeContextCurrent(window)

    vg = nvg.Context()
    roboto_light = vg.createFont("light", "../nanovg/example/Roboto-Light.ttf")
    roboto_regular = vg.createFont("regular", "../nanovg/example/Roboto-Regular.ttf")
    roboto_bold = vg.createFont("bold", "../nanovg/example/Roboto-Bold.ttf")

    img = vg.createImage("../nanovg/example/images/image2.jpg", 0)

    while not quit:
        clear_gl_screen()
        # show some nanovg graphics

        vg.beginFrame(width, height, float(width)/float(height))
        draw_lines(0.,0.,100.)

        # res = vg.textBounds(0.0, 0.0, "here is my text", "t")
        # vg.save()
        # draw rect
        p = vg.linearGradient(0.0, 0.0, 1000.0, 600.0, nvg.colorRGBAf(0.0,0.0,1.0,1.0), nvg.colorRGBAf(0.,1.,0.2,0.5))
        # rg = vg.radialGradient(0.0, 0.0, 100.0, 120.0, nvg.colorRGBAf(0.0,0.0,1.0,1.0), nvg.colorRGBAf(0.,1.,0.2,0.5))
        vg.beginPath()
        # vg.fillColor(nvg.colorRGBAf(0.2,0.2,0.2,0.4))
        vg.roundedRect(10.0, 10.0, 490.0, 290.0, 5.0)

        vg.fillPaint(p)
        vg.fill()

        rg = vg.linearGradient(500.0, 300.0, 100.0, 200.0, nvg.colorRGBAf(0.0,0.0,0.0,0.0), nvg.colorRGBAf(0.,1.,0.2,0.5))
        vg.beginPath()
        vg.fillPaint(rg)
        vg.strokeColor(nvg.colorRGBAf(0.0,0.4,0.7,0.9))
        vg.strokeWidth(2.0)
        vg.circle(500.0, 300., 80.0)
        vg.fill()
        vg.stroke()

        # test font rendering
        txt = "Testing font rendering with Python NanoVG bindings."
        # print vg.textBounds(0,0,txt)
        # print vg.textMetrics(1.)
        # print vg.textBreakLines(txt)

        vg.fontFace("bold")
        vg.fontSize(24.0)
        vg.fillColor(nvg.colorRGBAf(0.,0.,0.,1.))
        vg.text(15.0, 30.0, txt)

        vg.fontFace("regular")
        vg.fillColor(nvg.colorRGBAf(1.,1.,1.,1.))
        vg.text(15.0, 50.0, txt)

        vg.fontFace("light")
        vg.fillColor(nvg.colorRGBAf(0.,1.,0.2,1.))
        vg.text(15.0, 70.0, txt)

        vg.endFrame()
        vg.restore()
        glfwSwapBuffers(window)
        glfwPollEvents()

    vg.reset()
    glfwDestroyWindow(window)
    glfwTerminate()
    logger.debug("Process done")

if __name__ == '__main__':
    demo()

