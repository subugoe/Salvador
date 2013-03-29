Salvador - SUB Ant Library for Web Development
==============================================

#Introduction
This is a Library of [Apache Ant](http://ant.apache.org/) Tasks that might be useful for Web developers. The main purpose is the management of external tool dependencies, so you don't need to manage them by yourself. It is also able to use a embedded web server, precompile PHP files to static HTML and provides some Ruby tools like SASS and Compass.

#Modules
Lockated in the modules sub directory.
* scm.xml - Tasks for [Subversion](http://subversion.tigris.org/) and [Git](http://git-scm.com/)
* jetty.xml - Tasks for [Jetty](http://jetty.codehaus.org/jetty/)
* javascript.xml - Several dependencies for JavaScript related development
* jruby.xml - [JRuby](http://jruby.org/) mainly used by sass.xml and compass.xml
* compass.xml - [Compass](http://compass-style.org/) CSS tools
* sass.xml - [SASS](http://sass-lang.com/) CSS tools
* php.xml - Integrated [PHP](http://quercus.caucho.com/) compiler
* exist.xml - integration of [eXist]() related tasks
* tinypng.xml - integration of the [TinyPNG](http://tinypng.org/) web service (you need a API key to use this)

##Unfinished modules
* envjs.xml - [EnvJS](https://github.com/envjs/env-js) integration (not finished)
* jekyll.xml - [Jekyll](https://github.com/mojombo/jekyll) integration (doesn't work since stupid Jekyll relies on native crap)

#Usage
##Basics
To use the libraries import the desired module in your Ant project:

>&lt;import file=&quot;./build/modules/jetty.xml&quot;/&gt; 

Add the requested task as a dependency of your task:
>  &lt;target name=&quot;war.run&quot; depends=&quot;salvador.jetty.install&quot;/&gt;

Then either use the dependency declarations of your Ant tasks to get the functionality of the required tools and libraries (for dependency related tasks) or use the supplied macros for specific functionality.
##Naming of tasks
* Tasks containing "download" in their name, get the libraries and set up the classpath accordingly, you can use them to create your own macros.
* Tasks containing "install" in their name rely on the download and set up macro definitions.

##build.xml
This is the base package of Salvador, it provides Maven tasks and Ant enhancements.
###Additional Tasks
* The target **salvador.base.ant.httptask.install** provides the [Missing Link Ant HTPP Tasks](http://code.google.com/p/missing-link/)
* The target **salvador.base.ant.contrib.install** provides the [Ant Contrib Tasks](http://ant-contrib.sourceforge.net/)
* The target **salvador.base.maven.install** provides the [Maven Ant Tasks](http://maven.apache.org/ant-tasks/)

##scm.xml
This file provides Git and Subversion integration.
###Additional Tasks
* User the target **salvador.scm.jgit.install** to get the [JGIT Ant Tasks](http://wiki.eclipse.org/JGit/User_Guide#Ant_Tasks)

###Macros
* **salvador.scm.svn.co**, part of the target  **salvador.scm.svn.install**, takes the attributes 'url' and 'todir' to check out the latest revision of a subersion retository.

##jetty.xml
This file provides Jetty integration.
###Additional Tasks
* The target **salvador.jetty.install** provides the [Jetty Ant Tasks](http://docs.codehaus.org/display/JETTY/Ant+Jetty+Plugin)

###Macros
* The target **salvador.jetty.install** also provides the macro **salvador.jetty.run**: It takes the attributes 'path', 'webxml' (might be empty), 'port' (default: 8080), 'contextpath' (default: /ant) and 'name' (default: ant). This is a wrapper around the &lt;jetty&gt; task.

##javascript.xml
This file provides several JavaScript tools.
###Additional Tasks
* The target **salvador.js.jsdoctoolkit.install** provides the [JSDoc Ant Tasks](https://github.com/ironsidevsquincy/jsdoc-toolkit-ant-task)

###Macros
The target **salvador.js.yui.install** provides the following [YUI](http://yuilibrary.com/) tasks: 
* **salvador.js.yui.compress.js**: Takes a 'src' and 'destfile' attribute and compress a JS file.
* **salvador.js.yui.compress.css**: Takes a 'src' and 'destfile' attribute and compress a CSS file.

##jruby.xml
This file provides JRuby. I's mainly used by SASS and Compass, but can also be used to get access to other Ruby Gems. It operate on an internal JRuby distribution, not the one provided by your system.
###Macros
The target **salvador.jruby.gems** provides two macros:
* **salvador.jruby.gem.check** checks if the ruby Gem given by the attribute 'gem' is installed. Check the property **salvador.jruby.gem.check.return.code** for the value '0' (zero).
* **salvador.jruby.gem.install** installs the ruby Gem given by the attribute 'gem'

##compass.xml
This file provides Compass related tasks.
###Additional Tasks
###Macros

##sass.xml
This file provides SASS related tasks.
###Macros
* The target **salvador.sass.install** provides the macro **salvador.sass.compile.watch**. It takes two attributes 'src' and 'dest'. It watches the 'src' directory and writes changes to the 'dest' directory using the poll method. 

##php.xml
This file provides an PHP compiler.
###Macros
* **salvador.php.compile**: Takes a 'src' and 'destfile' attribute, compiles PHP files to static HTML (or whatever the PHP file emits)

##exist.xml
###Additional Tasks
* The target **salvador.exist.install** provides the [eXist Ant Tasks](http://www.exist-db.org/exist/apps/doc/ant-tasks.xml) 

##tinypng.xml
###Additional Tasks
* The target **salvador.tinypng.install** provides the macro **salvador.tinypng.compress**: It takes a 'src' and 'destfile' attribute, sends the provided image to TinyPNG and saves the result. Make sure you set the property **salvador.tinypng.apikey**, containing your API key.

#Examples
This section provides some examples.
## Running a web application with Jetty and Compass
Make sure you import the required modules:
>&lt;import file=&quot;./build/modules/jetty.xml&quot;/&gt;

>&lt;import file=&quot;./build/modules/compass.xml&quot;/&gt;

#Development
In the test directory is a test.xml which can by run by
>ant -f test/test.xml

It calls every target configured, if you add a module create a target for it in test.xml, to be sure that every target works without any arguments. 