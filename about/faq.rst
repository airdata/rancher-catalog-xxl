.. _doc_faq:

Frequently asked questions
==========================

What can I do with Godot? How much does it cost? What are the license terms?
----------------------------------------------------------------------------

Godot is Free/Libre Open Source Software available under the `OSI-approved <https://opensource.org/licenses/MIT>`_ MIT license.

This means it is free as in "free speech" as well as in "free beer".

In short:

* There are no usage restrictions on Godot
* This means you can use it for any game or application, commercially or non-commercially, in any industry
* You can modify, (re)distribute and remix Godot to your heart's content

For more, see `here <https://tldrlegal.com/license/mit-license>`_ or ask your lawyer of choice.

All the contents of the documentation are under the permissive Creative Commons Attribution 3.0
(`CC-BY 3.0 <https://creativecommons.org/licenses/by/3.0/>`_) license, with
attribution to "Juan Linietsky, Ariel Manzur and the Godot Engine community".

Logos and icons are generally under the same Creative Commons license. Note that some third-party libraries
included with Godot's source code may have different licenses.

For full details, look at the `COPYRIGHT.txt <https://github.com/airdata/godot/blob/master/COPYRIGHT.txt>`_
as well as the `LICENSE.txt <https://github.com/airdata/godot/blob/master/LICENSE.txt>`_ and `LOGO_LICENSE.txt <https://github.com/airdata/godot/blob/master/LOGO_LICENSE.md>`_ files in the Godot repository.

Also see `the license page on the Godot website <https://godotengine.org/license>`_.

Which platforms are supported by Godot?
---------------------------------------

**For the editor:**

* Windows
* Mac OS X
* X11 (Linux, \*BSD)

**For exporting your games:**

* Windows (and UWP)
* Mac OS X
* X11 (Linux, \*BSD)
* Android
* iOS
* Web

Both 32 and 64 bit binaries are supported where it makes sense, with 64 being the default.

Some users also report building and using Godot successfully on ARM-based system with Linux, like the Raspberry Pi.
There is also some unofficial thirdparty work being done on building for some consoles.
None of this is included in the default build scripts or export templates, however.

For more on this, see the sections on :ref:`exporting <toc-learn-workflow-export>` and :ref:`compiling Godot yourself <toc-devel-compiling>`.

Which languages are supported in Godot?
---------------------------------------

The officially supported languages for Godot are GDScript, Visual Scripting, C# and C++.
See the subcategories for each language in the :ref:`scripting <toc-learn-scripting>` section.

Note that C# and Visual Scripting support is comparatively young and GDScript still has
some advantages as outlined below.

Support for new languages can be added by third parties using the GDNative / NativeScript / PluginScript facilities.
(See question about plugins below.)

Work is currently underway, for example, on unofficial bindings for Godot
to `Python <https://github.com/touilleMan/godot-python>`_ and `Nim <https://github.com/pragmagic/godot-nim>`_.

GDScript? Why use a custom scripting language instead of my language of choice?
-------------------------------------------------------------------------------

The short answer is that we think the additional complexity both on your side
(when first learning Godot and GDScript) as well as our side (maintenance)
is worth the more integrated and seamless experience over
attracting additional users with more familiar programming languages that result
in a worse experience. We understand if you would rather use another language
in Godot (see list of supported options above),
but we strongly encourage you to try it and see the benefits for yourself.

GDScript is designed to integrate from the ground to the way Godot
works, more than any other language, and is very simple and easy to
learn. Takes at most a day or two to get comfortable and it's very easy
to see the benefits once you do. Please do the effort to learn
GDScript, you will not regret it.

Godot C++ API is also efficient and easy to use (the entire Godot
editor is made with this API), and an excellent tool to optimize parts
of a project, but trying to use it instead of GDScript for an entire
game is, in most cases, a waste of time.

Yes, for more than a decade we tried in the past integrating several
VMs (and even shipped games using them), such as Python, Squirrel and
Lua (in fact we authored tolua++ in the past, one of the most popular
C++ binders). None of them worked as well as GDScript does now.

More information about getting comfortable with GDScript or dynamically
typed languages can be found in the :ref:`doc_gdscript_more_efficiently`
tutorial.

For the more technically versed, proceed to the next item.

I don't believe you. What are the technical reasons for the item above?
-----------------------------------------------------------------------

The main reasons are:

1. No good thread support in most script VMs, and Godot uses threads
   (Lua, Python, Squirrel, JS, AS, etc.).
2. No good class extending support in most script VMs, and adapting to
   the way Godot works is highly inefficient (Lua, Python, JS).
3. Horrible interface for binding to C++, results in large amount of
   code, bugs, bottlenecks and general inefficiency (Lua, Python,
   Squirrel, JS, etc.)
4. No native vector types (vector3, matrix4, etc.), resulting in highly
   reduced performance when using custom types (Lua, Python, Squirrel,
   JS, AS, etc.).
5. Garbage collector results in stalls or unnecessarily large memory
   usage (Lua, Python, JS, AS, etc.).
6. Difficulty to integrate with the code editor for providing code
   completion, live editing, etc. (all of them). This is very well
   supported by GDScript.

GDScript was designed to solve the issues above, and performs very well
in all the above scenarios. Please learn GDScript and enjoy a
very smooth integration of scripting with the game engine (yes, it's a
rare but very enjoyable situation when things just work). It's worth
it, give it a try!

I want to extend Godot. What are my options for creating plugins?
-----------------------------------------------------------------

For creating Godot Editor plugins look at :ref:`EditorPlugins <doc_making_plugins>` and tool scripts.

Additional languages could be added via PluginScript or the more low-level NativeScript.

If you want to add a certain native library, your best bet is GDNative and custom C++ modules.

Also see the official blog posts on these topics:

