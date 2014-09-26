cdef extern from 'gl.h':
    # include gl header for nanovg source.
    pass

cdef extern from "../nanovg/src/nanovg.h":
    ctypedef struct NVGcontext:
        pass

    ctypedef struct NVGcolor:
        float r,g,b,a

    ctypedef struct NVGpaint:
        # float xform[6]
        # float extent[2]
        float radius
        float feather
        NVGcolor innerColor
        NVGcolor outerColor
        int image
        int repeat

    cdef enum NVGwinding:
        NVG_CCW = 1
        NVG_CW = 2

    cdef enum NVGsolidity:
        NVG_SOLID = 1
        NVG_HOLE = 2

    cdef enum NVGlineCap:
        NVG_BUTT
        NVG_ROUND
        NVG_SQUARE
        NVG_BEVEL
        NVG_MITER

    cdef enum NVGpatternRepeat:
        NVG_NOREPEAT = 0
        NVG_REPEATX = 0x01
        NVG_REPEATY = 0x02

    cdef enum NVGalign:
        NVG_ALIGN_LEFT      = 1<<0,
        NVG_ALIGN_CENTER    = 1<<1,
        NVG_ALIGN_RIGHT     = 1<<2,
        NVG_ALIGN_TOP       = 1<<3,
        NVG_ALIGN_MIDDLE    = 1<<4,
        NVG_ALIGN_BOTTOM    = 1<<5,
        NVG_ALIGN_BASELINE  = 1<<6,

    ctypedef struct NVGglyphPosition:
        const char* s
        float x
        float minx, maxx

    ctypedef struct NVGtextRow:
        const char* start
        const char* end
        const char* next
        float width
        float minx, maxx

    cdef enum NVGimage:
        NVG_IMAGE_GENERATE_MIPMAPS = 1 << 0


    void nvgBeginFrame(NVGcontext* ctx, int windowWidth, int windowHeight, float devicePixelRatio)
    void nvgEndFrame(NVGcontext* ctx)

    # color
    NVGcolor nvgRGBAf(float r, float g, float b, float a)
    NVGcolor nvgRGBA(float r, float g, float b, float a)
    NVGcolor nvgLerpRGBA(NVGcolor c0, NVGcolor c1, float u)
    NVGcolor nvgHSLA(float h, float s, float l, unsigned char a)

    # context state
    void nvgSave(NVGcontext* ctx)
    void nvgRestore(NVGcontext* ctx)
    void nvgReset(NVGcontext* ctx)

    # fill/stroke
    void nvgStrokeColor(NVGcontext* ctx, NVGcolor color)
    void nvgStrokePaint(NVGcontext* ctx, NVGpaint paint)

    void nvgFillColor(NVGcontext* ctx, NVGcolor color)
    void nvgFillPaint(NVGcontext* ctx, NVGpaint paint)

    void nvgMiterLimit(NVGcontext* ctx, float limit)
    void nvgStrokeWidth(NVGcontext* ctx, float size)
    void nvgLineCap(NVGcontext* ctx, int cap)
    void nvgLineJoin(NVGcontext* ctx, int join)

    void nvgGlobalAlpha(NVGcontext* ctx, float alpha)

    # transformations
    void nvgResetTransform(NVGcontext* ctx)
    void nvgTransform(NVGcontext* ctx, float a, float b, float c, float d, float e, float f)
    void nvgTranslate(NVGcontext* ctx, float x, float y)
    void nvgRotate(NVGcontext* ctx, float angle)
    void nvgSkewX(NVGcontext* ctx, float angle)
    void nvgSkewY(NVGcontext* ctx, float angle)
    void nvgScale(NVGcontext* ctx, float x, float y)
    void nvgCurrentTransform(NVGcontext* ctx, float* xform)
    void nvgTransformIdentity(float* dst)
    void nvgTransformTranslate(float* dst, float tx, float ty)
    void nvgTransformScale(float* dst, float sx, float sy)
    void nvgTransformRotate(float* dst, float a)
    void nvgTransformSkewX(float* dst, float a)
    void nvgTransformSkewY(float* dst, float a)
    void nvgTransformMultiply(float* dst, const float* src)
    void nvgTransformPremultiply(float* dst, const float* src)
    int nvgTransformInverse(float* dst, const float* src)
    void nvgTransformPoint(float* dstx, float* dsty, const float* xform, float srcx, float srcy)

    # angular conversions
    float nvgDegToRad(float deg)
    float nvgRadToDeg(float rad)

    # image
    int nvgCreateImage(NVGcontext* ctx, const char* filename, int imageFlags)
    int nvgCreateImageMem(NVGcontext* ctx, int imageFlags, unsigned char* data, int ndata)
    int nvgCreateImageRGBA(NVGcontext* ctx, int w, int h, int imageFlags, const unsigned char* data)
    void nvgUpdateImage(NVGcontext* ctx, int image, const unsigned char* data)
    void nvgImageSize(NVGcontext* ctx, int image, int* w, int* h)
    void nvgDeleteImage(NVGcontext* ctx, int image)

    # gradients
    NVGpaint nvgLinearGradient(NVGcontext* ctx, float sx, float sy, float ex, float ey, NVGcolor icol, NVGcolor ocol)
    NVGpaint nvgBoxGradient(NVGcontext* ctx, float x, float y, float w, float h, float r, float f, NVGcolor icol, NVGcolor ocol)
    NVGpaint nvgRadialGradient(NVGcontext* ctx, float cx, float cy, float inr, float outr, NVGcolor icol, NVGcolor ocol)
    NVGpaint nvgImagePattern(NVGcontext* ctx, float ox, float oy, float ex, float ey, float angle, int image, int repeat, float alpha)


    void nvgScissor(NVGcontext* ctx, float x, float y, float w, float h)
    void nvgIntersectScissor(NVGcontext* ctx, float x, float y, float w, float h)
    void nvgResetScissor(NVGcontext* ctx)

    # lines, arcs, ellipse, rectangles
    void nvgBeginPath(NVGcontext* ctx)
    void nvgMoveTo(NVGcontext* ctx, float x, float y)
    void nvgLineTo(NVGcontext* ctx, float x, float y)
    void nvgBezierTo(NVGcontext* ctx, float c1x, float c1y, float c2x, float c2y, float x, float y)
    void nvgQuadTo(NVGcontext* ctx, float cx, float cy, float x, float y)
    void nvgArcTo(NVGcontext* ctx, float x1, float y1, float x2, float y2, float radius)
    void nvgClosePath(NVGcontext* ctx)
    void nvgPathWinding(NVGcontext* ctx, int dir)
    void nvgArc(NVGcontext* ctx, float cx, float cy, float r, float a0, float a1, int dir)
    void nvgRect(NVGcontext* ctx, float x, float y, float w, float h)
    void nvgRoundedRect(NVGcontext* ctx, float x, float y, float w, float h, float r)
    void nvgEllipse(NVGcontext* ctx, float cx, float cy, float rx, float ry)
    void nvgCircle(NVGcontext* ctx, float cx, float cy, float r)

    void nvgFill(NVGcontext* ctx)
    void nvgStroke(NVGcontext* ctx)

    # fonts
    int nvgCreateFont(NVGcontext* ctx, const char* name, const char* filename)
    int nvgCreateFontMem(NVGcontext* ctx, const char* name, unsigned char* data, int ndata, int freeData)
    int nvgFindFont(NVGcontext* ctx, const char* name)
    void nvgFontSize(NVGcontext* ctx, float size)
    void nvgFontBlur(NVGcontext* ctx, float blur)
    void nvgTextLetterSpacing(NVGcontext* ctx, float spacing)
    void nvgTextLineHeight(NVGcontext* ctx, float lineHeight)
    void nvgTextAlign(NVGcontext* ctx, int align)
    void nvgFontFaceId(NVGcontext* ctx, int font)
    void nvgFontFace(NVGcontext* ctx, const char* font)
    float nvgText(NVGcontext* ctx, float x, float y, const char* string, const char* end)
    void nvgTextBox(NVGcontext* ctx, float x, float y, float breakRowWidth, const char* string, const char* end)
    float nvgTextBounds(NVGcontext* ctx, float x, float y, const char* string, const char* end, float* bounds)
    void nvgTextBoxBounds(NVGcontext* ctx, float x, float y, float breakRowWidth, const char* string, const char* end, float* bounds)
    int nvgTextGlyphPositions(NVGcontext* ctx, float x, float y, const char* string, const char* end, NVGglyphPosition* positions, int maxPositions)
    void nvgTextMetrics(NVGcontext* ctx, float* ascender, float* descender, float* lineh)
    int nvgTextBreakLines(NVGcontext* ctx, const char* string, const char* end, float breakRowWidth, NVGtextRow* rows, int maxRows)

    cdef enum NVGtexture:
        NVG_TEXTURE_ALPHA = 0x01,
        NVG_TEXTURE_RGBA = 0x02,

    ctypedef struct NVGscissor:
        float xform[6]
        float extent[2]

    ctypedef struct NVGvertex:
        float x,y,u,v

    ctypedef struct NVGpath:
        int first
        int count
        unsigned char closed
        int nbevel
        NVGvertex* fill
        int nfill
        NVGvertex* stroke
        int nstroke
        int winding
        int convex

    ctypedef struct NVGparams:
        void* userPtr
        # int edgeAntiAlias
        # int (*renderCreate)(void* uptr)
        # int (*renderCreateTexture)(void* uptr, int type, int w, int h, int imageFlags, const unsigned char* data)
        # int (*renderDeleteTexture)(void* uptr, int image)
        # int (*renderUpdateTexture)(void* uptr, int image, int x, int y, int w, int h, const unsigned char* data)
        # int (*renderGetTextureSize)(void* uptr, int image, int* w, int* h)
        # void (*renderViewport)(void* uptr, int width, int height)
        # void (*renderFlush)(void* uptr)
        # void (*renderFill)(void* uptr, NVGpaint* paint, NVGscissor* scissor, float fringe, const float* bounds, const NVGpath* paths, int npaths)
        # void (*renderStroke)(void* uptr, NVGpaint* paint, NVGscissor* scissor, float fringe, float strokeWidth, const NVGpath* paths, int npaths)
        # void (*renderTriangles)(void* uptr, NVGpaint* paint, NVGscissor* scissor, const NVGvertex* verts, int nverts)
        # void (*renderDelete)(void* uptr)

    NVGcontext* nvgCreateInternal(NVGparams* params)
    void nvgDeleteInternal(NVGcontext* ctx)

    NVGparams* nvgInternalParams(NVGcontext* ctx)

    void nvgDebugDumpPathCache(NVGcontext* ctx)

