# Using Ada tasks for for-loops

My research interests are in an area of computational science where a single code might, on a single CPU core, run for days or even weeks. The vast majority of that time is consumed by for-loops manipulating large multi-dimensional arrays of floating point data. The purpose of this little repository is to share my experiments and results in using Ada's native mutitasking tools to spread that computational load across multiple CPU cores.

The executive summary? Ada does a great job (but of course it does 😎)

The detailed account can be found in pdf file `doc/for-loop-tasking.pdf`.

## The target code

All of the examples are based on the following Ada template

```ada
loop

   for ... loop
     --> do someting useful
   end loop;

   for ... loop
     --> do more useful things
   end loop;

   for ... loop
     --> and one more time for fun
   end loop;

   exit when --> some exit condition

 end loop;
```

The underlying maths and physics dictates (trust me) that

  * Parallel execution is allowed **only** on the three inner loops and
  * The three inner loops must be run in **strict sequential order**.

This means that Ada's multitasking must be applied **only** to the three inner for-loops.

## Example codes

The example codes that I played with can be found in the `examples` directory. This is a self contained collection of programs with a handful of support files.

The examples cover the rendezvous and protected object models of multitaksing. Also, in some examples, the tasks are created **outside** the outer loop (and thus survive for the whole duration of the main program). In other examples, the tasks are created and destroyed by the **inner** loops on an as-needs-basis. In all cases the codes run with almost identical performance (see the table below).

Each example comes in two versions. Version "a" prints copious output just to prove that the code is doing what it should be doing. This is just a proof of concept. Version "b" prints only the total execution time. This is useful in showing that the execution times vary inversely with the number of CPU cores used (i.e, doubling the number of tasks halves the execution time).

Each example can be compiled and run using a matching shell script. So, for example, to compile and execute `ex2b.adb` you can use

```sh
$ cd examples
$ ex2b.sh
```

These shell scripts use `gprbuild` to compile the file and the associated support libraries.

Each example accepts various command line options with default values hard coded in the Ada source.

```sh
$ ex2b.sh --NumTasks 12 --NumLoops 2 --NumData 100000 --RndScale 0.0001

```
|  Option     | Deescription |
|------------:|:-------------|
| \-\-NumTasks | The number of tasks to use. |
| \-\-NumLoops | The number of iterations of the outermost loop. |
| \-\-NumData  | The length of the data array to be processed by each inner for-loop. |
| \-\-RndScale | Sets the scale of the random floating point numbers used to control the duration of each task. |

## Performance

Here is a short summary of the execution time in seconds for each example. These were run on a 20 core Mac Studio using ``--NumTasks N --NumLoops 1 --NumData 1000000 --RndScale 0.0001``. The pair of examples ``lwt1`` and ``lwt2`` use the [Light-Weight Threading library][1] from the ParaSail repository. They are included here simply for comparitive purposes.

| N | ex1b | ex2b | ex3b | ex4b |lwt1b | lwt2b |
|---:|----:|----:|----:|----:|----:|----:|
| 1 |178.8 |178.1 | 178.2 | 178.6 | 178.2 |177.9|
| 2 | 88.7 | 88.7 |  88.9 |  88.8 |  88.4 | 88.4|
| 4 | 44.2 | 44.3 |  44.3 |  44.2 |  44.3 | 44.3|
| 8 | 22.2 | 22.1 |  22.1 |  22.1 |  22.2 | 22.2|
|16 | 11.3 | 11.3 |  11.3 |  11.3 |  11.3 | 11.3|
|32 | 10.6 | 10.6 |  10.6 |  10.6 |  10.5 | 10.5|
|64 | 10.9 | 10.9 |  10.9 |  10.8 |  10.7 | 10.8|

The table shows the exepcted inverse linear behaviour until all CPU cores are exhausted (by number, not by fatigue 😎).

## Dependancies

All that is needed to run these codes is a working Ada compiler that supports `gprbuild`. If you already have `gprbuild` installed, then you are good to go. The example codes should compile as is.

If you do need to install Ada and its friends, the easiest way to do so is to first install `alr` (the command line tool for Alire, the Ada package manager). You can download a binary from the [ada-lang.io][4] and then follow [these][5] installation instructions. This will instal `alr` but not, at that point, the Ada toochain. That is done (behind the scences) when you first attempt to compile any of the example codes. There will be a short delay while Alire downloads the toolchain (just once). The Ada toolchain will be installed in the directory `~/.local/share/alire/`.

## Unistall

Really? If you must, then it's very simple -- just delete this directory.

## The bigger picture

These examples were not written entirely for fun -- I needed these tools for my research projects. The ideas developed here were used for the numerical computations (all done in pure Ada) in this [paper][2]. A simplified (and improved) version of the Ada source can be found on this GitHub [repo][3]. Note that the results given in the [paper][2] are for a much broader class of problems than that given by the Ada code in the GitHub [repo][3].

## License

All files in this collection are distributed under the [MIT][6] license. See the file LICENSE.txt for the full details.

 [1]: https://github.com/parasail-lang/parasail/tree/main/lwt
 [2]: https://arxiv.org/abs/1505.00067
 [3]: https://github.com/leo-brewin/adm-bssn-numerical-ada
 [4]: https://ada-lang.io
 [5]: https://github.com/alire-project/alire/blob/master/doc/getting-started.md
 [6]: https://opensource.org/licenses/MIT
