#include <iostream>
#include <array>
#include "example.h"

int main(int argc, char *argv[])
{
    (void)argc; (void)argv;

    std::cout << "Hello World!\n";

    std::array<double, 5> nums{1, 2, 3, 4, 5};
    print_array(nums.begin(), nums.end());    
    square_array(nums.begin(), nums.end());
    print_array(nums.begin(), nums.end());
}
