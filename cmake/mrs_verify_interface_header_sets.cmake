#[=======================================================================[.rst:

mrs_verify_interface_header_sets
--------------------------------


.. cmake:command:: mrs_verify_interface_header_sets

  Add test using CMAKE_VERIFY_INTERFACE_HEADER_SETS for a specified target:

  .. code-block:: cmake

    mrs_verify_interface_header_sets(
      <target>
      [TIMEOUT <timeout>]
    )
  
  This enables VERIFY_INTERFACE_HEADER_SETS on the specified target and adds
  test that runs the verification.

  Arguments:

  * ``<target>``
    Name of the target for which the test should be created.
  * ``<timeout>``
    Timeout in seconds for the runtime of the test (default 600).

#]=======================================================================]

function(mrs_verify_interface_header_sets target)
  set(options "")
  set(one_value_keywords "TIMEOUT")
  set(multi_value_keywords "")
  cmake_parse_arguments(PARSE_ARGV 1 arg
      "${options}" "${one_value_keywords}" "${multi_value_keywords}"
  )

  if (NOT TARGET "${target}")
    message(FATAL_ERROR "'${target}' is not a target.")
  endif()

  if (NOT "${arg_UNPARSED_ARGUMENTS}" STREQUAL "")
    message(FATAL_ERROR "Unrecognized arguments: ${arg_UNPARSED_ARGUMENTS}")
  endif()

  if (DEFINED arg_TIMEOUT)
    set(timeout "${arg_TIMEOUT}")
  else()
    set(timeout "600")
  endif()

  set(test_target_name "${target}_verify_interface_header_sets")

  set_target_properties("${target}"
    PROPERTIES
      VERIFY_INTERFACE_HEADER_SETS ON
  )

  ament_add_test("${test_target_name}"
    GENERATE_RESULT_FOR_RETURN_CODE_ZERO
    COMMAND cmake --build . --config $<CONFIG> --target "${test_target_name}"
    TIMEOUT "${timeout}"
    WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
  )

  set_property(TEST "${test_target_name}"
    APPEND PROPERTY LABELS "linter" "verify_interface_header_sets"
  )
endfunction()
