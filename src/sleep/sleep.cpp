#include <chrono>
#include <thread>

extern "C" void c_sleep(int);

void c_sleep(int milliseconds)
{
  std::this_thread::sleep_for(std::chrono::milliseconds(milliseconds));
}
