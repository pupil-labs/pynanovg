PyNanoVG
========

... work in progress ...

[Cython](https://github.com/cython/cython) powered bindings for [NanoVG](https://github.com/memononen/nanovg)

Dependencies
============

+ Cython
+ GLFW
+ OpenGL

Build NanoVG
============

```python
python setup.py build_ext -i
```
Builds `nanovg.so` in the /src folder along with `cython` generated `nanovg.c` 

Usage 
=====

- Make sure dependencies are installed
- Copy `nanovg.so` file to the /examples folder
- `python demo.py`  
