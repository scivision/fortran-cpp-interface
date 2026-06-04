#include <string>
#include <string_view>

extern "C" {
std::string::size_type c_get_uid(char*, const std::string::size_type);
}

std::string::size_type str2char(std::string_view, char*, const std::string::size_type);

std::string get_uid();
