# Frequently Asked Questions

### 1\. `repo init` fails with `SyntaxError: invalid syntax`

The `repo init` commands fails because of the following python error:

    Get https://gerrit.googlesource.com/git-repo/clone.bundle
    Get https://gerrit.googlesource.com/git-repo
    remote: Counting objects: 1, done
    remote: Finding sources: 100% (30/30)
    remote: Total 30 (delta 2), reused 30 (delta 2)
    Unpacking objects: 100% (30/30), done.
    From https://gerrit.googlesource.com/git-repo
       7f7acfe..5e2f32f  main       -> origin/main
       4b32581..352c93b  stable     -> origin/stable
     * [new tag]         v2.10      -> v2.10
    Traceback (most recent call last):
      File "/home/linux/src/mediatek/.repo/repo/main.py", line 56, in <module>
        from subcmds.version import Version
      File "/home/linux/src/mediatek/.repo/repo/subcmds/__init__.py", line 38, in <module>
        ['%s' % name])
      File "/home/linux/src/mediatek/.repo/repo/subcmds/upload.py", line 27, in <module>
        from hooks import RepoHook
      File "/home/linux/src/mediatek/.repo/repo/hooks.py", line 472
        file=sys.stderr)
            ^
    SyntaxError: invalid syntax

The `repo` version shipped in linux distributions is often outdated. For
example, in Ubuntu, if `repo` is installed via `apt-get install repo`,
the above error will be reproduced.

Please install `repo` as [recommended on Android’s
website](https://source.android.com/setup/develop#installing-repo)

### 2\. The Camera app disappears after booting Android

The Android Camera app runs on the first Android boot to detect whether
a physical camera sensor is present and useable by the device. If it
can’t find one, it will disable itself and thus disappear from the
launcher.

To re-enable it, use package manager via `adb`:

    adb root
    adb shell pm enable com.android.camera2/com.android.camera.CameraLauncher
