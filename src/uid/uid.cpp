// Windows doesn't have a numerid UID like Unix, so we return the SID as a string instead.

#if defined(_WIN32)
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <sddl.h>        // For ConvertSidToStringSid
#include <vector>
#else
#include <unistd.h>
#include <sys/types.h>
#endif


#include <iostream>
#include <string>
#include <string_view>
#include <system_error>

#include "uid.h"

#if __has_attribute(unlikely)
#define UNLIKELY [[unlikely]]
#else
#define UNLIKELY
#endif


extern "C" {
std::string::size_type c_get_uid(char* result, const std::string::size_type buffer_size) {
    return str2char(get_uid(), result, buffer_size);
}
}

std::string::size_type str2char(std::string_view s, char* result, const std::string::size_type buffer_size)
{
  if(s.length() >= buffer_size) UNLIKELY
  {
    std::cerr << "ERROR: " << s << " " << std::make_error_code(std::errc::result_out_of_range) << "\n";
    return 0;
  }

  s.copy(result, buffer_size);
  result[s.length()] = '\0';
  return s.length();
}

std::string get_uid()
{
#if defined(_WIN32)
    HANDLE hToken = nullptr;
    if (!OpenProcessToken(GetCurrentProcess(), TOKEN_QUERY, &hToken)) {
        std::cerr << "OpenProcessToken failed: " << GetLastError() << "\n";
        return {};
    }

    // get required buffer size
    DWORD dwLength = 0;
    GetTokenInformation(hToken, TokenUser, nullptr, 0, &dwLength);

    if (GetLastError() != ERROR_INSUFFICIENT_BUFFER) {
        std::cerr << "GetTokenInformation (size) failed: " << GetLastError() << "\n";
        CloseHandle(hToken);
        return {};
    }

    std::vector<BYTE> buffer(dwLength);

    if (!GetTokenInformation(hToken, TokenUser, buffer.data(), dwLength, &dwLength)) {
        std::cerr << "GetTokenInformation failed: " << GetLastError() << "\n";
        CloseHandle(hToken);
        return {};
    }

    PTOKEN_USER pTokenUser = reinterpret_cast<PTOKEN_USER>(buffer.data());

    // Convert SID to string
    LPSTR sidString = nullptr;
    if (!ConvertSidToStringSidA(pTokenUser->User.Sid, &sidString)) {
        std::cerr << "ConvertSidToStringSidA failed: " << GetLastError() << "\n";
        CloseHandle(hToken);
        return {};
    }

    std::string result = sidString;
    LocalFree(sidString);
    CloseHandle(hToken);

    return result;

#else
    return std::to_string(geteuid());
#endif
}
