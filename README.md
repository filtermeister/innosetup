FilterMeister plugin InnoSetup
==============================
MIT license applies

Inside you'll find a simple installer script you can use for your own
Photoshop plugins.  It uses InnoSetup to install both a 32-bit & 64-bit
plugin, and includes detection for the plugin folders of the most
popular graphics programs (Adobe Photoshop, Photoshop Elements, Corel
Paint Shop Pro, Serif Photoplus).

You'll need InnoSetup to use this, download it from:

http://www.jrsoftware.org

Tested with version 5.5.8, both non-Unicode and Unicode version.

Features
--------
*	Detects most popular graphics applications:
*	Easily configurable from single file.
*	Optional code signing.
*	20 languages supported.
*	Optional license confirmation and post-install readme.
*	Automatically detect 32-bit or 64-bit.
*	Install multiple files.
*	Separate install files for 32-bit and 64-bit.
*	Shared install files for both 32- and 64-bit.
*	Configurable look & feel.

Usage
-----
Copy the `install.iss` file and edit it for your own project. If you
have multiple projects, just copy the `install.iss` file multiple
times.


Detected graphics applications
------------------------------
*	Adobe Photoshop
*	Adobe Photoshop Elements
*	Computerinsel Photoline
*	Corel Paint Shop Pro
*	MediaChance Photobrush
*	Serif Photoplus
*	Ulead Photoimpact

Development
-----------
The installer script itself is the .iss file, which you can open in
any text editor. InnoSetup uses Pascal code for the tricky stuff,
but if you're familiar with C functions it shouldn't be too different.
Just load the .iss file in the InnoSetup Compiler Editor/IDE and press
the green Play button in the toolbar to compile it.

Common parts of the script are included from the `common` directory.
These files handle the locale (languages), autodetection of graphics
applications and the installation (copying) of the files.

The installer is very basic, and doesn't include examples for extra
support files, Windows Start Menu program groups, or code signing.
You can probably figure that out yourself from the standard InnoSetup
examples & documentation, or wait until the FilterMeister Mailing List
folks figure out a more detailed example.  This should get you up
and running with the Photoshop Plugin specific parts though.

Author
------
Hope you find it useful!  If you have questions, you can email me
via the address / website below, or find me on the FMML Mailing List.

- Kohan Ikin
  syneryder@namesuppressed.com / kohanikin.com / namesuppressed.com