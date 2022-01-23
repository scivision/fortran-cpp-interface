void print_cstring_array(int* n, char* []);

int main(void) {
  char* cstring[] = { "abc", "def", "ghi", "jkl" };
  int n = 4;
  print_cstring_array(&n, cstring);
}
