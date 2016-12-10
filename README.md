## Introduction

Welcome to the StrataCode java to javascript converter sample.  This is a sample project which includes a recent version of the StrataCode runtime in a project you can just checkout.

To set expectations, StrataCode is still in beta.  There are over 1M lines of Java from a bunch of sample projects in the test suite just to validate the Java processing.  The JavaModel api supports Java 8 on the parsing side, and internally validates that code by converting them to anonymous inner classes.   

## Limitations

The JS converter has been tested on about 200K lines of Java code, without workarounds.  There's a subset of the Java 6 APIs supported but often new APIs can be added by simply copying additional files from into a layer which extends js.sys and using that layer instead.  In this way, it's easy to build up different API profiles to limit the size of the generated JS files (but still share these files across multiple applications which is useful for caching).

The Javascript converter uses a slightly modified subset of the Apache Java sys and util classes and implements native JS for others.  Unfortunately the apache classes do not support lambda features and stopped at Java 6 in tracking the APIs.  There has been no testing of the lambdas or some of the more complex features of Java in the converter but Jeff is available to fix any problems you find, particularly if we can add some code you provde to the test suite.   We would like a version which uses the OpenJDK classes to really test lambdas but just haven't gotten around to testing that out.   Internally, lambdas are converted to anonymous inner classes during the code conversion, for validation purposes but they could just as easily be 'saved' to do a Java 8 to Java 6 conversion, and then to use those features in Javascript.   There is one subtle difference in how 'this' is treated in method references that we need to workaround via code-generation that should be a day or two to fix, but that only affects some method references.  

Otherwise, the major limitation in the converter is an obvious one - all number types in Java (int, float, Integer, etc) are converted to Javascript's single number type.  We could easily add selective workarounds for this feature by writing specific Integer, Float, Double classes (probably a native implementation just to be most efficient) and then use these selectively at code-gen time.  Some of the time you want to do that and sometimes you don't so it's not an easy choice, but with layers and annotation layers you will be able to customize that without modifying the original source code.  You can set a default for a subset of files and override for specific classes, fields, methods, etc. 

## Getting Started

First install the coreFramework bundle of layers in the bundles directory. From this directory:

    (cd bundles; git clone https://github.com/stratacode/coreFramework)

Put the StrataCode/bin directory in your path.  The sample files are in bundles/userLayers/sampleLayer/

From this directory run:

     scc -v -a sampleLayer

it should open your browser and in the JS console you'll see messages printed from the code.

Look at bundles/userLayers/sampleLayer/sampleLayer.sc for the sample's layer definition file.  It is like the build.gradle file but using Java with StrataCode extensions.  It always has the same name as the directory it is in.

In this sample, the sampleLayer.sc file contains annotations that affect how the files in that layer are converted to Javascript, mainly using the JSSettings annotation (e.g. what file to put them into, what package prefix to use, etc).  It can extend other layers so modularize your code from the build perspective.

Any layer can also override files in layers that it extends. 

Look in bundles/coreFramework/js for the layers that control the Java to JS conversion.  There's not a great separation right now of the layers used for pure Java conversion and the web framework but that will be easy to fix.

The sampleLayer extends the js.allInOne.main layer which puts all of the code in your project into a single set of Javascript files.  It's less dependent on the StrataCode web framework than js.appPerPage.main and those dependencies can be removed out by overriding files (or we should create a new core-generic layer which is completely independent of the web framework, and one that works with NodeJS).

One of the problems of converting between Java and JS is the potential for handling special cases that arise.  Using annotations you can workaround these problems in the generated code.  If you can't modify the source, you can add "annotation layers" which just add annotations using a StrataCode 'modify' operator (i.e. just putting "@JSSettings(...) MyClass {}"  in the right file in a layer which extends the layer containing MyClass.

See [the javadoc](http://www.stratacode.com/javadoc/sc/js/JSSettings.html)
# jsConverterSample

See your generated javascript file in the js/sample.js file from "Source" view in the browser, or on the file system in: build/sampleLayer/web/js/sample.js.

## Mapping Java classes to JS files

There are two basic ways this works.  You can use the JSSettings(jsModuleFile=) annotation to specify a fixed Javascript file for a collection of classes (or individual class).  This works great for libraries where you want to share the code between different applications, or want to control the file mapping.

If you do not assign a JSSettings(jsModuleFile) annotation, only code which is accessible via an entryPoint class is included in the JS file for the entry point.  This is a nice way to selectively drag in only the code used and build up one big JS file with all of that code.

When you set jsLibraryFile on the JSSettings annotation, it is not converted, but instead the library file is expected to include a native implementation of the Java class (i.e. authored in JS).

There's a way to replace method and field names if there are any naming conflicts.  If a class has a field and method with the same name, that's automatically handled by adding an _ to the field name.

## Important Files

* js/jvsys.js - generated Java java.sys, java.util classes from Apache 8 Java classes in coreFramework/js/sys - Note these files are named '.scj' only for the IntelliJ plugin so they are mapped as StrataCode files, not the native Java engine.
* js/javasys.js - natively written Java classes java.sys, java.util classes (copied from coreFramework/js/core/js)
* js/sccore.js - core functions used in the generated JS templates  (also from coreFramework/js/core/js)

* js/tags.js,  - not used in this sample - the SC web framework.  We need to create a base-layer which does not include this and other SC framework JS files but you can just ignore them for now.

* ./bundles/coreFramework/js/prebuild/JSTypeTemplate.sctjs - this is a Stratacode template file which is used to generate a JS class from a high-level code model object.  It gives you the opportunity to change many aspects of the generated Javascript code, such as the APIs to create a new class.  Other customizations can be done through annotations or by using the APIs provided in the StrataCode language runtime.

## Notes about 'scc'

With the scc command, use the -a option for now as the incremental builds are not very reliable.  Use the -v option to both turn on verbose to see what it's doing.  There is a -help option showing the large range of features scc supports.   Use the -c option to generate the code only without running anything.  You can disable the command-line interpreter with -ni.
