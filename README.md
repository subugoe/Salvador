Salvador - SUB Ant Library for Web Development
===============================

#Introduction
This is a Library of Apache Ant Tasks that might be useful for Web developers. The main purpose is the management of external tool dependencies. It is also able to use a embedded web server or to precompile PHP files to static HTML.

#Modules
Lockated in the modules sub directory.
* scm.xml - Tasks for Subversion and Git
* jetty.xml - Tasks for Jetty
* javascript.xml - Several Dependencies for JavaScript related development
* jruby.xml - JRuby mainly used by compass.xml
* compass.xml - Compass CSS tools
* sass.xml - SASS CSS tools
* php.xml - Integrated PHP compiler

#Usage
##Basics
To use the libraries import the desired module in your Ant project:

'''xml
 <import file="./build/modules/jetty.xml"/> 
'''
The use the dependency declarations of your Ant tasks to get the functionality of the required tools and libraries (for dependency related tasks) or use the ant call mechanism to use specific functionality

##scm.xml

##jetty.xml

##javascript.xml

##jruby.xml

##compass.xml

##sass.xml

##php.xml

#Development
In the test directory is a test.xml which can by run by
>ant -f test/test.xml

It calls every target configured, if you add a module create a target for it in test.xml, to be sure that every target works without any arguments. 