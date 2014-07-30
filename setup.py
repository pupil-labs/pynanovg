import os, platform
import numpy

from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

if platform.system() == 'Darwin':
	includes = ['/System/Library/Frameworks/OpenGL.framework/Versions/Current/Headers/',numpy.get_include()]
	f = '-framework'
	link_args = [f, 'OpenGL'] # f, 'Cocoa', f, 'IOKit', f, 'CoreVideo'
	libs = []
else:
    includes = ['/usr/include/GL',]
    libs = ['GL', 'GLU', 'GLEW', 'm']
    link_args = []


# extra_objects=["../build/libnanovg.a"]
nanovg_gl_path = 'nanovg/src/nanovg_gl2.c'

extensions = [
	Extension(	name="nanovg",
				sources=["src/nanovg.pyx", 'nanovg/src/nanovg.c'],
				include_dirs = includes,
				libraries = libs,
				extra_link_args=link_args,
				#backend is hardcoded. also look at the pyd and pyx files. ToDo: make this smart.
				# use any of the following: NANOVG_GL2_IMPLEMENTATION,NANOVG_GL3_IMPLEMENTATION,NANOVG_GLES2_IMPLEMENTATION,NANOVG_GLES3_IMPLEMENTATION
				extra_compile_args=['-D NANOVG_GL2_IMPLEMENTATION',]),
]

setup( 	name="nanovg",
		version="0.0.1",
		description="NanoVG Python Bindings",
		ext_modules=cythonize(extensions)
)