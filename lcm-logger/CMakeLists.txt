add_executable(lcm-logger lcm_logger.c glib_util.c)
if(WIN32)
  target_link_libraries(lcm-logger lcm ${lcm-winport} GLib2::glib)
else()
  target_link_libraries(lcm-logger lcm-static GLib2::glib)
endif()

add_executable(lcm-logplayer lcm_logplayer.c)
if(WIN32)
  target_link_libraries(lcm-logplayer lcm ${lcm-winport})
else()
  target_link_libraries(lcm-logplayer lcm-static GLib2::glib)
endif()

install(TARGETS
  lcm-logger
  lcm-logplayer
  DESTINATION bin
)

install(FILES
  lcm-logger.1
  lcm-logplayer.1
  DESTINATION share/man/man1
)

include(GNUInstallDirs)

if (MSVC)
  set(DEPENDENCIES_DIR "${VCPKG_INSTALLED_DIR}/x64-windows" CACHE PATH "Location for extra libs (parent of /bin and /debug).")

  function(COPYLIB SOURCE_DIR FILE)
      # message(STATUS "Simple arguments: ${SOURCE_DIR}, ${FILE}, followed by ${ARGV}")
      if (FILE)
          add_custom_command(TARGET lcm-logplayer POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_if_different ${SOURCE_DIR}/${FILE}	"$<TARGET_FILE_DIR:lcm-logplayer>/templibs/${FILE}")                 # <--this is out-file path
          add_custom_command(TARGET lcm-logplayer POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_if_different ${SOURCE_DIR}/${FILE}	"$<TARGET_FILE_DIR:lcm-logplayer>/${FILE}")                 # <--this is out-file path
      endif(FILE)
  endfunction()

  copylib(${DEPENDENCIES_DIR}$<$<CONFIG:Debug>:/debug>/bin glib-2.0-0.dll)
  copylib(${DEPENDENCIES_DIR}$<$<CONFIG:Debug>:/debug>/bin pcre2-8$<$<CONFIG:Debug>:d>.dll)
  copylib(${DEPENDENCIES_DIR}$<$<CONFIG:Debug>:/debug>/bin iconv-2.dll)
  copylib(${DEPENDENCIES_DIR}$<$<CONFIG:Debug>:/debug>/bin intl-8.dll)

  include(InstallRequiredSystemLibraries)

  install(FILES "$<TARGET_FILE_DIR:lcm-logplayer>/templibs/" DESTINATION ${CMAKE_INSTALL_BINDIR})

endif (MSVC)
  