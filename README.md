# COMP 590-154 Final Project (Spring 2020)

## Cloning this repository
First, remember to use the VMs we've alloted to your group. The course staff will not be able to help debug problems on your machine. Unfortunately, you cannot create a private fork of a public repository on GitHub. So, you must manually clone this repository, and push it to GitHub. The steps to do this are as follows:

1. Begin by creating a *private* repository on GitHub. You can get a free GitHub Pro account using your UNC email address. With GitHub Pro, you can create an unlimited number of private repositories. 
1. Add me to as a collaborator to your repository. My GitHub ID is aakshintala.
1. Run the following on your VM
```shell
git clone https://github.com/aakshintala/comp590-154Project project
cd project
git remote rm origin
git remote add origin <your github repo url>
git remote add handout https://github.com/aakshintala/comp590-154Project
git push origin --all
```

This allows you to be able to do development on your private repo, but if I were to fix any bugs in the hand out, you can also fetch those changes easily by doing a git pull handout.

When it's time to submit your projects, create a tag using `git tag` something like 'project-submission' and mention it and the link to the repository in your project write up.


## Tools

The following tools are installed on your VMs:
* `verilator`
* `gtkwave`
* RISCV toolchain (typically don't have to use this)

To use `gtkwave`, you need to ssh to your VM using `-Y` (or `-X`) options to enable tunneling.


## Building/Running your simulator code

Following are the commands to build and run the code:
```shell
make       # build code
make run   # run code
```
The result of running the code will be a `trace.vcd` waveform file. You can view it using `gtkwave` or `dinotrace` by tunneling X11 through ssh, or you can download the file to your local machine and view it there.

To change the program binary which you are decoding, edit the following line in `Makefile`:
```shell
RUNELF=...
```


## Viewing the `trace.vcd` waveform

If you have logged in to the server using the `-Y` or `-X` option, you can view waveforms using the following command:
```shell
gtkwave trace.vcd
```
You can also use `dinotrace`, or download the `.vcd` to view it.


## Submitting your code

More to come.


## What to implement?

You should implement a cache and a processor core in SystemVerilog. Your cache, on the one hand, interfaces with the processor and, on the other hand, with the main memory. We are going to use the AXI bus to communicate with main memory and other off chip signals.
Refer to https://static.docs.arm.com/ihi0022/e/IHI0022E_amba_axi_and_ace_protocol_spec.pdf.

We have provided the skeleton code for your cache including an SRAM module that you should instantiate in your cache to implement the data, tag and state arrays. Read the code in `system.cpp` to understand how your cache should interact with the main memory. Your cache may include a maximum of 16 64B cache lines, so that you're forced to actually evict data and instructions.

`Top.sv` and C++ code for emulating the main memory.


## How to proceed?
1. Start by reading the SRAM code. Make sure you understand how it works.  Then try to figure out how to instantiate state, tag and data arrays of your cache as separate SRAM instances.  Note that you will need to set the SRAM parameters differently for each of these three instantiations.

1. Read the code in `system.cpp` to understand how the memory interface---the interface between your cache and the memory controller---works. You will need to refer to the AXI4 manual above to understand the bus protocol we're emulating.

1. Write the code to handle a cache hit. This should be straightforward.  Think about the differences between reads and writes.  For reads, tag check and data read can happen in parallel. For writes, data will be written after tag check if the latter indicates a hit.  Based on this observation, should you keep tag and data in the same SRAM array, or in separate ones?  How about the state bits? Do you need a separate SRAM for those as well, or can you keep them with the tag bits?

1. Write the code to handle a cache miss.  Note that, to handle a cache miss, you typically need to kick-out an existing cache block to make room for the new one.  If the block-to-be-booted is dirty, it needs to be written back to the memory before you can replace it.  If the block is clean, however, you can just discard it. Then, you can read the new block from the memory, put it in the cache, and then perform the requested operation.  This whole process of miss-handling will inevitably be a multi-cycle process.

1. Prepare a testbench to make sure your cache works properly, under all possible read/write sequences.

1. Once you have a working cache, design your processor core. Design the interconnect between your cache and core, and the signals that the core must receive from top, and build out your core!


HAPPY HACKING!