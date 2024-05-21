#include <chrono>
#include <thread>

#include "sleep.h"

void c_sleep(const int milliseconds) {
  std::this_thread::sleep_for(std::chrono::milliseconds(milliseconds));
}
