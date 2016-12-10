# StrataCode Install Directory

StrataCode is a Java preprocessor, build tool, and language extensions.  It includes a command-line interpreter and also an IntelliJ plugin.

## Using StrataCode

Run the command 'bin/scc' or put the 'bin' directory in your path and run 'scc'.   This command compiles and runs your
application all in one step.

You typically run the scc command with one or more layers to run.  
Run "scc -help" for a list of options.

## Developer Notes:

StrataCode comes with a very rich API.  The install distribution contains everything you need to develop and run StrataCode applications.

### Libraries

Found in the 'lib' directory:
  
    scrt.jar - the runtime files - needed by StrataCode applications which use any of the language features of StrataCode.
    scrt.jar - the StrataCode runtime required by the normal Java runtime
    scrt-core.jar - a minimal runtime that does not require reflection - used for the GWT integration
    sc.jar file - the JAR which contains all of StrataCode - it includes the scrt.jar so use this for developing SC applications.

