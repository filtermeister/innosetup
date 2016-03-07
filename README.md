FilterMeister plugin InnoSetup
==============================
MIT license applies

Inside you'll find a simple installer script you can use for your own
Photoshop plugins.  It uses InnoSetup to install both a 32-bit & 64-bit
plugin, and includes detection for the plugin folders of the most
popular graphics programs (Adobe Photoshop, Photoshop Elements, Corel
Paint Shop Pro, Serif Photoplus).  I've tried to make it really easy
to edit, as long as your needs are simple.

You'll need InnoSetup to use this, download it from:

http://www.jrsoftware.org

Tested with version 5.5.8, both non-Unicode and Unicode version.

The installer script itself is the .iss file, which you can open in
any text editor.  InnoSetup uses Pascal code for the tricky stuff,
but if you're familiar with C functions it shouldn't be too different.
Just load the .iss file in the InnoSetup Compiler Editor/IDE and press
the green Play button in the toolbar to compile it.

The installer is very basic, and doesn't include examples for extra
support files, Windows Start Menu program groups, or code signing.
You can probably figure that out yourself from the standard InnoSetup
examples & documentation, or wait until the FilterMeister Mailing List
folks figure out a more detailed example.  This should get you up
and running with the Photoshop Plugin specific parts though.

There may be bugs - the goal of this release was to give you something
that works enough for you to be able to make your own changes and
improvements.

Hope you find it useful!  If you have questions, you can email me
via the address / website below, or find me on the FMML Mailing List.

- Kohan Ikin
  syneryder@namesuppressed.com / kohanikin.com / namesuppressed.com
  22 February 2016
