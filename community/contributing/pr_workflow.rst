.. _doc_pr_workflow:

Pull request workflow
=====================

.. highlight:: shell

The so-called "PR workflow" used by Godot is common to many projects using
Git, and should be familiar to veteran free software contributors. The idea
is that only a small number (if any) commit directly to the *master* branch.
Instead, contributors *fork* the project (i.e. create a copy of it, which
they can modify as they wish), and then use the GitHub interface to request
a *pull* from one of their fork's branches to one branch of the original
(often named *upstream*) repository.

The resulting *pull request* (PR) can then be reviewed by other contributors,
which might approve it, reject it, or most often request that modifications
be done. Once approved, the PR can then be merged by one of the core
developers, and its commit(s) will become part of the target branch (usually
the *master* branch).

We will go together through an example to show the typical workflow and
associated Git commands. But first, let's have a quick look at the
organisation of Godot's Git repository.

Git source repository
---------------------

The `repository on GitHub <https://github.com/airdata/godot>`_ is a
`Git <https://git-scm.com>`_ code repository together with an embedded
issue tracker and PR system.

.. note:: If you are contributing to the documention, its repository can
          be found `here <https://github.com/airdata/godot-docs>`_.

The Git version control system is the tool used to keep track of successive
edits to the source code - to contribute efficiently to Godot, learning the
basics of the Git command line is *highly* recommended. There exist some
graphical interfaces for Git, but they usually encourage users to take bad
habits regarding the Git and PR workflow, and we therefore recommend not to
use them. In particular, we advise not to use GitHub's online editor for code
contributions (although it's tolerated for small fixes or documentation changes)
as it enforces one commit per file and per modification,
which quickly leads to PRs with an unreadable Git history (especially after peer review).

.. seealso:: The first sections of Git's "Book" are a good introduction to
             the tool's philosophy and the various commands you need to
             master in your daily workflow. You can read them online on the
             `Git SCM <https://git-scm.com/book/en/v2>`_ website.

The branches on the Git repository are organized as follows:

-  The ``master`` branch is where the development of the next major version
   occurs. As a development branch, it can be unstable
   and is not meant for use in production. This is where PRs should be done
   in priority.
-  The stable branches are named after their version, e.g. ``3.0`` and ``2.1``.
   They are used to backport bugfixes and enhancements from the ``master``
   branch to the currently maintained stable release (e.g. 3.0.2 or 2.1.5).
   As a rule of thumb, the last stable branch is maintained until the next
   major version (e.g. the ``2.0`` branch was maintained until the release of
   Godot 2.1).
   If you want to make PRs against a maintained stable branch, you will have
   to check if your changes are also relevant for the ``master`` branch.
-  There might be feature branches at time, usually meant to be merged into
   the ``master`` branch at some time.

Forking and cloning
-------------------

The first step is to *fork* the `godotengine/godot <https://github.com/airdata/godot>`_
repository on GitHub. To do so, you will need to have a GitHub account and to
be logged in. In the top right corner of the repository's GitHub page, you
should see the "Fork" button as shown below:

.. image:: img/github_fork_button.png

Click it, and after a while you should be redirected to your own fork of the
Godot repo, with your GitHub username as namespace:

.. image:: img/github_fork_url.png

You can then *clone* your fork, i.e. create a local copy of the online
repository (in Git speak, the *origin remote*). If you haven't already,
download Git from `its website <https://git-scm.com>`_ if you're using Windows or
macOS, or install it through your package manager if you're using Linux.

.. note:: If you are on Windows, open Git Bash to type commands. macOS and Linux users
          can use their respective terminals.

To clone your fork from GitHub, use the following command:

::

    $ git clone https://github.com/USERNAME/godot

.. note:: In our examples, the "$" character denotes the command line prompt
          on typical UNIX shells. It is not part of the command and should
          not be typed.

After a little while, you should have a ``godot`` directory in your current
working directory. Move into it using the ``cd`` command:

::

    $ cd godot

We will start by setting up a reference to the original repository that we forked:

::

    $ git remote add upstream https://github.com/airdata/godot
    $ git fetch upstream

This will create a reference named ``upstream`` pointing to the original
godotengine/godot repository. This will be useful when you want to pull new
commits from its ``master`` branch to update your fork. You have another
``remote`` reference named ``origin``, which points to your fork.

You only need to do the above steps once, as long as you keep that local
``godot`` folder (which you can move around if you want, the relevant
metadata is hidden in its ``.git`` subfolder).

.. note:: *Branch it, pull it, code it, stage it, commit, push it, rebase
          it... technologic.*

          This bad take on Daft Punk's *Technologic* shows the general
          conception Git beginners have of its workflow: lots of strange
          commands to learn by copy and paste, hoping they will work as
          expected. And that's actually not a bad way to learn, as long as
          you're curious and don't hesitate to question your search engine
          when lost, so we will give you the basic commands to know when
          working in Git.

In the following, we will assume that you want to implement a feature in
Godot's project manager, which is coded in the ``editor/project_manager.cpp``
file.

Branching
---------

By default, the ``git clone`` should have put you on the ``master`` branch of
your fork (``origin``). To start your own feature development, we will create
a feature branch:

::

    # Create the branch based on the current branch (master)
    $ git branch better-project-manager

    # Change the current branch to the new one
    $ git checkout better-project-manager

This command is equivalent:

::

    # Change the current branch to a new named one, based on the current branch
    $ git checkout -b better-project-manager

If you want to go back to the ``master`` branch, you'd use:

::

    $ git checkout master

You can see which branch you are currently on with the ``git branch``
command:

::

    $ git branch
      2.1
    * better-project-manager
      master

Updating your branch
--------------------

This would not be needed the first time (just after you forked the upstream
repository). However, the next time you want to work on something, you will
notice that your fork's ``master`` is several commits behind the upstream
``master`` branch: pull requests from other contributors would have been merged
in the meantime.

To ensure there won't be conflicts between the feature you develop and the
current upstream ``master`` branch, you will have to update your branch by
*pulling* the upstream branch.

::

    $ git pull upstream master

However, if you had local commits, this method will create a so-called "merge
commit", and you will soon hear from fellow contributors that those are not
wanted in PRs. Then how to update the branch without creating a merge commit?
You will have to use the ``--rebase`` option, so that your local commits are
replayed on top of the updated upstream ``master`` branch. It will effectively
modify the Git history of your branch, but that is for the greater good.

Therefore, the command that you should (almost) always use is:

::

    $ git pull --rebase upstream master

Making changes
--------------

You would then do your changes to our example's
``editor/project_manager.cpp`` file with your usual development environment
(text editor, IDE, etc.).

By default, those changes are *unstaged*. The staging area is a layer between
your working directory (where you make your modifications) and the local git
repository (the commits and all the metadata in the ``.git`` folder). To
bring changes from the working directory to the Git repository, you need to
*stage* them with the ``git add`` command, and then to commit them with the
``git commit`` command.

There are various commands you should know to review your current work,
before staging it, while it is staged, and after it has been committed.

- ``git diff`` will show you the current unstaged changes, i.e. the
  differences between your working directory and the staging area.
- ``git checkout -- <files>`` will undo the unstaged changes to the given
  files.
- ``git add <files>`` will *stage* the changes on the listed files.
- ``git diff --staged`` will show the current staged changes, i.e. the
  differences between the staging area and the last commit.
- ``git reset HEAD <files>`` will *unstage* changes to the listed files.
- ``git status`` will show you what are the currently staged and unstaged
  modifications.
- ``git commit`` will commit the staged files. It will open a text editor
  (you can define the one you want to use with the ``GIT_EDITOR`` environment
  variable or the ``core.editor`` setting in your Git configuration) to let you
  write a commit log. You can use ``git commit -m "Cool commit log"`` to
  write the log directly.
- ``git log`` will show you the last commits of your current branch. If you
  did local commits, they should be shown at the top.
- ``git show`` will show you the changes of the last commit. You can also
  specify a commit hash to see the changes for that commit.

That's a lot to memorise! Don't worry, just check this cheat sheet when you
need to make changes, and learn by doing.

Here's how the shell history could look like on our example:

::

    # It's nice to know where you're starting from
    $ git log

    # Do changes to the project manager with the nano text editor
    $ nano editor/project_manager.cpp

    # Find an unrelated bug in Control and fix it
    $ nano scene/gui/control.cpp

    # Review changes
    $ git status
    $ git diff

    # We'll do two commits for our unrelated changes,
    # starting by the Control changes necessary for the PM enhancements
    $ git add scene/gui/control.cpp
    $ git commit -m "Fix handling of margins in Control"

    # Check we did good
    $ git log
    $ git show
    $ git status

    # Make our second commit
    $ git add editor/project_manager.cpp
    $ git commit -m "Add a pretty banner to the project manager"
    $ git log

With this, we should have two new commits in our ``better-project-manager``
branch which were not in the ``master`` branch. They are still only local
though, the remote fork does not know about them, nor does the upstream repo.

Pushing changes to a remote
---------------------------

That's where ``git push`` will come into play. In Git, a commit is always
done in the local repository (unlike Subversion where a commit will modify
the remote repository directly). You need to *push* the new commits to a
remote branch to share them with the world. The syntax for this is:

::

    $ git push <remote> <local branch>[:<remote branch>]

The part about the remote branch can be omitted if you want it to have the
same name as the local branch, which is our case in this example, so we will
do:

::

    $ git push origin better-project-manager

Git will ask you for your username and password, and the changes will be sent
to your remote. If you check the fork's page on GitHub, you should see a new
branch with your added commits.

Issuing a pull request
----------------------

When you load your fork's branch on GitHub, you should see a line saying
*"This branch is 2 commits ahead of godotengine:master."* (and potentially some
commits behind, if your ``master`` branch was out of sync with the upstream
``master`` branch.

.. image:: img/github_fork_make_pr.png

On that line, there is a "Pull request" link. Clicking it will open a form
that will let you issue a pull request on the godotengine/godot upstream
repository. It should show you your two commits, and state "Able to merge".
If not (e.g. it has way more commits, or says there are merge conflicts),
don't create the PR, something went wrong. Go to IRC and ask for support :)

Use an explicit title for the PR and put the necessary details in the comment
area. You can drag and drop screenshots, GIFs or zipped projects if relevant,
to showcase what your work implements. Click "Create a pull request", and
tadaa!

Modifying a pull request
------------------------

While it is reviewed by other contributors, you will often need to make
changes to your yet-unmerged PR, either because contributors requested them,
or because you found issues yourself while testing.

The good news is that you can modify a pull request simply by acting on the
branch you made the pull request from. You can e.g. make a new commit on that
branch, push it to your fork, and the PR will be updated automatically:

::

    # Check out your branch again if you had changed in the meantime
    $ git checkout better-project-manager

    # Fix a mistake
    $ nano editor/project_manager.cpp
    $ git add editor/project_manager.cpp
    $ git commit -m "Fix a typo in the banner's title"
    $ git push origin better-project-manager

That should do the trick, but...

Mastering the PR workflow: the rebase
-------------------------------------

On the situation outlined above, your fellow contributors who are particularly
pedantic regarding the Git history might ask your to *rebase* your branch to
*squash* or *meld* the last two commits together (i.e. the two related to the
project manager), as the second commit basically fixes an issue in the first one.

Once the PR is merged, it is not relevant for a changelog reader that the PR
author made mistakes; instead, we want to keep only commits that bring from
one working state to another working state.

To squash those two commits together, we will have to *rewrite history*.
Right, we have that power. You may read that it's a bad practice, and it's
true when it comes to branches of the upstream repo. But in your fork, you
can do whatever you want, and everything is allowed to get neat PRs :)

We will use the *interactive rebase* ``git rebase -i`` to do this. This
command takes a commit hash as argument, and will let you modify all commits
between that commit hash and the last one of the branch, the so-called
*HEAD*. In our example, we want to act on the last two commits, so we will
do:

::

    # The HEAD~X syntax means X commits before HEAD
    $ git rebase -i HEAD~2

This will open a text editor with:

::

    pick 1b4aad7 Add a pretty banner to the project manager
    pick e07077e Fix a typo in the banner's title

The editor will also show instructions regarding how you can act on those
commits. In particular, it should tell you that "pick" means to use that
commit (do nothing), and that "squash" and "fixup" can be used to *meld* the
commit in its parent commit. The difference between "squash" and "fixup" is
that "fixup" will discard the commit log from the squashed commit. In our
example, we are not interested in keeping the log of the "Fix a typo" commit,
so we use:

::

    pick 1b4aad7 Add a pretty banner to the project manager
    fixup e07077e Fix a typo in the banner's title

Upon saving and quitting the editor, the rebase will occur. The second commit
will be melded into the first one, and ``git log`` and ``git show`` should
now confirm that you have only one commit with the changes from both previous
commits.

.. note:: You could have avoided this rebase by using ``git commit --amend``
          when fixing the typo. This command will write the staged changes
          directly into the *last* commit (``HEAD``), instead of creating a new
          commit like we did in this example. So it is equivalent to what we
          did with a new commit and then a rebase to mark it as "fixup".

But! You rewrote the history, and now your local and remote branches have
diverged. Indeed, commit 1b4aad7 in the above example will have changed, and
therefore got a new commit hash. If you try to push to your remote branch, it
will raise an error:

::

    $ git push origin better-project-manager
    To https://github.com/akien-mga/godot
     ! [rejected]        better-project-manager -> better-project-manager (non-fast-forward)
    error: failed to push some refs to 'https://akien-mga@github.com/akien-mga/godot'
    hint: Updates were rejected because the tip of your current branch is behind
    hint: its remote counterpart.

This is a sane behaviour, Git will not let you push changes that would
override remote content. But that's actually what we want to do here, so we
will have to *force* it:

::

    $ git push --force origin better-project-manager

And tadaa! Git will happily *replace* your remote branch with what you had
locally (so make sure that's what you wanted, using ``git log``). This will
also update the PR accordingly.

Deleting a Git branch
---------------------

After your pull request gets merged, there's one last thing you should do: delete your
Git branch for the PR. There won't be issues if you don't delete your branch, but it's
good practice to do so. You'll need to do this twice, once for the local branch and another
for the remote branch on GitHub.

To delete our better project manager branch locally, use this command:

::

    $ git branch -d better-project-manager

Alternatively, if the branch hadn't been merged yet and we wanted to delete it anyway, instead
of ``-d`` you would use ``-D``.

Next, to delete the remote branch on GitHub use this command:

::

    $ git push origin -d better-project-manager
