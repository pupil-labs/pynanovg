cdef extern from 'gl.h':
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


    cdef void nvgBeginFrame(NVGcontext* ctx, int windowWidth, int windowHeight, float devicePixelRatio)
    cdef void nvgEndFrame(NVGcontext* ctx)

    # color
    NVGcolor nvgRGBAf(float r, float g, float b, float a)
    NVGcolor nvgRGBA(float r, float g, float b, float a)
    NVGcolor nvgLerpRGBA(NVGcolor c0, NVGcolor c1, float u)
    NVGcolor nvgHSLA(float h, float s, float l, unsigned char a)

    # context state
    cdef void nvgSave(NVGcontext* ctx)
    cdef void nvgRestore(NVGcontext* ctx)
    cdef void nvgReset(NVGcontext* ctx)

    # fill/stroke
    cdef void nvgStrokeColor(NVGcontext* ctx, NVGcolor color)
    cdef void nvgStrokePaint(NVGcontext* ctx, NVGpaint paint)

    cdef void nvgFillColor(NVGcontext* ctx, NVGcolor color)
    cdef void nvgFillPaint(NVGcontext* ctx, NVGpaint paint)

    cdef void nvgMiterLimit(NVGcontext* ctx, float limit)
    cdef void nvgStrokeWidth(NVGcontext* ctx, float size)
    cdef void nvgLineCap(NVGcontext* ctx, int cap)
    cdef void nvgLineJoin(NVGcontext* ctx, int join)

    cdef void nvgGlobalAlpha(NVGcontext* ctx, float alpha)

    # transformations
    cdef void nvgResetTransform(NVGcontext* ctx)
    cdef void nvgTransform(NVGcontext* ctx, float a, float b, float c, float d, float e, float f)
    cdef void nvgTranslate(NVGcontext* ctx, float x, float y)
    cdef void nvgRotate(NVGcontext* ctx, float angle)
    cdef void nvgSkewX(NVGcontext* ctx, float angle)
    cdef void nvgSkewY(NVGcontext* ctx, float angle)
    cdef void nvgScale(NVGcontext* ctx, float x, float y)
    cdef void nvgCurrentTransform(NVGcontext* ctx, float* xform)
    cdef void nvgTransformIdentity(float* dst)
    cdef void nvgTransformTranslate(float* dst, float tx, float ty)
    cdef void nvgTransformScale(float* dst, float sx, float sy)
    cdef void nvgTransformRotate(float* dst, float a)
    cdef void nvgTransformSkewX(float* dst, float a)
    cdef void nvgTransformSkewY(float* dst, float a)
    cdef void nvgTransformMultiply(float* dst, const float* src)
    cdef void nvgTransformPremultiply(float* dst, const float* src)
    int nvgTransformInverse(float* dst, const float* src)
    cdef void nvgTransformPoint(float* dstx, float* dsty, const float* xform, float srcx, float srcy)

    # angular conversions
    float nvgDegToRad(float deg)
    float nvgRadToDeg(float rad)

    # image
    int nvgCreateImage(NVGcontext* ctx, const char* filename, int imageFlags)
    int nvgCreateImageMem(NVGcontext* ctx, int imageFlags, unsigned char* data, int ndata)
    int nvgCreateImageRGBA(NVGcontext* ctx, int w, int h, int imageFlags, const unsigned char* data)
    cdef void nvgUpdateImage(NVGcontext* ctx, int image, const unsigned char* data)
    cdef void nvgImageSize(NVGcontext* ctx, int image, int* w, int* h)
    cdef void nvgDeleteImage(NVGcontext* ctx, int image)

    # gradients
    NVGpaint nvgLinearGradient(NVGcontext* ctx, float sx, float sy, float ex, float ey, NVGcolor icol, NVGcolor ocol)
    NVGpaint nvgBoxGradient(NVGcontext* ctx, float x, float y, float w, float h, float r, float f, NVGcolor icol, NVGcolor ocol)
    NVGpaint nvgRadialGradient(NVGcontext* ctx, float cx, float cy, float inr, float outr, NVGcolor icol, NVGcolor ocol)
    NVGpaint nvgImagePattern(NVGcontext* ctx, float ox, float oy, float ex, float ey, float angle, int image, int repeat, float alpha)


    cdef void nvgScissor(NVGcontext* ctx, float x, float y, float w, float h)
    cdef void nvgIntersectScissor(NVGcontext* ctx, float x, float y, float w, float h)
    cdef void nvgResetScissor(NVGcontext* ctx)

    # lines, arcs, ellipse, rectangles
    cdef void nvgBeginPath(NVGcontext* ctx)
    cdef void nvgMoveTo(NVGcontext* ctx, float x, float y)
    cdef void nvgLineTo(NVGcontext* ctx, float x, float y)
    cdef void nvgBezierTo(NVGcontext* ctx, float c1x, float c1y, float c2x, float c2y, float x, float y)
    cdef void nvgQuadTo(NVGcontext* ctx, float cx, float cy, float x, float y)
    cdef void nvgArcTo(NVGcontext* ctx, float x1, float y1, float x2, float y2, float radius)
    cdef void nvgClosePath(NVGcontext* ctx)
    cdef void nvgPathWinding(NVGcontext* ctx, int dir)
    cdef void nvgArc(NVGcontext* ctx, float cx, float cy, float r, float a0, float a1, int dir)
    cdef void nvgRect(NVGcontext* ctx, float x, float y, float w, float h)
    cdef void nvgRoundedRect(NVGcontext* ctx, float x, float y, float w, float h, float r)
    cdef void nvgEllipse(NVGcontext* ctx, float cx, float cy, float rx, float ry)
    cdef void nvgCircle(NVGcontext* ctx, float cx, float cy, float r)

    cdef void nvgFill(NVGcontext* ctx)
    cdef void nvgStroke(NVGcontext* ctx)

    # fonts
    int nvgCreateFont(NVGcontext* ctx, const char* name, const char* filename)
    int nvgCreateFontMem(NVGcontext* ctx, const char* name, unsigned char* data, int ndata, int freeData)
    int nvgFindFont(NVGcontext* ctx, const char* name)
    cdef void nvgFontSize(NVGcontext* ctx, float size)
    cdef void nvgFontBlur(NVGcontext* ctx, float blur)
    cdef void nvgTextLetterSpacing(NVGcontext* ctx, float spacing)
    cdef void nvgTextLineHeight(NVGcontext* ctx, float lineHeight)
    cdef void nvgTextAlign(NVGcontext* ctx, int align)
    cdef void nvgFontFaceId(NVGcontext* ctx, int font)
    cdef void nvgFontFace(NVGcontext* ctx, const char* font)
    float nvgText(NVGcontext* ctx, float x, float y, const char* string, const char* end)
    cdef void nvgTextBox(NVGcontext* ctx, float x, float y, float breakRowWidth, const char* string, const char* end)
    float nvgTextBounds(NVGcontext* ctx, float x, float y, const char* string, const char* end, float* bounds)
    cdef void nvgTextBoxBounds(NVGcontext* ctx, float x, float y, float breakRowWidth, const char* string, const char* end, float* bounds)
    int nvgTextGlyphPositions(NVGcontext* ctx, float x, float y, const char* string, const char* end, NVGglyphPosition* positions, int maxPositions)
    cdef void nvgTextMetrics(NVGcontext* ctx, float* ascender, float* descender, float* lineh)
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
        int edgeAntiAlias
        int (*renderCreate)(void* uptr)
        int (*renderCreateTexture)(void* uptr, int type, int w, int h, int imageFlags, const unsigned char* data)
        int (*renderDeleteTexture)(void* uptr, int image)
        int (*renderUpdateTexture)(void* uptr, int image, int x, int y, int w, int h, const unsigned char* data)
        int (*renderGetTextureSize)(void* uptr, int image, int* w, int* h)
        void (*renderViewport)(void* uptr, int width, int height)
        void (*renderFlush)(void* uptr)
        void (*renderFill)(void* uptr, NVGpaint* paint, NVGscissor* scissor, float fringe, const float* bounds, const NVGpath* paths, int npaths)
        void (*renderStroke)(void* uptr, NVGpaint* paint, NVGscissor* scissor, float fringe, float strokeWidth, const NVGpath* paths, int npaths)
        void (*renderTriangles)(void* uptr, NVGpaint* paint, NVGscissor* scissor, const NVGvertex* verts, int nverts)
        void (*renderDelete)(void* uptr)

    NVGcontext* nvgCreateInternal(NVGparams* params)
    cdef void nvgDeleteInternal(NVGcontext* ctx)

    NVGparams* nvgInternalParams(NVGcontext* ctx)

    cdef void nvgDebugDumpPathCache(NVGcontext* ctx)

cdef extern from "../nanovg/src/nanovg_gl.h":
    # NVGcontext* nvgCreateGL3(int flags)
    cdef void nvgDeleteGL2(NVGcontext* ctx)
    int NVG_ANTIALIAS = 1
    int NVG_STENCIL_STROKES = 2
    int NANOVG_GL2_IMPLEMENTATION = 1
    ctypedef struct GLNVGcontext:
        pass
    NVGcontext* nvgCreateGL2(int flags)




