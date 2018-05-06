.. _doc_documentation_guidelines:

Documentation guidelines
========================

This page describes the rules to follow if you want to contribute to Godot
Engine by writing or reviewing documentation, or by translating existing
documentation.

How to contribute
-----------------

Creating or modifying documentation pages is mainly done via the
`godot-docs GitHub repository <https://github.com/airdata/godot-docs>`_.
The HTML (or PDF and EPUB) documentation is generated from the .rst files
(reStructuredText markup language) in that repository. Modifying those pages
in a pull request and getting it merged will trigger a rebuild of the online
documentation.

.. seealso:: For details on Git usage and the pull request workflow, please
             refer to the :ref:`doc_pr_workflow` page. Most of what it
             describes regarding the main godotengine/godot repository is
             also valid for the docs repository.

The README.md file contains all the information you need to get you started,
please read it. In particular, it contains some tips and tricks and links to
reference documentation about the reStructuredText markup language.

.. warning:: If you want to edit the **API reference**, please note that it
             should *not* be done in the godot-docs repository. Instead, you
             should edit the ``doc/classes/*`` XML files of Godot's
             main repository. These files are then later used to generate the
             in-editor documentation as well as the API reference of the
             online docs. Read more here: :ref:`doc_updating_the_class_reference`.

What makes good documentation?
------------------------------

Documentation should be well written in plain English, using well-formed
sentences and various levels of sections and subsections. It should be clear
and objective.

We differentiate tutorial pages from other documentation pages by these
definitions:

-  Tutorial: a page aiming at explaining how to use one or more concepts in
   the editor or scripts in order to achieve a specific goal with a learning
   purpose (e.g. "Making a simple 2d Pong game", "Applying forces to an
   object").
-  Documentation: a page describing precisely one and only one concept at a
   time, if possible exhaustively (e.g. the list of methods of the
   Sprite class, or an overview of the input management in Godot).

You are free to write the kind of documentation you wish, as long as you
respect the following rules (and the ones on the repo). In particular, you
can contribute tutorials in the "Community" section of the docs, where they
could be merged relatively easily, improved by other contributors and
eventually moved to an "official" section if relevant.

Titles
------

Always begin pages with their title and a Sphinx reference name:

::

    .. _doc_insert_your_title_here:

    Insert your title here
    ======================

The reference allows to link to this page using the ``:ref:`` format, e.g.
``:ref:`doc_insert_your_title_here``` would link to the above example page
(note the lack of leading underscore in the reference).

Also, avoid American CamelCase titles: title's first word should begin
with a capitalized letter, and every following word should not. Thus,
this is a good example:

-  Insert your title here

And this is a bad example:

-  Insert Your Title Here

Only project, people and node class names should have capitalized first
letter.

Translating existing pages
--------------------------

For the moment, only English documentation is provided. We want to propose
localized documentation in the future, but this is not a priority for now.
Indeed, since the English documentation is still evolving a lot as the
community improves it and make it more professional, we prefer that
translators do not spend too much time on it, as their translated
documentation might quickly grow out of sync with the original.

When the English documentation is ready for translations, we will provide
tools to simplify the work of translators by tracking changes to the English
docs that they should translate on their end.

License
-------

This documentation and every page it contains is published under the terms of
the Creative Commons Attribution 3.0 license (CC-BY-3.0), with attribution to
"Juan Linietsky, Ariel Manzur and the Godot community".

By contributing to the documentation on the GitHub repository, you agree that
your changes are distributed under this license.
