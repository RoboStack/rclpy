# Copyright 2018 Open Source Robotics Foundation, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include(FindPackageHandleStandardArgs)

# Look for pybind11 outright
find_path(PYBIND11_INCLUDE_DIR
  NAMES pybind11/pybind11.h
)

if(NOT PYBIND11_INCLUDE_DIR)
  # Try using python code to get the include path
  set(Python_ADDITIONAL_VERSIONS 3)
  include(CMakeFindDependencyMacro)
  find_dependency(PythonInterp)

  if(PYTHONINTERP_FOUND)
    execute_process(
      COMMAND ${PYTHON_EXECUTABLE} -c "import pybind11; print(pybind11.get_include())"
      OUTPUT_VARIABLE PYBIND11_INCLUDE_DIR
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
  endif()
endif()

find_package_handle_standard_args(PYBIND11 DEFAULT_MSG PYBIND11_INCLUDE_DIR)
