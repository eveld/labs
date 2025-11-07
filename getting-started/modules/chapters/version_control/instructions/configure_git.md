## Install Git

To manage content on Instruqt we will use Git as version control.
Git can be installed on the most common operating systems such as Windows, macOS, and Linux.
If you are on macOS and many Linux distributions, Git might already be installed on your system.

To verify if you already have Git installed, open up the terminal application on your system and run the `git version` command.
You should either see which version of the `git` binary is currently installed, or "command not found".
If Git is not installed on your machine, check the specific documentation for either [macOS](https://git-scm.com/downloads/mac), [Windows](https://git-scm.com/downloads/win) or [Linux](https://git-scm.com/downloads/linux) to install Git.

## Configure Git

The first thing you should do is to configure your identity that Git will use to identify your commits.
Lets start by configuring your name, which will give others an easy way to recognize the author of your commits. 
Execute the following command in a terminal, with "Your Name" replaced by your own name.

```shell
git config --global user.name "Your Name"
```

The other important identifying information needed to create a commit is your email address.
This makes it easy to differentiate authors with the same name.
In a terminal, execute the following command and replace "your_email@example.com" with your own email address.
We will use this same email address in a following step, so be sure that this is a valid email address.

```shell
git config --global user.email your_email@example.com
```