cdef extern from "../nanovg/src/nanovg_gl.h":

    # NVGcontext* nvgCreateGL3(int flags)
    # void nvgDeleteGL3(NVGcontext* ctx)

    NVGcontext* nvgCreateGL2(int flags)
    void nvgDeleteGL2(NVGcontext* ctx)

    int NVG_ANTIALIAS = 1
    int NVG_STENCIL_STROKES = 2

    ctypedef struct GLNVGcontext:
        pass


cdef extern from '../nanovg/example/perf.h':

    cdef enum GraphrenderStyle:
        GRAPH_RENDER_FPS
        GRAPH_RENDER_MS
        GRAPH_RENDER_PERCENT


    ctypedef struct PerfGraph:
        # pass
        int style
        char name[32]
        float values[100] #do not change! This is set in perf.h and used in perf.c
        int head

    void initGraph(PerfGraph* fps, int style, const char* name)
    void updateGraph(PerfGraph* fps, float frameTime)
    void renderGraph(NVGcontext* vg, float x, float y, PerfGraph* fps)
    float getGraphAverage(PerfGraph* fps)


    cdef struct GPUtimer:
        pass

    void initGPUTimer(GPUtimer* timer)
    void startGPUTimer(GPUtimer* timer)
    int stopGPUTimer(GPUtimer* timer, float* times, int maxTimes)


