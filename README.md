
First install the coreFramework bundle of layers in the bundles directory. From this directory:

(cd bundles; git clone https://github.com/stratacode/coreFramework)

Put the StrataCode/bin directory in your path.  The sample files are in bundles/userLayers/sampleLayer/

From this directory run:

     scc -v -a sampleLayer

it should open your browser and in the JS console you'll see messages printed from the code.

Look at bundles/userLayers/sampleLayer/sampleLayer.sc for the layer definition file.  It is like the build.gradle file but using Java with StrataCode extensions.  It always has the same name as the directory it is in.

In this sample, the sampleLayer.sc file contains annotations that affect how the files in that layer are converted to Javascript using the JSSettings annotation (e.g. what file to put them into, what package prefix to use, etc).  It can extend other layers so modularize your code from the build perspective.

Any layer can also override files in layers that it extends. 

Look in bundles/coreFramework/js for the layers that control the Java to JS conversion.

The sampleLayer extends the js.allInOne.main layer which puts all of the code in your project into a single set of Javascript files.  It's less dependent on the StrataCode web framework than js.appPerPage.main and those dependencies can be removed out by overriding files (or we should create a new core-generic layer which is completely independent of the web framework, and one that works with NodeJS).

One of the problems of converting between Java and JS is the potential for handling special cases that arise, due to Number/Integer/Double differences or naming conflicts.  The JSSettings annotation supports ways to workaround these problems in the generated code.  If you can't modify the source, you can add "annotation layers" which just add annotations using a StrataCode 'modify' operator (i.e. just putting "@JSSettings(...) MyClass {}"  in the right file in a layer which extends the layer containing MyClass.

See (the javadoc)[http://www.stratacode.com/javadoc/sc/js/JSSettings.html]
# jsConverterSample
