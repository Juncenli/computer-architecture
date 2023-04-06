#include <pin.H>
#include <iostream>

using namespace std;

static UINT64 icount = 0;

// Pin calls this function every time a new instruction is encountered
VOID Instruction(INS ins, VOID *v)
{
    icount++;
}

// Pin calls this function every time the target program is about to exit
VOID Fini(INT32 code, VOID *v)
{
    cout << "Instruction count: " << icount << endl;
}

// Main function that sets up Pin and registers the instrumentation functions
int main(int argc, char * argv[])
{
    // Initialize Pin
    PIN_Init(argc, argv);

    // Register Instruction function to be called for every instruction
    INS_AddInstrumentFunction(Instruction, 0);

    // Register Fini function to be called when the target program is about to exit
    PIN_AddFiniFunction(Fini, 0);

    // Start the program
    PIN_StartProgram();

    return 0;
}
