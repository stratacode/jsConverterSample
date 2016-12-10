// This annotation is applied to all files in this layer unless they
// override it with their own JSSettings.   Setting jsModuleFile 
// here is required to establish that these files all belong in a specific
// javascript file.  If you do not specify a jsModuleFile, the files are
// placed into a pool which are lazily loaded into the JS files of any 
// entry points.  This mode is useful to avoid 
@sc.js.JSSettings(jsModuleFile="js/sample.js")
sampleLayer extends js.allInOne.main {
}