* `A look at the GDNative architecture <https://godotengine.org/article/look-gdnative-architecture>`_
* `GDNative is here! <https://godotengine.org/article/dlscript-here>`_

You can also take a look at the GDScript implementation,
the Godot modules as well as the `unofficial Python support <https://github.com/touilleMan/godot-python>`_ for Godot.

Why is FBX not supported for import?
------------------------------------

FBX SDK has a very `restrictive license <http://www.blender.org/bf/Autodesk_FBX_License.rtf>`_,
that is incompatible with the `open license <http://opensource.org/licenses/MIT>`_
provided by Godot.

That said, Godot's Collada support is really good, please use the
`OpenCollada <https://github.com/KhronosGroup/OpenCOLLADA/wiki/OpenCOLLADA-Tools>`_
exporter for maximum compatibility if you are using Maya or 3DS Max.
If you are using Blender, take a look at our own
`Better Collada Exporter <https://godotengine.org/download>`_.

Also, glTF support was added in Godot 3.0.

FBX support could still be provided by third parties as a plugin. (See Plugins question above.)

Will [Insert closed SDK such as PhysX, GameWorks, etc.] be supported in Godot?
------------------------------------------------------------------------------

No, the aim of Godot is to create a complete open source engine
licensed under MIT, so you have complete control over every single
piece of it. Open versions of functionality or features from such SDKs
may be eventually added though.

That said, because it is open source, and modular, nothing prevents you
or anyone else interested into adding those libraries as a module and
ship your game using them, as either open or closed source. Everything
is allowed.

To see how support for your SDK of choice could still be provided, look at the Plugins question above.

How should assets be created to handle multiple resolutions and aspect ratios?
------------------------------------------------------------------------------

This question pops up often and it's probably thanks to the
misunderstanding created by Apple when they originally doubled the
resolution of their devices. It made people think that having the same
assets in different resolutions was a good idea, so many continued
towards that path. That originally worked to a point and only for
Apple devices, but then several Android and Apple devices with
different resolutions and aspect ratios were created, with a very
wide range of sizes and DPIs.

The most common and proper way to achieve this is to, instead, use a
single base resolution for the game and only handle different screen
aspects. This is mostly needed for 2D, as in 3D it's just a matter of
Camera XFov or YFov.

1. Choose a single base resolution for your game. Even if there are
   devices that go up to 2K and devices that go down to 400p, regular
   hardware scaling in your device will take care of this at little or
   no performance cost. Most common choices are either near 1080p
   (1920x1080) or 720p (1280x720). Keep in mind the higher the
   resolution, the larger your assets, the more memory they will take
   and the longer the time it will take for loading.

2. Use the stretch options in Godot, 2D stretching with keeping aspect
   works best. Check the :ref:`doc_multiple_resolutions` tutorial
   on how to achieve this.

3. Determine a minimum resolution and then decide if you want your game
   to stretch vertically or horizontally for different aspect ratios, or
   whether there is a minimum one and you want black bars to appear
   instead. This is also explained in the previous step.

4. For user interfaces, use the :ref:`anchoring <doc_size_and_anchors>`
   to determine where controls should stay and move. If UIs are more
   complex, consider learning about Containers.

And that's it! Your game should work in multiple resolutions.

If there really is a desire to make your game also work on ancient
devices with tiny screens (less than 300 pixels in width), you can use
the export option to shrink images, and set that build to be used for
certain screen sizes in the App Store or Google Play.

I have a great idea that will make Godot better. What do you think?
-------------------------------------------------------------------

Your idea will most certainly be ignored. Examples of stuff that is
ignored by the developers:

-  Let's do this because it will make Godot better
-  Let's do this in Godot because another game engine does it
-  Let's remove this because I think it's not needed
-  Let's remove clutter and bloat and make Godot look nicer
-  Let's add an alternative workflow for people who prefer it

Godot developers are always willing to talk to you and listen to your feedback
very openly, to an extent rarely seen in open source projects, but they
will care mostly about real issues you have while using Godot, not ideas
solely based on personal belief. Developers are interested in (for
example):

-  Your experience using the software and the problems you have (we
   care about this much more than ideas on how to improve it).
-  The features you would like to see implemented because you need them
   for your project.
-  The concepts that were difficult to understand in order to learn the
   software.
-  The parts of your workflow you would like to see optimized.
-  Parts where you missed clear tutorials or where the documentation wasn't up to par.

Once one of the above points is stated, we can work together on a
solution and this is where your ideas and suggestions are most valuable
and welcome, they need to be in context of a real issue.

As such, please don't feel that your ideas for Godot are unwelcome.
Instead, try to reformulate them as a problem first, so developers and
the community have a base ground to discuss first.

Examples of how NOT to state problems generally and vaguely are:

-  Certain feature is ugly
-  Certain workflow is slow
-  Certain feature needs optimization
-  Certain aspect of the UI looks cluttered

Associating something with an adjective will not get you much attention
and developers will most likely not understand you. Instead, try to
reformulate your problem as a story such as:

-  I try to move objects around but always end up picking the wrong one
-  I tried to make a game like Battlefield but I'm not managing to
   understand how to get lighting to look the same.
-  I always forget which script I was editing, and it takes me too many
   steps to go back to it.

This will allow you to convey what you are thinking much better and set
a common ground for discussion. Please try your best to state your
problems as stories to the developers and the community, before
discussing any idea. Be specific and concrete.

Bonus points for bringing screenshots, concrete numbers, test cases or example projects (if applicable).

How can I support Godot development or contribute?
--------------------------------------------------

See :ref:`doc_ways_to_contribute`.

Who is working on Godot? How can I contact you?
-----------------------------------------------

See the corresponding page on the `Godot website <https://godotengine.org/contact>`_.
