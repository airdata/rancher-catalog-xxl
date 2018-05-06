.. _doc_gdscript:

GDScript
========

Introduction
------------

*GDScript* is a high level, dynamically typed programming language used to
create content. It uses a syntax similar to
`Python <https://en.wikipedia.org/wiki/Python_%28programming_language%29>`_
(blocks are indent-based and many keywords are similar). Its goal is
to be optimized for and tightly integrated with Godot Engine, allowing great
flexibility for content creation and integration.

History
~~~~~~~

In the early days, the engine used the `Lua <http://www.lua.org>`__
scripting language. Lua is fast, but creating bindings to an object
oriented system (by using fallbacks) was complex and slow and took an
enormous amount of code. After some experiments with
`Python <http://www.python.org>`__, it also proved difficult to embed.

The last third party scripting language that was used for shipped games
was `Squirrel <http://squirrel-lang.org>`__, but it was dropped as well.
At that point, it became evident that a custom scripting language could
more optimally make use of Godot's particular architecture:

-  Godot embeds scripts in nodes. Most languages are not designed with
   this in mind.
-  Godot uses several built-in data types for 2D and 3D math. Script
   languages do not provide this, and binding them is inefficient.
-  Godot uses threads heavily for lifting and initializing data from the
   net or disk. Script interpreters for common languages are not
   friendly to this.
-  Godot already has a memory management model for resources, most
   script languages provide their own, which results in duplicate
   effort and bugs.
-  Binding code is always messy and results in several failure points,
   unexpected bugs and generally low maintainability.

The result of these considerations is *GDScript*. The language and
interpreter for GDScript ended up being smaller than the binding code itself
for Lua and Squirrel, while having equal functionality. With time, having a
built-in language has proven to be a huge advantage.

Example of GDScript
~~~~~~~~~~~~~~~~~~~

Some people can learn better by just taking a look at the syntax, so
here's a simple example of how GDScript looks.

::

    # A file is a class!

    # Inheritance

    extends BaseClass

    # Member variables

    var a = 5
    var s = "Hello"
    var arr = [1, 2, 3]
    var dict = {"key": "value", 2:3}

    # Constants

    const ANSWER = 42
    const THE_NAME = "Charly"

    # Enums

    enum {UNIT_NEUTRAL, UNIT_ENEMY, UNIT_ALLY}
    enum Named {THING_1, THING_2, ANOTHER_THING = -1}

    # Built-in vector types

    var v2 = Vector2(1, 2)
    var v3 = Vector3(1, 2, 3)

    # function

    func some_function(param1, param2):
        var local_var = 5

        if param1 < local_var:
            print(param1)
        elif param2 > 5:
            print(param2)
        else:
            print("Fail!")

        for i in range(20):
            print(i)

        while param2 != 0:
            param2 -= 1

        var local_var2 = param1 + 3
        return local_var2

    # Functions override functions with the same name on the base/parent class.
    # If you still want to call them, use '.' (like 'super' in other languages)

    func something(p1, p2):
        .something(p1, p2)

    # Inner class

    class Something:
        var a = 10

    # Constructor

    func _init():
        print("Constructed!")
        var lv = Something.new()
        print(lv.a)

If you have previous experience with statically typed languages such as
C, C++, or C# but never used a dynamically typed one before, it is advised you
read this tutorial: :ref:`doc_gdscript_more_efficiently`.

Language
--------

In the following, an overview is given to GDScript. Details, such as which
methods are available to arrays or other objects, should be looked up in
the linked class descriptions.

Identifiers
~~~~~~~~~~~

Any string that restricts itself to alphabetic characters (``a`` to
``z`` and ``A`` to ``Z``), digits (``0`` to ``9``) and ``_`` qualifies
as an identifier. Additionally, identifiers must not begin with a digit.
Identifiers are case-sensitive (``foo`` is different from ``FOO``).

Keywords
~~~~~~~~

The following is the list of keywords supported by the language. Since
keywords are reserved words (tokens), they can't be used as identifiers.
Operators (like ``in``, ``not``, ``and`` or ``or``) and names of built-in types
as listed in the following sections are also reserved.

Keywords are defined in the `GDScript tokenizer <https://github.com/airdata/godot/blob/master/modules/gdscript/gdscript_tokenizer.cpp>`_
in case you want to take a look under the hood.

