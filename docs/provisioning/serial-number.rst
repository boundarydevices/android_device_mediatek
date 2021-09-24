Serial number
~~~~~~~~~~~~~

All the boards have the same serial number which is stored in the mmc.
It's part of the U-Boot environment which is located on ``mmc0boot1``.

To get a custom serial number, it's possible to reflash ``mmc0boot1`` with
the ``--serialno`` option:

.. prompt:: bash $

   aiot-flash mmc0boot1 --serialno <unique_serial_number>

.. note::
   When reflashing the whole board again using ``aiot-flash``, the custom serial number
   will be lost since we also reflash ``mmc0boot1`` with default values.

   Make sure you always provide the ``--serialno <unique_serial_number>`` argument when reflashing.

   Alternatively, reflash only the needed partitions as documented in :ref:`getting-started/readme.flashing_one_part:flashing only one partition`
