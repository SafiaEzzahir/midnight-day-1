
add_executable(websocket_midnight
 main.cpp
)

include(FetchContent)
FetchContent_Declare(
    websocketpp
    GIT_REPOSITORY https://github.com/zaphoyd/websocketpp
    GIT_TAG master 
    GIT_SHALLOW TRUE
    GIT_PROGRESS TRUE
)
FetchContent_MakeAvailable(websocketpp)

FetchContent_Declare(json URL https://github.com/nlohmann/json/releases/download/v3.12.0/json.tar.xz)
FetchContent_MakeAvailable(json)

target_compile_options(websocket_midnight PRIVATE -static -static-libgcc -static-libstdc++)
target_link_options(websocket_midnight PRIVATE -static -static-libgcc -static-libstdc++)

target_link_libraries(websocket_midnight PRIVATE nlohmann_json::nlohmann_json)

add_custom_command(TARGET websocket_midnight POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy
        ${CMAKE_BINARY_DIR}/compile_commands.json
        ${CMAKE_SOURCE_DIR}/compile_commands.json
    COMMENT "Add clangd to the base directory")

install(TARGETS websocket_midnight DESTINATION bin)