+------------+---------------------------------------------------------------------------------------------------------------+
|  Keyword   | Description                                                                                                   |
+============+===============================================================================================================+
| if         | See `if/else/elif`_.                                                                                          |
+------------+---------------------------------------------------------------------------------------------------------------+
| elif       | See `if/else/elif`_.                                                                                          |
+------------+---------------------------------------------------------------------------------------------------------------+
| else       | See `if/else/elif`_.                                                                                          |
+------------+---------------------------------------------------------------------------------------------------------------+
| for        | See for_.                                                                                                     |
+------------+---------------------------------------------------------------------------------------------------------------+
| do         | Reserved for future implementation of do...while loops.                                                       |
+------------+---------------------------------------------------------------------------------------------------------------+
| while      | See while_.                                                                                                   |
+------------+---------------------------------------------------------------------------------------------------------------+
| match      | See match_.                                                                                                   |
+------------+---------------------------------------------------------------------------------------------------------------+
| switch     | Reserved for future implementation.                                                                           |
+------------+---------------------------------------------------------------------------------------------------------------+
| case       | Reserved for future implementation.                                                                           |
+------------+---------------------------------------------------------------------------------------------------------------+
| break      | Exits the execution of the current ``for`` or ``while`` loop.                                                 |
+------------+---------------------------------------------------------------------------------------------------------------+
| continue   | Immediately skips to the next iteration of the ``for`` or ``while`` loop.                                     |
+------------+---------------------------------------------------------------------------------------------------------------+
| pass       | Used where a statement is required syntactically but execution of code is undesired, e.g. in empty functions. |
+------------+---------------------------------------------------------------------------------------------------------------+
| return     | Returns a value from a function.                                                                              |
+------------+---------------------------------------------------------------------------------------------------------------+
| class      | Defines a class.                                                                                              |
+------------+---------------------------------------------------------------------------------------------------------------+
| extends    | Defines what class to extend with the current class.                                                          |
+------------+---------------------------------------------------------------------------------------------------------------+
| is         | Tests whether a variable extends a given class.                                                               |
+------------+---------------------------------------------------------------------------------------------------------------+
| self       | Refers to current class instance.                                                                             |
+------------+---------------------------------------------------------------------------------------------------------------+
| tool       | Executes the script in the editor.                                                                            |
+------------+---------------------------------------------------------------------------------------------------------------+
| signal     | Defines a signal.                                                                                             |
+------------+---------------------------------------------------------------------------------------------------------------+
| func       | Defines a function.                                                                                           |
+------------+---------------------------------------------------------------------------------------------------------------+
| static     | Defines a static function. Static member variables are not allowed.                                           |
+------------+---------------------------------------------------------------------------------------------------------------+
| const      | Defines a constant.                                                                                           |
+------------+---------------------------------------------------------------------------------------------------------------+
| enum       | Defines an enum.                                                                                              |
+------------+---------------------------------------------------------------------------------------------------------------+
| var        | Defines a variable.                                                                                           |
+------------+---------------------------------------------------------------------------------------------------------------+
| onready    | Initializes a variable once the Node the script is attached to and its children are part of the scene tree.   |
+------------+---------------------------------------------------------------------------------------------------------------+
| export     | Saves a variable along with the resource it's attached to and makes it visible and modifiable in the editor.  |
+------------+---------------------------------------------------------------------------------------------------------------+
| setget     | Defines setter and getter functions for a variable.                                                           |
+------------+---------------------------------------------------------------------------------------------------------------+
| breakpoint | Editor helper for debugger breakpoints.                                                                       |
+------------+---------------------------------------------------------------------------------------------------------------+
| preload    | Preloads a class or variable. See `Classes as resources`_.                                                    |
+------------+---------------------------------------------------------------------------------------------------------------+
| yield      | Coroutine support. See `Coroutines with yield`_.                                                              |
+------------+---------------------------------------------------------------------------------------------------------------+
| assert     | Asserts a condition, logs error on failure. Ignored in non-debug builds. See `Assert keyword`_.               |
+------------+---------------------------------------------------------------------------------------------------------------+
| remote     | Networking RPC annotation. See :ref:`high-level multiplayer docs <doc_high_level_multiplayer>`.               |
+------------+---------------------------------------------------------------------------------------------------------------+
| master     | Networking RPC annotation. See :ref:`high-level multiplayer docs <doc_high_level_multiplayer>`.               |
+------------+---------------------------------------------------------------------------------------------------------------+
| slave      | Networking RPC annotation. See :ref:`high-level multiplayer docs <doc_high_level_multiplayer>`.               |
+------------+---------------------------------------------------------------------------------------------------------------+
| sync       | Networking RPC annotation. See :ref:`high-level multiplayer docs <doc_high_level_multiplayer>`.               |
+------------+---------------------------------------------------------------------------------------------------------------+
| PI         | PI constant.                                                                                                  |
+------------+---------------------------------------------------------------------------------------------------------------+
| TAU        | TAU constant.                                                                                                 |
+------------+---------------------------------------------------------------------------------------------------------------+
| INF        | Infinity constant. Used for comparisons.                                                                      |
+------------+---------------------------------------------------------------------------------------------------------------+
| NAN        | NAN (not a number) constant. Used for comparisons.                                                            |
+------------+---------------------------------------------------------------------------------------------------------------+

Operators
~~~~~~~~~

The following is the list of supported operators and their precedence.

