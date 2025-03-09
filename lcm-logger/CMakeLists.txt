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
