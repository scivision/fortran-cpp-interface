#include <iostream>
#include <exception>
#include <string>

#include "raise_exception.h"


void raise_exception()
{
  std::string buf = "notanumber";

  try {
    buf = std::stod(buf);
  } catch (const std::invalid_argument&) {
    std::cerr << "caught by std::invalid_argument\n";
  } catch (const std::exception&) {
    std::cerr << "caught by std::exception\n";
  } catch (...) {
    auto ptr = std::current_exception();
    std::cerr << "caught by (...)\n";
  }
}