+---------------------------------------------------------------+-----------------------------------------+
| **Operator**                                                  | **Description**                         |
+---------------------------------------------------------------+-----------------------------------------+
| ``x[index]``                                                  | Subscription, Highest Priority          |
+---------------------------------------------------------------+-----------------------------------------+
| ``x.attribute``                                               | Attribute Reference                     |
+---------------------------------------------------------------+-----------------------------------------+
| ``is``                                                        | Instance Type Checker                   |
+---------------------------------------------------------------+-----------------------------------------+
| ``~``                                                         | Bitwise NOT                             |
+---------------------------------------------------------------+-----------------------------------------+
| ``-x``                                                        | Negative                                |
+---------------------------------------------------------------+-----------------------------------------+
| ``*`` ``/`` ``%``                                             | Multiplication / Division / Remainder   |
|                                                               |                                         |
|                                                               | NOTE: The result of these operations    |
|                                                               | depends on the operands types. If both  |
|                                                               | are Integers, then the result will be   |
|                                                               | an Integer. That means 1/10 returns 0   |
|                                                               | instead of 0.1. If at least one of the  |
|                                                               | operands is a float, then the result is |
|                                                               | a float: float(1)/10 or 1.0/10 return   |
|                                                               | both 0.1.                               |
+---------------------------------------------------------------+-----------------------------------------+
| ``+`` ``-``                                                   | Addition / Subtraction                  |
+---------------------------------------------------------------+-----------------------------------------+
| ``<<`` ``>>``                                                 | Bit Shifting                            |
+---------------------------------------------------------------+-----------------------------------------+
| ``&``                                                         | Bitwise AND                             |
+---------------------------------------------------------------+-----------------------------------------+
| ``^``                                                         | Bitwise XOR                             |
+---------------------------------------------------------------+-----------------------------------------+
| ``|``                                                         | Bitwise OR                              |
+---------------------------------------------------------------+-----------------------------------------+
| ``<`` ``>`` ``==`` ``!=`` ``>=`` ``<=``                       | Comparisons                             |
+---------------------------------------------------------------+-----------------------------------------+
| ``in``                                                        | Content Test                            |
+---------------------------------------------------------------+-----------------------------------------+
| ``!`` ``not``                                                 | Boolean NOT                             |
+---------------------------------------------------------------+-----------------------------------------+
| ``and`` ``&&``                                                | Boolean AND                             |
+---------------------------------------------------------------+-----------------------------------------+
| ``or`` ``||``                                                 | Boolean OR                              |
+---------------------------------------------------------------+-----------------------------------------+
| ``if x else``                                                 | Ternary if/else                         |
+---------------------------------------------------------------+-----------------------------------------+
| ``=`` ``+=`` ``-=`` ``*=`` ``/=`` ``%=`` ``&=`` ``|=``        | Assignment, Lowest Priority             |
+---------------------------------------------------------------+-----------------------------------------+

Literals
~~~~~~~~

+--------------------------+--------------------------------+
| **Literal**              | **Type**                       |
+--------------------------+--------------------------------+
| ``45``                   | Base 10 integer                |
+--------------------------+--------------------------------+
| ``0x8F51``               | Base 16 (hex) integer          |
+--------------------------+--------------------------------+
| ``3.14``, ``58.1e-10``   | Floating point number (real)   |
+--------------------------+--------------------------------+
| ``"Hello"``, ``"Hi"``    | Strings                        |
+--------------------------+--------------------------------+
| ``"""Hello"""``          | Multiline string               |
+--------------------------+--------------------------------+
| ``@"Node/Label"``        | NodePath or StringName         |
+--------------------------+--------------------------------+

Comments
~~~~~~~~

Anything from a ``#`` to the end of the line is ignored and is
considered a comment.

::

    # This is a comment


