PyNanoVG
========

... work in progress ...

[Cython](https://github.com/cython/cython) powered bindings for [NanoVG](https://github.com/memononen/nanovg)

Dependencies
============

+ Cython

Build NanoVG
============

```python
python setup.py build_ext -i
```
Builds `nanovg.so` using files from /src and nanovg sourcefiles from nanovg submodule.
This module does not use the nanovg lua toolchain and instead build nanovg from source. See setup.py.

So far we only build the nanovg.so file which can be locally imported using python.

Usage
=====

- Make sure you have a python binding to GLFW3 installed
- Copy `nanovg.so` file to the /examples folder
- `python demo.py`
