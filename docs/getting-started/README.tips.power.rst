Tips
----

turn off the screen
~~~~~~~~~~~~~~~~~~~

After the device boots, the screen will stay on all the time. This won't
let the kernel to enter its default suspend state.

To avoid that, you can tell the power manager to disable holding the
screen on:

.. prompt:: bash #

   svc power stayon false

stay awake
~~~~~~~~~~

If you want to keep the scree on all the time you can tell the power
manager to stay awake:

.. prompt:: bash # 

   svc power stayon true

Alternatively, you can hold a wakelock via the commandline:

.. prompt:: bash # 

   echo lock_me > /sys/power/wake_lock
   echo lock_me > /sys/power/wake_unlock