Multi-line comments can be created using """ (three quotes in a row) at
the beginning and end of a block of text. Note that this creates a string,
therefore, it will not be stripped away when the script is compiled.

    ::

        """ Everything on these
        lines is considered
        a comment """

Built-in types
--------------

Built-in types are stack-allocated. They are passed as values.
This means a copy is created on each assignment or when passing them as arguments to functions.
The only exceptions are ``Array``s and ``Dictionaries``, which are passed by reference so they are shared.
(Not ``PoolArray``s like ``PoolByteArray`` though, those are passed as values too,
so consider this when deciding which to use!)

Basic built-in types
~~~~~~~~~~~~~~~~~~~~

A variable in GDScript can be assigned to several built-in types.

null
^^^^

``null`` is an empty data type that contains no information and can not
be assigned any other value.

bool
^^^^

The Boolean data type can only contain ``true`` or ``false``.

int
^^^

The integer data type can only contain integer numbers, (both negative
and positive).

float
^^^^^

Used to contain a floating point value (real numbers).

:ref:`String <class_String>`
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

A sequence of characters in `Unicode format <https://en.wikipedia.org/wiki/Unicode>`_. Strings can contain the
`standard C escape sequences <https://en.wikipedia.org/wiki/Escape_sequences_in_C>`_.
GDScript supports :ref:`format strings aka printf functionality
<doc_gdscript_printf>`.

Vector built-in types
~~~~~~~~~~~~~~~~~~~~~

:ref:`Vector2 <class_Vector2>`
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

2D vector type containing ``x`` and ``y`` fields. Can also be
accessed as array.

:ref:`Rect2 <class_Rect2>`
^^^^^^^^^^^^^^^^^^^^^^^^^^

2D Rectangle type containing two vectors fields: ``position`` and ``size``.
Alternatively contains an ``end`` field which is ``position+size``.

:ref:`Vector3 <class_Vector3>`
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

3D vector type containing ``x``, ``y`` and ``z`` fields. This can also
be accessed as an array.

:ref:`Transform2D <class_Transform2D>`
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

3x2 matrix used for 2D transforms.

:ref:`Plane <class_Plane>`
^^^^^^^^^^^^^^^^^^^^^^^^^^

3D Plane type in normalized form that contains a ``normal`` vector field
and a ``d`` scalar distance.

:ref:`Quat <class_Quat>`
^^^^^^^^^^^^^^^^^^^^^^^^

Quaternion is a datatype used for representing a 3D rotation. It's
useful for interpolating rotations.

:ref:`AABB <class_AABB>`
^^^^^^^^^^^^^^^^^^^^^^^^

Axis-aligned bounding box (or 3D box) contains 2 vectors fields: ``position``
and ``size``. Alternatively contains an ``end`` field which is
``position+size``.

:ref:`Basis <class_Basis>`
^^^^^^^^^^^^^^^^^^^^^^^^^^

3x3 matrix used for 3D rotation and scale. It contains 3 vector fields
(``x``, ``y`` and ``z``) and can also be accessed as an array of 3D
vectors.

:ref:`Transform <class_Transform>`
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

3D Transform contains a Basis field ``basis`` and a Vector3 field
``origin``.

Engine built-in types
~~~~~~~~~~~~~~~~~~~~~

:ref:`Color <class_Color>`
^^^^^^^^^^^^^^^^^^^^^^^^^^

Color data type contains ``r``, ``g``, ``b``, and ``a`` fields. It can
also be accessed as ``h``, ``s``, and ``v`` for hue/saturation/value.

:ref:`NodePath <class_NodePath>`
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Compiled path to a node used mainly in the scene system. It can be
easily assigned to, and from, a String.

:ref:`RID <class_RID>`
^^^^^^^^^^^^^^^^^^^^^^

Resource ID (RID). Servers use generic RIDs to reference opaque data.

:ref:`Object <class_Object>`
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Base class for anything that is not a built-in type.

Container built-in types
~~~~~~~~~~~~~~~~~~~~~~~~

:ref:`Array <class_Array>`
^^^^^^^^^^^^^^^^^^^^^^^^^^

Generic sequence of arbitrary object types, including other arrays or dictionaries (see below).
The array can resize dynamically. Arrays are indexed starting from index ``0``.
Starting with Godot 2.1, indices may be negative like in Python, to count from the end.

::

    var arr = []
    arr = [1, 2, 3]
    var b = arr[1] # This is 2
    var c = arr[arr.size() - 1] # This is 3
    var d = arr[-1] # Same as the previous line, but shorter
    arr[0] = "Hi!" # Replacing value 1 with "Hi"
    arr.append(4) # Array is now ["Hi", 2, 3, 4]

GDScript arrays are allocated linearly in memory for speed. Very
large arrays (more than tens of thousands of elements) may however cause
memory fragmentation. If this is a concern special types of
arrays are available. These only accept a single data type. They avoid memory
fragmentation and also use less memory but are atomic and tend to run slower than generic
arrays. They are therefore only recommended to use for very large data sets:

- :ref:`PoolByteArray <class_PoolByteArray>`: An array of bytes (integers from 0 to 255).
- :ref:`PoolIntArray <class_PoolIntArray>`: An array of integers.
- :ref:`PoolRealArray <class_PoolRealArray>`: An array of floats.
- :ref:`PoolStringArray <class_PoolStringArray>`: An array of strings.
- :ref:`PoolVector2Array <class_PoolVector2Array>`: An array of :ref:`Vector2 <class_Vector2>` objects.
- :ref:`PoolVector3Array <class_PoolVector3Array>`: An array of :ref:`Vector3 <class_Vector3>` objects.
- :ref:`PoolColorArray <class_PoolColorArray>`: An array of :ref:`Color <class_Color>` objects.

:ref:`Dictionary <class_Dictionary>`
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Associative container which contains values referenced by unique keys.

::

    var d = {4: 5, "A key": "A value", 28: [1, 2, 3]}
    d["Hi!"] = 0
    d = {
        22: "value",
        "some_key": 2,
        "other_key": [2, 3, 4],
        "more_key": "Hello"
    }

Lua-style table syntax is also supported. Lua-style uses ``=`` instead of ``:``
and doesn't use quotes to mark string keys (making for slightly less to write).
Note however that like any GDScript identifier, keys written in this form cannot
start with a digit.

::

    var d = {
        test22 = "value",
        some_key = 2,
        other_key = [2, 3, 4],
        more_key = "Hello"
    }

To add a key to an existing dictionary, access it like an existing key and
assign to it::

    var d = {} # Create an empty Dictionary
    d.waiting = 14 # Add String "Waiting" as a key and assign the value 14 to it
    d[4] = "hello" # Add integer `4` as a key and assign the String "hello" as its value
    d["Godot"] = 3.01 # Add String "Godot" as a key and assign the value 3.01 to it

Data
----

Variables
~~~~~~~~~

Variables can exist as class members or local to functions. They are
created with the ``var`` keyword and may, optionally, be assigned a
value upon initialization.

::

    var a # Data type is null by default
    var b = 5
    var c = 3.8
    var d = b + c # Variables are always initialized in order

Constants
~~~~~~~~~

Constants are similar to variables, but must be constants or constant
expressions and must be assigned on initialization.

::

    const A = 5
    const B = Vector2(20, 20)
    const C = 10 + 20 # Constant expression
    const D = Vector2(20, 30).x # Constant expression: 20
    const E = [1, 2, 3, 4][0] # Constant expression: 1
    const F = sin(20) # sin() can be used in constant expressions
    const G = x + 20 # Invalid; this is not a constant expression!

Enums
^^^^^

Enums are basically a shorthand for constants, and are pretty useful if you
want to assign consecutive integers to some constant.

If you pass a name to the enum, it would also put all the values inside a
constant dictionary of that name.

::

    enum {TILE_BRICK, TILE_FLOOR, TILE_SPIKE, TILE_TELEPORT}
    # Is the same as:
    const TILE_BRICK = 0
    const TILE_FLOOR = 1
    const TILE_SPIKE = 2
    const TILE_TELEPORT = 3

    enum State {STATE_IDLE, STATE_JUMP = 5, STATE_SHOOT}
    # Is the same as:
    const STATE_IDLE = 0
    const STATE_JUMP = 5
    const STATE_SHOOT = 6
    const State = {STATE_IDLE = 0, STATE_JUMP = 5, STATE_SHOOT = 6}


Functions
~~~~~~~~~

Functions always belong to a `class <Classes_>`_. The scope priority for
variable look-up is: local → class member → global. The ``self`` variable is
always available and is provided as an option for accessing class members, but
is not always required (and should *not* be sent as the function's first
argument, unlike Python).

::

    func my_function(a, b):
        print(a)
        print(b)
        return a + b  # Return is optional; without it null is returned

A function can ``return`` at any point. The default return value is ``null``.

Referencing Functions
^^^^^^^^^^^^^^^^^^^^^

Contrary to Python, functions are *not* first class objects in GDScript. This
means they cannot be stored in variables, passed as an argument to another
function or be returned from other functions. This is for performance reasons.

To reference a function by name at runtime, (e.g. to store it in a variable, or
pass it to another function as an argument) one must use the ``call`` or
``funcref`` helpers::

    # Call a function by name in one step
    my_node.call("my_function", args)

    # Store a function reference
    var my_func = funcref(my_node, "my_function")
    # Call stored function reference
    my_func.call_func(args)


Remember that default functions like  ``_init``, and most
notifications such as ``_enter_tree``, ``_exit_tree``, ``_process``,
``_physics_process``, etc. are called in all base classes automatically.
So there is only a need to call the function explicitly when overloading
them in some way.


Static functions
^^^^^^^^^^^^^^^^

A function can be declared static. When a function is static it has no
access to the instance member variables or ``self``. This is mainly
useful to make libraries of helper functions:

::

    static func sum2(a, b):
        return a + b


Statements and control flow
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Statements are standard and can be assignments, function calls, control
flow structures, etc (see below). ``;`` as a statement separator is
entirely optional.

if/else/elif
^^^^^^^^^^^^

Simple conditions are created by using the ``if``/``else``/``elif`` syntax.
Parenthesis around conditions are allowed, but not required. Given the
nature of the tab-based indentation, ``elif`` can be used instead of
``else``/``if`` to maintain a level of indentation.

::

    if [expression]:
        statement(s)
    elif [expression]:
        statement(s)
    else:
        statement(s)

Short statements can be written on the same line as the condition::

    if 1 + 1 == 2: return 2 + 2
    else:
        var x = 3 + 3
        return x

Sometimes you might want to assign a different initial value based on a
boolean expression. In this case ternary-if expressions come in handy::

    var x = [value] if [expression] else [value]
    y += 3 if y < 10 else -1

while
^^^^^

Simple loops are created by using ``while`` syntax. Loops can be broken
using ``break`` or continued using ``continue``:

::

    while [expression]:
        statement(s)

for
^^^

To iterate through a range, such as an array or table, a *for* loop is
used. When iterating over an array, the current array element is stored in
the loop variable. When iterating over a dictionary, the *index* is stored
in the loop variable.

::

    for x in [5, 7, 11]:
        statement # Loop iterates 3 times with x as 5, then 7 and finally 11

    var dict = {"a": 0, "b": 1, "c": 2}
    for i in dict:
        print(dict[i])

    for i in range(3):
        statement # Similar to [0, 1, 2] but does not allocate an array

    for i in range(1,3):
        statement # Similar to [1, 2] but does not allocate an array

    for i in range(2,8,2):
        statement # Similar to [2, 4, 6] but does not allocate an array

    for c in "Hello":
        print(c) # Iterate through all characters in a String, print every letter on new line

match
^^^^^

A ``match`` statement is used to branch execution of a program.
It's the equivalent of the ``switch`` statement found in many other languages but offers some additional features.

Basic syntax:

::

    match [expression]:
        [pattern](s):
            [block]
        [pattern](s):
            [block]
        [pattern](s):
            [block]


**Crash-course for people who are familiar to switch statements**:

1. Replace ``switch`` with ``match``
2. Remove ``case``
3. Remove any ``break``'s. If you don't want to ``break`` by default you can use ``continue`` for a fallthrough.
4. Change ``default`` to a single underscore.


**Control flow**:

The patterns are matched from top to bottom.
If a pattern matches, the corresponding block will be executed. After that, the execution continues below the ``match`` statement.
If you want to have a fallthrough you can use ``continue`` to stop execution in the current block and check the ones below it.

There are 6 pattern types:

- constant pattern
    constant primitives, like numbers and strings ::

        match x:
            1:
                print("We are number one!")
            2:
                print("Two are better than one!")
            "test":
                print("Oh snap! It's a string!")


- variable pattern
    matches the contents of a variable/enum ::

        match typeof(x):
            TYPE_FLOAT:
                print("float")
            TYPE_STRING:
                print("text")
            TYPE_ARRAY:
                print("array")


- wildcard pattern
    This pattern matches everything. It's written as a single underscore.

    It can be used as the equivalent of the ``default`` in a ``switch`` statement in other languages. ::

        match x:
            1:
                print("It's one!")
            2:
                print("It's one times two!")
            _:
                print("It's not 1 or 2. I don't care tbh.")


- binding pattern
    A binding pattern introduces a new variable. Like the wildcard pattern, it matches everything - and also gives that value a name.
    It's especially useful in array and dictionary patterns. ::

        match x:
            1:
                print("It's one!")
            2:
                print("It's one times two!")
            var new_var:
                print("It's not 1 or 2, it's ", new_var)


- array pattern
    matches an array. Every single element of the array pattern is a pattern itself so you can nest them.

    The length of the array is tested first, it has to be the same size as the pattern, otherwise the pattern don't match.

    **Open-ended array**: An array can be bigger than the pattern by making the last subpattern ``..``

    Every subpattern has to be comma separated. ::

        match x:
            []:
                print("Empty array")
            [1, 3, "test", null]:
                print("Very specific array")
            [var start, _, "test"]:
                print("First element is ", start, ", and the last is \"test\"")
            [42, ..]:
                print("Open ended array")

- dictionary pattern
    Works in the same way as the array pattern. Every key has to be a constant pattern.

    The size of the dictionary is tested first, it has to be the same size as the pattern, otherwise the pattern don't match.

    **Open-ended dictionary**: A dictionary can be bigger than the pattern by making the last subpattern ``..``

    Every subpattern has to be comma separated.

    If you don't specify a value, then only the existence of the key is checked.

    A value pattern is separated from the key pattern with a ``:`` ::

        match x:
            {}:
                print("Empty dict")
            {"name": "Dennis"}:
                print("The name is Dennis")
            {"name": "Dennis", "age": var age}:
                print("Dennis is ", age, " years old.")
            {"name", "age"}:
                print("Has a name and an age, but it's not Dennis :(")
            {"key": "godotisawesome", ..}:
                print("I only checked for one entry and ignored the rest")

Multipatterns:
    You can also specify multiple patterns separated by a comma. These patterns aren't allowed to have any bindings in them. ::

        match x:
            1, 2, 3:
                print("It's 1 - 3")
            "Sword", "Splash potion", "Fist":
                print("Yep, you've taken damage")



Classes
~~~~~~~

By default, the body of a script file is an unnamed class and it can
only be referenced externally as a resource or file. Class syntax is
meant to be very compact and can only contain member variables or
functions. Static functions are allowed, but not static members (this is
in the spirit of thread safety, since scripts can be initialized in
separate threads without the user knowing). In the same way, member
variables (including arrays and dictionaries) are initialized every time
an instance is created.

Below is an example of a class file.

::

    # Saved as a file named myclass.gd

    var a = 5

    func print_value_of_a():
        print(a)

Inheritance
^^^^^^^^^^^

A class (stored as a file) can inherit from

- A global class
- Another class file
- An inner class inside another class file.

Multiple inheritance is not allowed.

Inheritance uses the ``extends`` keyword:

::

    # Inherit/extend a globally available class
    extends SomeClass

    # Inherit/extend a named class file
    extends "somefile.gd"

    # Inherit/extend an inner class in another file
    extends "somefile.gd".SomeInnerClass


To check if a given instance inherits from a given class
the ``is`` keyword can be used:

::

    # Cache the enemy class
    const Enemy = preload("enemy.gd")

    # [...]

    # Use 'is' to check inheritance
    if (entity is Enemy):
        entity.apply_damage()

To call a function in a *base class* (i.e. one ``extend``-ed in your current class),
prepend ``.`` to the function name:

::

    .basefunc(args)

This is especially useful because functions in extending classes replace
functions with the same name in their base classes. So if you still want
to call them, you can use ``.`` like the ``super`` keyword in other languages:

::

    func some_func(x):
        .some_func(x) # Calls same function on the parent class

Class Constructor
^^^^^^^^^^^^^^^^^

The class constructor, called on class instantiation, is named ``_init``.
As mentioned earlier, the constructors of parent classes are called automatically when
inheriting a class. So there is usually no need to call ``._init()`` explicitly.

If a parent constructor takes arguments, they are passed like this:

::

    func _init(args).(parent_args):
       pass

Inner classes
^^^^^^^^^^^^^

A class file can contain inner classes. Inner classes are defined using the
``class`` keyword. They are instanced using the ``ClassName.new()``
function.

::

    # Inside a class file

    # An inner class in this class file
    class SomeInnerClass:
        var a = 5
        func print_value_of_a():
            print(a)

    # This is the constructor of the class file's main class
    func _init():
        var c = SomeInnerClass.new()
        c.print_value_of_a()

Classes as resources
^^^^^^^^^^^^^^^^^^^^

Classes stored as files are treated as :ref:`resources <class_GDScript>`. They
must be loaded from disk to access them in other classes. This is done using
either the ``load`` or ``preload`` functions (see below). Instancing of a loaded
class resource is done by calling the ``new`` function on the class object::

    # Load the class resource when calling load()
    var my_class = load("myclass.gd")

    # Preload the class only once at compile time
    const MyClass = preload("myclass.gd")

    func _init():
        var a = MyClass.new()
        a.some_function()

Exports
~~~~~~~

Class members can be exported. This means their value gets saved along
with the resource (e.g. the :ref:`scene <class_PackedScene>`) they're attached
to. They will also be available for editing in the property editor. Exporting
is done by using the ``export`` keyword::

    extends Button

    export var number = 5 # Value will be saved and visible in the property editor

An exported variable must be initialized to a constant expression or have an
export hint in the form of an argument to the export keyword (see below).

One of the fundamental benefits of exporting member variables is to have
them visible and editable in the editor. This way artists and game designers
can modify values that later influence how the program runs. For this, a
special export syntax is provided.

::

    # If the exported value assigns a constant or constant expression,
    # the type will be inferred and used in the editor

    export var number = 5

    # Export can take a basic data type as an argument which will be
    # used in the editor

    export(int) var number

    # Export can also take a resource type to use as a hint

    export(Texture) var character_face
    export(PackedScene) var scene_file

    # Integers and strings hint enumerated values

    # Editor will enumerate as 0, 1 and 2
    export(int, "Warrior", "Magician", "Thief") var character_class
    # Editor will enumerate with string names
    export(String, "Rebecca", "Mary", "Leah") var character_name

    # Named enum values
    
    # Editor will enumerate as THING_1, THING_2, ANOTHER_THING
    enum NamedEnum {THING_1, THING_2, ANOTHER_THING = -1}
    export (NamedEnum) var x

    # Strings as paths

    # String is a path to a file
    export(String, FILE) var f
    # String is a path to a directory
    export(String, DIR) var f
    # String is a path to a file, custom filter provided as hint
    export(String, FILE, "*.txt") var f

    # Using paths in the global filesystem is also possible,
    # but only in tool scripts (see further below)

    # String is a path to a PNG file in the global filesystem
    export(String, FILE, GLOBAL, "*.png") var tool_image
    # String is a path to a directory in the global filesystem
    export(String, DIR, GLOBAL) var tool_dir

    # The MULTILINE setting tells the editor to show a large input
    # field for editing over multiple lines
    export(String, MULTILINE) var text

    # Limiting editor input ranges

    # Allow integer values from 0 to 20
    export(int, 20) var i
    # Allow integer values from -10 to 20
    export(int, -10, 20) var j
    # Allow floats from -10 to 20, with a step of 0.2
    export(float, -10, 20, 0.2) var k
    # Allow values y = exp(x) where y varies between 100 and 1000
    # while snapping to steps of 20. The editor will present a
    # slider for easily editing the value.
    export(float, EXP, 100, 1000, 20) var l

    # Floats with easing hint

    # Display a visual representation of the ease() function
    # when editing
    export(float, EASE) var transition_speed

    # Colors

    # Color given as Red-Green-Blue value
    export(Color, RGB) var col # Color is RGB
    # Color given as Red-Green-Blue-Alpha value
    export(Color, RGBA) var col # Color is RGBA

    # Another node in the scene can be exported too

    export(NodePath) var node

It must be noted that even if the script is not being run while at the
editor, the exported properties are still editable (see below for
"tool").

Exporting bit flags
^^^^^^^^^^^^^^^^^^^

Integers used as bit flags can store multiple ``true``/``false`` (boolean)
values in one property. By using the export hint ``int, FLAGS``, they
can be set from the editor:

::

    # Individually edit the bits of an integer
    export(int, FLAGS) var spell_elements = ELEMENT_WIND | ELEMENT_WATER

Restricting the flags to a certain number of named flags is also
possible. The syntax is very similar to the enumeration syntax:

::

    # Set any of the given flags from the editor
    export(int, FLAGS, "Fire", "Water", "Earth", "Wind") var spell_elements = 0

In this example, ``Fire`` has value 1, ``Water`` has value 2, ``Earth``
has value 4 and ``Wind`` corresponds to value 8. Usually, constants
should be defined accordingly (e.g. ``const ELEMENT_WIND = 8`` and so
on).

Using bit flags requires some understanding of bitwise operations. If in
doubt, boolean variables should be exported instead.

Exporting arrays
^^^^^^^^^^^^^^^^

Exporting arrays works but with an important caveat: While regular
arrays are created local to every class instance, exported arrays are *shared*
between all instances. This means that editing them in one instance will
cause them to change in all other instances. Exported arrays can have
initializers, but they must be constant expressions.

::

    # Exported array, shared between all instances.
    # Default value must be a constant expression.

    export var a=[1,2,3]

    # Typed arrays also work, only initialized empty:

    export var vector3s = PoolVector3Array()
    export var strings = PoolStringArray()

    # Regular array, created local for every instance.
    # Default value can include run-time values, but can't
    # be exported.

    var b = [a,2,3]


Setters/getters
~~~~~~~~~~~~~~~

It is often useful to know when a class' member variable changes for
whatever reason. It may also be desired to encapsulate its access in some way.

For this, GDScript provides a *setter/getter* syntax using the ``setget`` keyword.
It is used directly after a variable definition:

::

    var variable = value setget setterfunc, getterfunc

Whenever the value of ``variable`` is modified by an *external* source
(i.e. not from local usage in the class), the *setter* function (``setterfunc`` above)
will be called. This happens *before* the value is changed. The *setter* must decide what to do
with the new value. Vice-versa, when ``variable`` is accessed, the *getter* function
(``getterfunc`` above) must ``return`` the desired value. Below is an example:


::

    var myvar setget my_var_set, my_var_get

    func my_var_set(new_value):
        my_var = new_value

    func my_var_get():
        return my_var # Getter must return a value

Either of the *setter* or *getter* functions can be omitted:

::

    # Only a setter
    var my_var = 5 setget myvar_set
    # Only a getter (note the comma)
    var my_var = 5 setget ,myvar_get

Get/Setters are especially useful when exporting variables to editor in tool
scripts or plugins, for validating input.

As said *local* access will *not* trigger the setter and getter. Here is an
illustration of this:

::

    func _init():
        # Does not trigger setter/getter
        my_integer = 5
        print(my_integer)

        # Does trigger setter/getter
        self.my_integer = 5
        print(self.my_integer)

Tool mode
~~~~~~~~~

Scripts, by default, don't run inside the editor and only the exported
properties can be changed. In some cases it is desired that they do run
inside the editor (as long as they don't execute game code or manually
avoid doing so). For this, the ``tool`` keyword exists and must be
placed at the top of the file:

::

    tool
    extends Button

    func _ready():
        print("Hello")

Memory management
~~~~~~~~~~~~~~~~~

If a class inherits from :ref:`class_Reference`, then instances will be
freed when no longer in use. No garbage collector exists, just simple
reference counting. By default, all classes that don't define
inheritance extend **Reference**. If this is not desired, then a class
must inherit :ref:`class_Object` manually and must call instance.free(). To
avoid reference cycles that can't be freed, a ``weakref`` function is
provided for creating weak references.


Signals
~~~~~~~

It is often desired to send a notification that something happened in an
instance. GDScript supports creation of built-in Godot signals.
Declaring a signal in GDScript is easy using the `signal` keyword.

::

    # No arguments
    signal your_signal_name
    # With arguments
    signal your_signal_name_with_args(a, b)

These signals, just like regular signals, can be connected in the editor
or from code. Just take the instance of a class where the signal was
declared and connect it to the method of another instance:

::

    func _callback_no_args():
        print("Got callback!")

    func _callback_args(a,b):
        print("Got callback with args! a: ", a, " and b: ", b)

    func _at_some_func():
        instance.connect("your_signal_name", self, "_callback_no_args")
        instance.connect("your_signal_name_with_args", self, "_callback_args")

It is also possible to bind arguments to a signal that lacks them with
your custom values:

::

    func _at_some_func():
        instance.connect("your_signal_name", self, "_callback_args", [22, "hello"])

This is very useful when a signal from many objects is connected to a
single callback and the sender must be identified:

::

    func _button_pressed(which):
        print("Button was pressed: ", which.get_name())

    func _ready():
        for b in get_node("buttons").get_children():
            b.connect("pressed", self, "_button_pressed",[b])

Finally, emitting a custom signal is done by using the
Object.emit_signal method:

::

    func _at_some_func():
        emit_signal("your_signal_name")
        emit_signal("your_signal_name_with_args", 55, 128)
        some_instance.emit_signal("some_signal")

Coroutines with yield
~~~~~~~~~~~~~~~~~~~~~

GDScript offers support for `coroutines <https://en.wikipedia.org/wiki/Coroutine>`_
via the ``yield`` built-in function. Calling ``yield()`` will
immediately return from the current function, with the current frozen
state of the same function as the return value. Calling ``resume`` on
this resulting object will continue execution and return whatever the
function returns. Once resumed the state object becomes invalid. Here is
an example:

::

    func my_func():
       print("Hello")
       yield()
       print("world")

    func _ready():
        var y = my_func()
        # Function state saved in 'y'
        print("my dear")
        y.resume()
        # 'y' resumed and is now an invalid state

Will print:

::

    Hello
    my dear
    world

It is also possible to pass values between yield() and resume(), for
example:

::

    func my_func():
       print("Hello")
       print(yield())
       return "cheers!"

    func _ready():
        var y = my_func()
        # Function state saved in 'y'
        print(y.resume("world"))
        # 'y' resumed and is now an invalid state

Will print:

::

    Hello
    world
    cheers!

Coroutines & signals
^^^^^^^^^^^^^^^^^^^^

The real strength of using ``yield`` is when combined with signals.
``yield`` can accept two parameters, an object and a signal. When the
signal is received, execution will recommence. Here are some examples:

::

    # Resume execution the next frame
    yield(get_tree(), "idle_frame")

    # Resume execution when animation is done playing:
    yield(get_node("AnimationPlayer"), "finished")

    # Wait 5 seconds, then resume execution
    yield(get_tree().create_timer(5.0), "timeout")

Onready keyword
~~~~~~~~~~~~~~~

When using nodes, it's very common to desire to keep references to parts
of the scene in a variable. As scenes are only warranted to be
configured when entering the active scene tree, the sub-nodes can only
be obtained when a call to Node._ready() is made.

::

    var my_label

    func _ready():
        my_label = get_node("MyLabel")

This can get a little cumbersome, especially when nodes and external
references pile up. For this, GDScript has the ``onready`` keyword, that
defers initialization of a member variable until _ready is called. It
can replace the above code with a single line:

::

    onready var my_label = get_node("MyLabel")

Assert keyword
~~~~~~~~~~~~~~

The ``assert`` keyword can be used to check conditions in debug builds.
These assertions are ignored in non-debug builds.

::

    # Check that i is 0
    assert(i == 0)
