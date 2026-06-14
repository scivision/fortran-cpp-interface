---
description: when building the project code, use CMake presets
applyTo: '**/*.cmake, **/CMakeLists.txt, **/CMakePresets.json, **/*.cpp, **/*.h, **/*.c, **/*.f90'
---

* build and test project code: `cmake --workflow default`
* only build the project code: `cmake --workflow build`

* Notice that the test/*/CMakeLists.txt files have directory property LABELS set that can be used to run a subset of tests with `ctest -L <label>` (e.g. `ctest -L allocate` to run only the tests in test/allocate)
