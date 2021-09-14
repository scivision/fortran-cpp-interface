execute_process(COMMAND ${exe}
  RESULT_VARIABLE ret
)

if(NOT ret EQUAL exp_code)
  message(FATAL_ERROR "Expected ${exe} code ${exp_code} but got ${ret}")
endif()
