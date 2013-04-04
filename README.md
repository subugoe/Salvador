Salvador - SUB Ant Library for Web Development
==============================================

#Introduction
This is a Library of [Apache Ant](http://ant.apache.org/) Tasks that might be useful for Web developers. The main purpose is the management of external tool dependencies, so you don't need to manage them by yourself. It is also able to use a embedded web server, precompile PHP files to static HTML and provides some Ruby tools like SASS and Compass.

#Modules
Lockated in the 'modules' sub directory.
* scm.xml - Tasks for [Git](http://git-scm.com/) and [Subversion](http://subversion.tigris.org/).
* jetty.xml - Tasks for [Jetty](http://jetty.codehaus.org/jetty/)
* javascript.xml - Several dependencies for JavaScript related development
* jruby.xml - [JRuby](http://jruby.org/) mainly used by sass.xml and compass.xml
* compass.xml - [Compass](http://compass-style.org/) CSS tools
* sass.xml - [SASS](http://sass-lang.com/) CSS tools
* php.xml - Integrated [PHP](http://quercus.caucho.com/) compiler
* exist.xml - integration of [eXist](http://www.exist-db.org/exist/apps/homepage/index.html) related tasks
* tinypng.xml - integration of the [TinyPNG](http://tinypng.org/) web service (you need a API key to use this)
* jtidy.xml - integration of [JTidy](http://jtidy.sourceforge.net/)

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
* The target **salvador.base.ant.httptask.install** provides the [Missing Link Ant HTTP Tasks](http://code.google.com/p/missing-link/)
* The target **salvador.base.ant.contrib.install** provides the [Ant Contrib Tasks](http://ant-contrib.sourceforge.net/)
* The target **salvador.base.maven.install** provides the [Maven Ant Tasks](http://maven.apache.org/ant-tasks/)

##scm.xml
This file provides [Git](http://git-scm.com/) and [Subversion](http://subversion.tigris.org/) integration.
###Additional Tasks
* User the target **salvador.scm.jgit.install** to get the [JGIT Ant Tasks](http://wiki.eclipse.org/JGit/User_Guide#Ant_Tasks)

###Macros
* **salvador.scm.svn.co**, part of the target  **salvador.scm.svn.install**, takes the attributes '*url*' and '*todir*' to check out the latest revision of a subersion retository.

##jetty.xml
This file provides [Jetty](http://jetty.codehaus.org/jetty/) integration.
###Additional Tasks
* The target **salvador.jetty.install** provides the [Jetty Ant Tasks](http://docs.codehaus.org/display/JETTY/Ant+Jetty+Plugin)

###Macros
* The target **salvador.jetty.install** also provides the macro **salvador.jetty.run**: It takes the attributes '*path*', '*webxml*' (might be empty), '*port*' (default: 8080), '*contextpath*' (default: /ant) and '*name*' (default: ant). This is a wrapper around the &lt;jetty&gt; task.

##javascript.xml
This file provides several JavaScript tools.
###Additional Tasks
* The target **salvador.js.jsdoctoolkit.install** provides the [JSDoc Ant Tasks](https://github.com/ironsidevsquincy/jsdoc-toolkit-ant-task)

###Macros
The target **salvador.js.yui.install** provides the following [YUI](http://yuilibrary.com/) tasks: 
* **salvador.js.yui.compress.js**: Takes a '*src*' and '*destfile*' attribute and compress a JS file.
* **salvador.js.yui.compress.css**: Takes a '*src*' and '*destfile*' attribute and compress a CSS file.

##jruby.xml
This file provides [JRuby](http://jruby.org/). I's mainly used by SASS and Compass, but can also be used to get access to other Ruby Gems. It operate on an internal JRuby distribution, not the one provided by your system.
###Macros
The target **salvador.jruby.gems** provides two macros:
* **salvador.jruby.gem.check** checks if the ruby Gem given by the attribute '*gem*' is installed. Check the property **salvador.jruby.gem.check.return.code** for the value '*0*' (zero).
* **salvador.jruby.gem.install** installs the ruby Gem given by the attribute '*gem*'

##compass.xml
This file provides [Compass](http://compass-style.org/) related tasks.
###Macros
* The target **salvador.sass.install** provides the macro **salvador.sass.compile.watch**. It takes two attributes '*src*' and '*dest*'. It watches the '*src*' directory and writes changes to the '*dest*' directory using the poll method.

##sass.xml
This file provides [SASS](http://sass-lang.com/) related tasks.
###Macros
The target **salvador.sass.macros** provides the following macros:
* **salvador.sass.convert.watch**: It takes two attributes '*src*' and '*dest*'. It watches the '*src*' directory and writes changes to the '*dest*' directory using the poll method.
* **salvador.sass.convert**: It takes two attributes '*src*' and '*destfile*'. It converts the '*src*' file and writes the result to '*destfile*'.
* **salvador.sass.convert.dir**: It takes two attributes '*refid*' and '*todir*'. It converts the fileSet given by the reference '*refid*' file and writes the result to '*todir*' using **salvador.sass.convert**.

##php.xml
This file provides an [PHP](http://php.net/) [compiler](http://quercus.caucho.com/).
###Macros
* The target **salvador.tinypng.macros** provides the macros:
* **salvador.php.compile**: Takes a '*src*' and '*destfile*' attribute, compiles PHP files to static HTML (or whatever the PHP file emits)
* **salvador.php.compile.dir**: It takes three attributes '*refid*', '*todir*' and suffix (default ".html"). It converts the fileSet given by the reference '*refid*' file and writes the result to '*todir*' using **salvador.php.compile**, use another '*suffix*' if the results shouldn't end with html.

##exist.xml
This file provides integration of [eXist](http://www.exist-db.org/exist/apps/homepage/index.html).

**Warning**: this takes some time on the first usage, since it needs to fetch a complete eXist distribution.
###Additional Tasks
* The target **salvador.exist.install** provides the [eXist Ant Tasks](http://www.exist-db.org/exist/apps/doc/ant-tasks.xml) 

##tinypng.xml
This file provides integration of the [TinyPNG](http://tinypng.org/) web service.

**Note**: You need a API key to use this
###Additional Tasks
* The target **salvador.tinypng.macros** provides the macros:
* **salvador.tinypng.compress**: It takes a '*src*' and '*destfile*' attribute, sends the provided image to TinyPNG and saves the result. Make sure you set the property **salvador.tinypng.apikey**, containing your API key.
* **salvador.tinypng.compress.dir**: It takes two attributes '*refid*' and '*todir*'. It converts the fileSet given by the reference '*refid*' file and writes the result to '*todir*' using **salvador.tinypng.compress**.

##jtidy.xml
This file provides integration of [JTidy](http://jtidy.sourceforge.net/).
###Additional Tasks
* The target **salvador.jtidy.install** provides the [JTidy Ant Tasks](http://jtidy.sourceforge.net/apidocs/org/w3c/tidy/ant/JTidyTask.html).

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