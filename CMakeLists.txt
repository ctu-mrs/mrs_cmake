cmake_minimum_required(VERSION 3.28)

project(mrs_cmake)

find_package(ament_cmake REQUIRED)

install(
  DIRECTORY "cmake"
  DESTINATION "share/${PROJECT_NAME}"
)

ament_export_dependencies(
  ament_cmake
)

ament_package(
  CONFIG_EXTRAS "mrs_cmake-extras.cmake"
)

if(ENABLE_TESTS)
  find_package(ament_cmake_xmllint REQUIRED)
  ament_xmllint()
endif()
