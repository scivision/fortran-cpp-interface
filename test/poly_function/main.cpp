// C++ calling polymorphic Fortran object
// based on https://github.com/mattzett/fortran_tests
// objconstruct_C returns status code:
// 0: success
// 1: invalid object type
// 2: null C pointer input
// 3: zero dimensions in constructor
// 4: allocation failure
// 5: invalid/stale object pointer
// 6: invalid C->Fortran input data pointer mapping
// 7: set_data deallocation failure
// 8: set_data allocation failure
// 9: destruct deallocation failure
#include <array>
#include <iostream>
#include <cstdlib>

#include "my_polyfcn.h"

int main() {

 // pointers for various fortran data
void* objptr1 = nullptr;
void* objptr2 = nullptr;
int objtype;
float* arrptr;
int status;

const size_t lx1=2;
const size_t ly1=2;

// Object 1
objtype=1;
std::array<float, lx1*ly1> x1;
x1 = {1, 2, 3, 4};
arrptr = &x1.front();
status = objconstruct_C(&objtype, &objptr1, &arrptr, &lx1, &ly1);
if (status != 0) {
  std::cerr << "objconstruct_C failed for object 1 with status " << status << "\n";
  return EXIT_FAILURE;
}
std::cout << "Use object 1\n";
status = objuse_C(&objtype, &objptr1);
if (status != 0) {
  std::cerr << "objuse_C failed for object 1 with status " << status << "\n";
  return EXIT_FAILURE;
}

// Object 2
objtype=2;
const size_t lx2=2;
const size_t ly2=3;
std::array<float, lx2*ly2> x2;
x2 = {6,5,4,3,2,1};
arrptr = &x2.front();
status = objconstruct_C(&objtype, &objptr2, &arrptr, &lx2, &ly2);
if (status != 0) {
  std::cerr << "objconstruct_C failed for object 2 with status " << status << "\n";
  return EXIT_FAILURE;
}
std::cout << "Use object 2\n";
status = objuse_C(&objtype, &objptr2);
if (status != 0) {
  std::cerr << "objuse_C failed for object 2 with status " << status << "\n";
  return EXIT_FAILURE;
}

// show that objects persist
std::cout << "Use object 1 again\n";
objtype=1;
status = objuse_C(&objtype, &objptr1);
if (status != 0) {
  std::cerr << "objuse_C failed when reusing object 1 with status " << status << "\n";
  return EXIT_FAILURE;
}

std::cout << "Use object 2 again\n";
objtype=2;
status = objuse_C(&objtype, &objptr2);
if (status != 0) {
	std::cerr << "objuse_C failed when reusing object 2 with status " << status << "\n";
	return EXIT_FAILURE;
}

// Negative-path checks for C ABI status behavior.
int invalid_objtype = 999;
status = objuse_C(&invalid_objtype, &objptr1);
if (status != 1) {
	std::cerr << "Expected invalid objtype status 1 from objuse_C, got " << status << "\n";
	return EXIT_FAILURE;
}

void* null_obj = nullptr;
status = objuse_C(&objtype, &null_obj);
if (status != 2) {
	std::cerr << "Expected null pointer status 2 from objuse_C, got " << status << "\n";
	return EXIT_FAILURE;
}

void* bad_construct_ptr = nullptr;
size_t zero_dim = 0;
objtype = 1;
status = objconstruct_C(&objtype, &bad_construct_ptr, &arrptr, &zero_dim, &ly1);
if (status != 3) {
	std::cerr << "Expected zero-dimension status 3 from objconstruct_C, got " << status << "\n";
	return EXIT_FAILURE;
}

objtype = 999;
status = objconstruct_C(&objtype, &bad_construct_ptr, &arrptr, &lx1, &ly1);
if (status != 1) {
	std::cerr << "Expected invalid objtype status 1 from objconstruct_C, got " << status << "\n";
	return EXIT_FAILURE;
}

// Stress the object lifecycle repeatedly.
for (int iter = 0; iter < 100; ++iter) {
	void* loop_obj = nullptr;
	objtype = (iter % 2) + 1;
	size_t loop_lx = (objtype == 1) ? lx1 : lx2;
	size_t loop_ly = (objtype == 1) ? ly1 : ly2;
	arrptr = (objtype == 1) ? &x1.front() : &x2.front();

	status = objconstruct_C(&objtype, &loop_obj, &arrptr, &loop_lx, &loop_ly);
	if (status != 0) {
		std::cerr << "Lifecycle loop construct failed at iteration " << iter << " with status " << status << "\n";
		return EXIT_FAILURE;
	}

	     status = objuse_C(&objtype, &loop_obj);
	if (status != 0) {
		std::cerr << "Lifecycle loop use failed at iteration " << iter << " with status " << status << "\n";
		return EXIT_FAILURE;
	}

	status = destruct_C(&objtype, &loop_obj);
	if (status != 0) {
		std::cerr << "Lifecycle loop destruct failed at iteration " << iter << " with status " << status << "\n";
		return EXIT_FAILURE;
	}
}

objtype=1;
status = destruct_C(&objtype, &objptr1);
if (status != 0) {
	std::cerr << "destruct_C failed for object 1 with status " << status << "\n";
	return EXIT_FAILURE;
}
objtype=2;
status = destruct_C(&objtype, &objptr2);
if (status != 0) {
	std::cerr << "destruct_C failed for object 2 with status " << status << "\n";
	return EXIT_FAILURE;
}

// Double-destroy should be harmless because destruct_C ignores null pointers.
status = destruct_C(&objtype, &objptr2);
if (status != 0) {
	std::cerr << "Expected success from double destruct, got status " << status << "\n";
	return EXIT_FAILURE;
}

// Invalid-type destroy should return invalid type status when handle is non-null.
void* invalid_type_obj = nullptr;
objtype = 1;
status = objconstruct_C(&objtype, &invalid_type_obj, &arrptr, &lx1, &ly1);
if (status != 0) {
	std::cerr << "Failed to construct invalid_type_obj with status " << status << "\n";
	return EXIT_FAILURE;
}

objtype = 999;
status = destruct_C(&objtype, &invalid_type_obj);
if (status != 1) {
	std::cerr << "Expected invalid objtype status 1 from destruct_C, got " << status << "\n";
	return EXIT_FAILURE;
}

objtype = 1;
status = destruct_C(&objtype, &invalid_type_obj);
if (status != 0) {
	std::cerr << "Cleanup destruct_C failed for invalid_type_obj with status " << status << "\n";
	return EXIT_FAILURE;
}

return EXIT_SUCCESS;
}
