<div align='center' ><font size='70'>EECE7352 Homework 5 - Juncen Li</font></div>


# Part A

## a) 

Tradeoffs between Snoopy Cache Coherency and Directory-Based Cache Coherency Protocols:

Snoopy Cache Coherency Protocol:

- Pros:
Simple and easy to implement.
Works well for systems with a small number of processors.
Low latency as cache controllers snoop on the bus and directly update their states.
- Cons:
Limited scalability as it relies on a shared bus, which can become a bottleneck for a large number of processors.
Increased bus traffic due to broadcasting of all read and write requests.


Directory-Based Cache Coherency Protocol:

- Pros:
More scalable as it does not rely on a shared bus, making it suitable for systems with a large number of processors.
Reduced bus traffic as read and write requests are sent directly to the directory, which then sends updates only to the affected caches.
- Cons:
More complex to implement due to the need for managing the directory and its communication with caches.
Higher latency due to the extra level of indirection through the directory.

## b)

Role of the Exclusive State in the MESI Protocol:

The MESI protocol (Modified, Exclusive, Shared, and Invalid) is a cache coherence protocol that introduces the Exclusive state to optimize read operations. The Exclusive state indicates that a cache block is present only in the current cache and is not present in any other cache in the system. The block is also unmodified, meaning it is identical to the main memory copy. This state allows a cache to upgrade the block to the Modified state without broadcasting a request on the shared bus, thus reducing bus traffic and improving performance.


## c)

Role of the Ownership State in the MOESI Protocol:

The MOESI protocol (Modified, Owner, Exclusive, Shared, and Invalid) extends the MESI protocol by introducing the Ownership state to optimize write operations in shared states. The Ownership state signifies that a cache block is shared among multiple caches and that the current cache is responsible for maintaining the most up-to-date value for that block. If a write request is made to a block in the Ownership state, the cache can update the block locally without broadcasting an invalidation message, reducing bus traffic. When a cache holding a block in the Ownership state receives a request for the block, it provides the updated value to the requesting cache and main memory, ensuring coherence.

## d)

##### a. Sequential Consistency (SC) Model:

In the SC model, the memory operations appear to be executed in some sequential order, and the operations of each processor appear in the order specified by the program. For this case, let's consider the possible interleavings:

Interleaving 1:
P1: While (B == 0);
P2: While (A == 0);
P1: A = 1;
P2: B = 1;

Interleaving 2:
P1: While (B == 0);
P2: While (A == 0);
P2: B = 1;
P1: A = 1;

In both interleavings, at the end of the code segments, A = 1 and B = 1. Therefore, with the sequential consistency model, A = 1 and B = 1.


##### b. Total Store Order (TSO) Consistency Model:



The TSO consistency model allows a processor's write operations to be visible to other processors in any order, but it must preserve the program order for each individual processor's read and write operations. Due to the store buffers, write operations can be delayed, making them visible to other processors later than they occur. Considering this, let's analyze the code segments:

- Initially, A = 0 and B = 0.
- P1 executes "While (B == 0);" and enters the loop since B = 0.
- P2 executes "While (A == 0);" and enters the loop since A = 0.
- Under TSO, P1's write operation "A = 1;" can be delayed in the store buffer. This means P2 may not immediately see the updated value of A.
- Similarly, P2's write operation "B = 1;" can be delayed in the store buffer, and P1 may not immediately see the updated value of B.
- If both write operations are delayed, both processors can be stuck in their respective loops indefinitely.


However, if both write operations become visible to the other processor at some point, we will have the following possible interleavings:

