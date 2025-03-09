include("release/CPackConfig.cmake")

if( WIN32 AND NOT CYGWIN)
    set(CPACK_INSTALL_CMAKE_PROJECTS
        "debug;lcm;ALL;/"
        "release;lcm;ALL;/"
        "relwithdebinfo;lcm;ALL;/"
        "minsizerel;lcm;ALL;/"
        )
else( )
    set(CPACK_INSTALL_CMAKE_PROJECTS
        "debug;lcm;ALL;/"
        "release;lcm;ALL;/"
        )
endif( WIN32 AND NOT CYGWIN)
