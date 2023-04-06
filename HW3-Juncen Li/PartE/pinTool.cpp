#include "pin.H"
#include <iostream>
#include <fstream>

using namespace std;

ofstream outfile;
PIN_LOCK lock;

// Instrumentation function for memory accesses
VOID InstrumentMemory(VOID *ip, VOID *addr, UINT32 size, BOOL isWrite)
{
    // Only instrument load and store instructions
    if (isWrite || size != 1) return;

    // Acquire the lock to ensure thread safety
    PIN_GetLock(&lock, 1);

    // Write the data address to the output file
    outfile << hex << addr << endl;

    // Release the lock
    PIN_ReleaseLock(&lock);
}

// Instrumentation function for setting the value of N
VOID SetN(VOID *nptr, VOID *nval)
{
    // Set the value of N to the specified value
    *reinterpret_cast<int*>(nptr) = *reinterpret_cast<int*>(nval);
}

// The main function for the PIN tool
int main(int argc, char *argv[])
{
    // Initialize PIN
    if (PIN_Init(argc, argv)) {
        cerr << "Error: could not initialize PIN" << endl;
        return 1;
    }

    // Open the output file for writing
    outfile.open("data_trace.txt");

    // Initialize the lock
    PIN_InitLock(&lock);

    // Instrument memory accesses in the linpack.c program
    IMG img = IMG_Open("linpack", "r");
    RTN rtn = RTN_FindByName(img, "daxpy_");
    RTN_Open(rtn);
    RTN_InsertCall(rtn, IPOINT_BEFORE, (AFUNPTR)InstrumentMemory,
                   IARG_INST_PTR, IARG_MEMORYOP_EA, 0, IARG_UINT32, 0, IARG_BOOL, false, IARG_END);
    RTN_Close(rtn);

    // Instrument setting the value of N in the linpack.c program
    rtn = RTN_FindByName(img, "main");
    RTN_Open(rtn);
    RTN_InsertCall(rtn, IPOINT_BEFORE, (AFUNPTR)SetN,
                   IARG_MEMORYWRITE_EA, (ADDRINT)&N, IARG_FUNCARG_ENTRYPOINT_VALUE, 0, IARG_END);
    RTN_Close(rtn);

    // Start the program
    PIN_StartProgram();

    return 0;
}