Interleaving 3 (assuming P1's write becomes visible first):
P1: While (B == 0);
P2: While (A == 0);
P1: A = 1;
P2: B = 1;

Interleaving 4 (assuming P2's write becomes visible first):
P1: While (B == 0);
P2: While (A == 0);
P2: B = 1;
P1: A = 1;

In both interleavings, at the end of the code segments, A = 1 and B = 1. However, there is also a possibility that both processors get stuck in their loops indefinitely due to the delayed write operations in the store buffers. So, with the total store order consistency model, the possible values at the end of the segments are A = 1 and B = 1 or both processors being stuck in their loops.

# Part B

##### Intel: An example from the Intel Core i7-9700K (Coffee Lake) processor:

1. L1 TLB:
- Separate for instructions (ITLB) and data (DTLB).
- ITLB: 128 entries, 4-way set associative, supports 4KB and 2MB pages.
- DTLB: 64 entries, 4-way set associative, supports 4KB and 2MB pages.
2. L2 TLB:
- Unified for both instructions and data.
- 1536 entries, 6-way set associative, supports 4KB, 2MB, and 1GB pages.


A single entry in the L1 ITLB or DTLB for Intel Core i7-9700K would typically contain:

- Virtual Page Number (VPN): A part of the virtual address that maps to a physical page number.
- Physical Page Number (PPN): The physical address of the corresponding page in the main memory.
- Page size: Indicates if the entry corresponds to a 4KB or 2MB page.
- Access rights: Information on read, write, and execute permissions for the page.
- Valid bit: Indicates if the TLB entry is valid.
- Present bit: Indicates if the page is present in the main memory.
- Dirty bit: Indicates if the page has been modified (relevant for DTLB).


##### ARM: An example from the ARM Cortex-A72 processor:

1. L1 TLB:
- Separate for instructions (ITLB) and data (DTLB).
- ITLB: 48 entries, fully associative, supports 4KB, 64KB, 2MB, and 1GB pages.
- DTLB: 48 entries, fully associative, supports 4KB, 64KB, 2MB, and 1GB pages.

2. L2 TLB:
- Unified for both instructions and data.
- 1024 entries, 4-way set associative, supports 4KB, 64KB, 2MB, and 1GB pages.


A single entry in the L1 ITLB or DTLB for ARM Cortex-A72 would typically contain:

- Virtual Page Number (VPN): A part of the virtual address that maps to a physical page number.
- Physical Page Number (PPN): The physical address of the corresponding page in the main memory.
- Page size: Indicates if the entry corresponds to a 4KB, 64KB, 2MB, or 1GB page.
- Access rights: Information on read, write, and execute permissions for the page.
- Valid bit: Indicates if the TLB entry is valid.
- Present bit: Indicates if the page is present in the main memory.
- Dirty bit: Indicates if the page has been modified (relevant for DTLB).
- ASID (Address Space Identifier): A unique identifier for a particular address space.


Sources:

Intel 64 and IA-32 Architectures Optimization Reference Manual: https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-optimization-manual.pdf

ARM Cortex-A72 Software Optimization Guide: https://developer.arm.com/documentation


# Part C


`cat /proc/cpuinfo`


```bash
-bash-4.2$ cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 1
siblings	: 12
core id		: 0
cpu cores	: 6
apicid		: 32
initial apicid	: 32
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.94
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 0
siblings	: 12
core id		: 0
cpu cores	: 6
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.78
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 1
siblings	: 12
core id		: 1
cpu cores	: 6
apicid		: 34
initial apicid	: 34
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.94
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 0
siblings	: 12
core id		: 1
cpu cores	: 6
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.78
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 4
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 1
siblings	: 12
core id		: 2
cpu cores	: 6
apicid		: 36
initial apicid	: 36
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.94
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 5
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 0
siblings	: 12
core id		: 2
cpu cores	: 6
apicid		: 4
initial apicid	: 4
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.78
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 6
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 1
siblings	: 12
core id		: 8
cpu cores	: 6
apicid		: 48
initial apicid	: 48
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.94
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 7
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 0
siblings	: 12
core id		: 8
cpu cores	: 6
apicid		: 16
initial apicid	: 16
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.78
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 8
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 1
siblings	: 12
core id		: 9
cpu cores	: 6
apicid		: 50
initial apicid	: 50
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.94
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 9
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 0
siblings	: 12
core id		: 9
cpu cores	: 6
apicid		: 18
initial apicid	: 18
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.78
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 10
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 1
siblings	: 12
core id		: 10
cpu cores	: 6
apicid		: 52
initial apicid	: 52
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.94
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 11
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 0
siblings	: 12
core id		: 10
cpu cores	: 6
apicid		: 20
initial apicid	: 20
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.78
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 12
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 1
siblings	: 12
core id		: 0
cpu cores	: 6
apicid		: 33
initial apicid	: 33
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.94
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 13
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 0
siblings	: 12
core id		: 0
cpu cores	: 6
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.78
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 14
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 1
siblings	: 12
core id		: 1
cpu cores	: 6
apicid		: 35
initial apicid	: 35
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.94
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 15
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 0
siblings	: 12
core id		: 1
cpu cores	: 6
apicid		: 3
initial apicid	: 3
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.78
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 16
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 1
siblings	: 12
core id		: 2
cpu cores	: 6
apicid		: 37
initial apicid	: 37
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.94
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 17
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 0
siblings	: 12
core id		: 2
cpu cores	: 6
apicid		: 5
initial apicid	: 5
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.78
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 18
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 1
siblings	: 12
core id		: 8
cpu cores	: 6
apicid		: 49
initial apicid	: 49
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.94
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 19
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 0
siblings	: 12
core id		: 8
cpu cores	: 6
apicid		: 17
initial apicid	: 17
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.78
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 20
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 1
siblings	: 12
core id		: 9
cpu cores	: 6
apicid		: 51
initial apicid	: 51
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.94
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 21
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 0
siblings	: 12
core id		: 9
cpu cores	: 6
apicid		: 19
initial apicid	: 19
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.78
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 22
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 1
siblings	: 12
core id		: 10
cpu cores	: 6
apicid		: 53
initial apicid	: 53
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.94
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 23
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz
stepping	: 2
microcode	: 0x1a
cpu MHz		: 2659.971
cache size	: 12288 KB
physical id	: 0
siblings	: 12
core id		: 10
cpu cores	: 6
apicid		: 21
initial apicid	: 21
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
bogomips	: 5319.78
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:
```

The Intel Xeon X5650 CPU I am running on is a server-grade processor from Intel's Xeon family, specifically the Westmere-EP (45 nm) microarchitecture. This particular model was released in 2010 and has been widely used in various server and workstation applications.

The X5650 has 6 cores, but with Intel's Hyper-Threading technology, it can process up to 12 threads simultaneously, allowing for better multitasking and parallelism in workloads. The CPU has a base clock speed of 2.67 GHz, which can dynamically adjust based on workload requirements.

The processor also has a 12 MB L3 cache (referred to as "cache size"), which helps store frequently accessed data and instructions closer to the CPU for faster retrieval and processing. This significantly reduces the latency in fetching data from the main memory.

And the system has two X5650 processors, which means we have a total of 12 cores and 24 threads available for processing. This dual-processor configuration provides a substantial amount of computational power for server and workstation tasks.


##### a.

I have added some instructions in pi.c in order to measure the program's execution time.

- Compile the program `gcc -o pi pi.c -lpthread -lm`
- Run the program: Choose a large number of intervals, e.g., 100 million (100000000), to get meaningful runtimes and accurate values for PI. Run the program with different numbers of threads, such as 1, 2, 4, 8, 16, 32, and 64.

`./pi 100000000 1`

`./pi 100000000 2`

`./pi 100000000 4`

`./pi 100000000 8`

`./pi 100000000 16`

`./pi 100000000 32`

`./pi 100000000 64`


Time
|   1 thread   |   2 thread  |   4 thread  |   8 thread   |  16 thread | 32 thread |64 thread |
|:----------:|:----------:|:----------:|:----------:| :-----------:|:-------:|:-------:|
| 0.920000s     | 0.920000s  | 0.920000s | 0.970000s      |  1.190000s | 1.760000|1.800000|


Speedup
|   1 thread   |   2 thread  |   4 thread  |   8 thread   |   16 thread |  32 thread | 64 thread |
|:-----------:|:-------------:|:-------------:|:--------------:| :------------:| :------------:|:------------:|
| 1            |    1   | 1      | 1       |  0.9484     | 0.7731| 0.5227| 0.5111|


Pi Estimate
|   1 thread   |   2 thread  |   4 thread  |   8 thread   |   16 thread |32 thread |64 thread |
|:-----------:|:-------------:|:-------------:|:--------------:| :------------:| :------------:|:------------:|
| 3.141592     | 3.141592    | 3.141592       | 3.141592 |  3.141592     |3.141592|3.141592|

##### b.

1. Time: The execution time increases as the number of threads increases. Ideally, we would expect the execution time to decrease with an increased number of threads as the workload is divided among multiple threads. However, in this case, the time taken for execution increases due to the overhead of creating, managing, and synchronizing the threads. This overhead becomes more significant as the number of threads increases, negating the benefit of parallelization.

2. Speedup: The speedup factor shows how much faster the program runs with multiple threads compared to a single thread. In this case, the speedup remains at 1 for 1, 2, and 4 threads, indicating no significant performance improvement. However, for 8, 16, 32, and 64 threads, the speedup decreases, indicating that the program is actually running slower than the single-threaded version. This behavior is consistent with the increased execution time due to the overhead of managing more threads.

3. Pi Estimate: The estimate of Pi remains consistent across all thread configurations. This is a positive result, as it indicates that the program's accuracy is not affected by the number of threads used for parallelization.

Overall, the trends suggest that the parallelization implemented in this program is not providing the expected performance improvements due to the overhead of thread management and synchronization. It may be more beneficial to optimize the implementation or consider alternative parallelization approaches such as using a parallel programming model like OpenMP, which can manage threads more efficiently.

# Part D

##### a)

One such approach is Dynamic Voltage and Frequency Scaling (DVFS). DVFS is a technique used to adjust the voltage and frequency of a processor dynamically based on the workload, power constraints, and thermal constraints.

A modern processor that implements DVFS is the ARM Cortex-A78 CPU, which is used in various mobile devices. This processor uses ARM's Intelligent Power Allocation (IPA) technology, which dynamically scales the voltage and frequency to balance performance, power consumption, and thermal management. The Cortex-A78 can operate in a wide range of frequencies and voltages, allowing it to adapt to various workloads and power requirements.


##### b)

One current embedded CPU is the NXP i.MX 8M Mini, which is based on the Arm Cortex-A53 architecture. According to NXP's datasheet, the i.MX 8M Mini has a clock speed of up to 1.8 GHz, and a power consumption of 1.6 W to 3.6 W, depending on the workload and operating conditions. The i.MX 8M Mini is designed for use in low-power applications such as home automation, industrial control, and portable devices.

One current high-performance multi-core CPU is the Intel Core i9-12900K, which was released in late 2021. The Core i9-12900K has 16 cores and 24 threads, and a base clock speed of 3.2 GHz, which can boost up to 5.3 GHz. According to Intel's specifications, the Core i9-12900K has a maximum power consumption of 241 watts.

It might not make sense to combine many embedded CPUs to replace one high-performance CPU while reducing the power budget. Even though multiple embedded CPUs could theoretically achieve similar performance to a high-performance CPU, the power consumption of multiple CPUs and the required interconnects between them could offset any power savings. In addition, software would need to be designed to take advantage of the multiple CPUs, which could be challenging and time-consuming.

To illustrate this point, let's consider the power consumption of four i.MX 8M Mini CPUs. Assuming each CPU consumes 2.5 W, the total power consumption would be 10 W. In comparison, the power consumption of the Core i9-12900K is 241 W, which is significantly higher than the combined power consumption of four i.MX 8M Mini CPUs. Therefore, it is unlikely that combining multiple embedded CPUs would result in significant power savings compared to a high-performance CPU like the Core i9-12900K.

Sources:

NXP i.MX 8M Mini Datasheet: https://www.nxp.com/docs/en/data-sheet/IMX8MMCEC.pdf

Intel Core i9-12900K Specifications: https://ark.intel.com/content/www/us/en/ark/products/208854/intel-core-i9-12900k-processor-30m-cache-up-to-5-30-ghz.html

# Extra Credit

The NVIDIA A100 GPU, based on the Ampere architecture, and the AMD Ryzen CPU, based on the Zen architecture, have different memory hierarchies designed to cater to their specific performance requirements and architectural differences.

Memory Hierarchy of NVIDIA A100 GPU:

1. Registers: Each streaming multiprocessor (SM) has a large register file shared among its resident threads.
2. L1 Cache / Shared Memory: The A100 GPU combines L1 cache and shared memory into a single, configurable memory block for each SM.
3. L2 Cache: A larger, unified L2 cache is shared across all SMs in the GPU.
4. Device Memory (GPU DRAM): The global memory, also known as device memory, is the high-capacity DRAM connected to the GPU through a high-speed memory interface.
5. System Memory (Host DRAM): The CPU's main memory, which can be accessed by the GPU through PCI Express or NVLink, depending on the system configuration.


Memory Hierarchy of AMD Ryzen CPU (e.g., Ryzen 9 3900X):

1. Registers: Each core has a dedicated register file.
2. L1 Cache: Separate L1 caches for instructions (L1-I) and data (L1-D) are present for each core. Typically, L1-I is 32KB, and L1-D is 32KB per core.
3. L2 Cache: Each core has a dedicated L2 cache, typically 512KB per core.
4. L3 Cache: A larger, shared L3 cache