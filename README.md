# CNC_automate
The CNC machine code for Automate - Detroit 2025
The FR10 performs the following tasks in order - 
1. Opens Drawer 1, moves Object 1 to Drawer 2.
2. Opens Drawer 2, moves Object 2 from Drawer 1 to Drawer 3.
3. Returns both objects to Drawer 1 and closes drawers.

Notes - 
1. Vacuum Control: Uses Modbus (0x0049 = on, 0x0025 = off) to grip/release.
2. Linear Paths: All movements use Lin commands for straight lines.
3. Variables (in millimeters)

Offsets explained - 
Y-Axis:
1. drawer_drag_top = 575: Drawer 1 drag.
2. obj_1_offset = 180: How far Object 1 is placed from the D1_Drag position (Y = 755 on Drawer 1).
3. obj_2_offset = 225: How far Object 1 is placed from the D1_Drag position (Y = 800 on Drawer 1).
4. obj_drop_offset = 200: Drop position for Drawers 2/3.
5. bottom_drawer_drag = 400: Drawer 2 drag.



Z-Axis:
1. z_up = -100: Safe height to clear obstacles.
2. drawer_offset_bottom = 118: Drawer 2 (Z = 118), Drawer 3 (Z = 236). (Adjust the height if needed)
