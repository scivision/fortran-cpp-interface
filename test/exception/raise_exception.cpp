#include <iostream>
#include <exception>

#include "raise_exception.h"


void raise_exception()
{
  std::string buf = "notanumber";

  try {
    std::stod(buf);
  } catch (const std::invalid_argument&) {
    std::cerr << "std::invalid_argument\n";
  } catch (const std::exception&) {
    std::cerr << "Caught by ancestor\n";
  } catch (...) {
    auto ptr = std::current_exception();
    std::cerr << "caught by (...)\n";
  }
}