cdef extern from '../milligui/src/milli2.h':
    cdef enum MImouseButton:
        MI_MOUSE_PRESSED    = 1 << 0
        MI_MOUSE_RELEASED   = 1 << 1

    cdef enum MIoverflow:
        MI_FIT
        MI_HIDDEN
        MI_SCROLL
        MI_VISIBLE

    cdef enum MIdir:
        MI_ROW
        MI_COL

    cdef enum MIalign:
        MI_START
        MI_END
        MI_CENTER
        MI_JUSTIFY

    cdef struct MIrect:
        float x
        float y
        float width
        float height
    
    ctypedef struct MIrect:
        pass 

    ctypedef struct MIpoint:
        float x
        float y

    ctypedef struct MIsize:
        float width
        float height
    
    ctypedef struct MIcolor:
        unsigned char r
        unsigned char g
        unsigned char b
        unsigned char a
    
    cdef enum MIwidgetEvent:
        MI_NONE
        MI_FOCUSED
        MI_BLURRED
        MI_CLICKED
        MI_PRESSED
        MI_RELEASED
        MI_DRAGGED
        MI_ENTERED
        MI_EXITED
        MI_KEYPRESSED
        MI_KEYRELEASED
        MI_CHARTYPED
    

    int MI_MAX_INPUTKEYS = 32
    ctypedef struct MIkeyPress:
        int type
        int code
        int mods
    
    ctypedef struct MIevent:
        int type
        float mx
        float my
        float deltamx
        float deltamy
        int mbut
        int key
    

    ctypedef struct MIinputState:
        float mx
        float my
        int mbut
        MIkeyPress keys[32]
        int nkeys  
    
    float MI_FIT = -1.0

    ctypedef struct MIpopupState:
        int visible
        int visited
        int logic
        MIrect rect
    
    ctypedef struct MIcanvasState:
        MIrect rect
    
    ctypedef unsigned int MIhandle

    cdef enum MIfontFace:
        MI_FONT_NORMAL
        MI_FONT_ITALIC
        MI_FONT_BOLD
        MI_COUNT_FONTS

    int miInit(NVGcontext* vg)
    void miTerminate()

    int miCreateFont(int face, const char* filename)
    int miCreateIconImage(const char* name, const char* filename, float scale)


    void miFrameBegin(int width, int height, MIinputState* input, float dt)
    void miFrameEnd()

    MIhandle miPanelBegin(float x, float y, float width, float height)
    MIhandle miPanelEnd()

    int miIsHover(MIhandle handle)
    int miIsActive(MIhandle handle)
    int miIsFocus(MIhandle handle)

    int miFocused(MIhandle handle)
    int miBlurred(MIhandle handle)

    int miPressed(MIhandle handle)
    int miReleased(MIhandle handle)
    int miClicked(MIhandle handle)
    int miDragged(MIhandle handle)
    int miChanged(MIhandle handle)

    void miBlur(MIhandle handle)
    void miChange(MIhandle handle)

    MIpoint miMousePos()
    int miMouseClickCount()

    MIhandle miButton(const char* label)
    MIhandle miText(const char* text)
    MIhandle miSlider(float* value, float vmin, float vmax)
    MIhandle miInput(char* text, int maxText)

    MIhandle miSliderValue(float* value, float vmin, float vmax)

    cdef enum MIpack:
        MI_TOP_BOTTOM
        MI_BOTTOM_TOP
        MI_LEFT_RIGHT
        MI_RIGHT_LEFT
        MI_FILLX
        MI_FILLY
    
    void miPack(int pack)
    void miColWidth(float width)
    void miRowHeight(float height)

    MIhandle miDockBegin(int pack)
    MIhandle miDockEnd()

    MIhandle miLayoutBegin(int pack)
    MIhandle miLayoutEnd()

    MIhandle miDivsBegin(int pack, int count, float* divs)
    MIhandle miDivsEnd()

    MIhandle miSpacer()

    cdef enum MIpopupSide:
        MI_RIGHT
        MI_BELOW

    cdef enum MIpopupLogic:
        MI_ONCLICK
        MI_ONHOVER
    
    MIhandle miPopupBegin(MIhandle base, int logic, int side)
    MIhandle miPopupEnd()

    void miPopupShow(MIhandle handle)
    void miPopupHide(MIhandle handle)
    void miPopupToggle(MIhandle handle)

    MIhandle miCanvasBegin(MIcanvasState* state, float width, float height)
    MIhandle miCanvasEnd()

    MIsize miMeasureText(const char* text, int face, float size)
