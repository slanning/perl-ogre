Perl-Ogre
=========

This is a Perl binding for OGRE, Object-Oriented Graphics Rendering Engine,
a C++ library found at http://www.ogre3d.org/ .

The wrapping is currently incomplete, but there are several interesting
examples working now (see examples/README.txt).
See TODO.txt for the things I'd like to do. Suggest more things
(preferably submitted with patches) if you like.

My aim is mostly to be able to run OGRE's samples and tutorials from Perl.
(The tutorials and documentation for OGRE are excellent.
I highly recommend going through them before trying this Perl wrapper.)


DEPENDENCIES

Only versions >= 1.6.1 of OGRE are currently supported, so you need to install
that either by building from source or by installing a package.
(In fact, I have version 1.6.3, and I'm just assuming that 1.6.1 will work.)
If you use Ubuntu, I have some notes below that might help.
You need to install the "dev" versions of packages, since this module
links against the libraries.

Makefile.PL uses pkg-config to get information about the libraries and header
files needed to build against OGRE, so you should be able to do this:

  pkg-config --libs OGRE
  pkg-config --cflags OGRE
  pkg-config --modversion OGRE

The last one should say at least 1.6.1.

The C++ compiler used by default is `g++`, but you can specify a different
C++ compiler by setting the CXX environmental variable. Anything more,
and you'll have to hack at Makefile.PL.

I have the impression that OGRE doesn't install pkg-config on Windows
(though nobody ever answers when I ask...), so this package will probably
not currently work on Windows. I'd like it to, but I don't use Windows.
Please let me know how if you get it working. Patches for Mac OS would
be welcome as well (in particular, look in Ogre/ExampleApplication
for "macBundlePath").


OPTIONAL

If you have Gtk2 installed, which in practice means that the following
outputs a version number:

  pkg-config --modversion gtk+-2.0

then a static method, Ogre->getWindowHandleString, will be built.
The string returned can be passed to the `params' argument of
Ogre::Root::createRenderWindow in order to use a window (widget)
already created by gtk2-perl or wxPerl, thereby letting you embed
an Ogre widget in a GUI application. This feature is currently
EXPERIMENTAL, meaning its usage might change in the future
or be dropped altogether if it doesn't work.

Some scripts under examples/ require these Perl modules:

 - OIS
 - Readonly   (I'm going to remove that..)

I recommend installing both of them, but you don't have to. 

It would be best to install at least version 0.05 of my OIS module,
which works with version 1.2 of libois.

It would be a good idea to make sure you also have installed CEGUI, OIS,
libdevil, and nVidia Cg, if those aren't already installed. This Perl module
currently only provides support for OGRE and OIS, however.
The reason I recommend installing those libraries, is mainly just so
you can run the (C++) tutorials for comparison.


INSTALLATION

To install this module, do the usual:

   perl Makefile.PL
   make
   make test
   make install

You might have to edit Makefile.PL to get it to work for your system.
If so, please let me know.


INSTALLING OGRE UNDER UBUNTU

Here's how I got setup on Ubuntu Jaunty

There is a nice howto for compiling things manually at
http://ubuntuforums.org/archive/index.php/t-1144592.html

That may be fulfilling for some people,
but there are also updated packages at
https://launchpad.net/~andrewfenn/+archive/ogredev

  sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 6FED7057

  sudo gedit /etc/apt/sources.list

add these lines

  deb http://ppa.launchpad.net/andrewfenn/ogredev/ubuntu jaunty main
  deb-src http://ppa.launchpad.net/andrewfenn/ogredev/ubuntu jaunty main 

then install the Ogre-related packages

  sudo apt-get update
  sudo apt-get install  \
    blender-ogrexml     \
    cegui-layout-editor \
    libcegui            \
    libmygui            \
    libmygui-dev        \
    libogre-dev         \
    libogremain-1.6.3   \
    libois-dev          \
    libois1             \
    libsilly0           \
    nvidia-cg-toolkit   \
    ogre-doc            \
    ogre-tools

and remove any lingering "old" packages:

  sudo apt-get remove ogre-doc-nonfree
  sudo apt-get autoremove

Make sure that OIS is version 1.2.0 and ogre libs are 1.6.3.

You might also want the official Ogre sources at
http://www.ogre3d.org/developers/subversion

I checked out both trunk and the 1.6 branch with:

  cd
  svn co https://svn.ogre3d.org/svnroot/ogre/trunk         \
         https://svn.ogre3d.org/svnroot/ogre/branches/v1-6 \
           ogre

To build it yourself, see:
http://www.ogre3d.org/wiki/index.php/CMake_Quick_Start_Guide#Linux_.2F_Unix

and good luck....


COPYRIGHT AND LICENCE

Please report any bugs/suggestions to <slanning@cpan.org>.

Copyright 2007-2009, Scott Lanning. All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

Note that OGRE itself is under an LGPL license. See http://www.ogre3d.org/
for more (and probably more accurate) information.
(Further note: they announced just today that version 1.7 on will be
under the MIT license.)
