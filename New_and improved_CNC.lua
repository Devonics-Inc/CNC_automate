-- Variables (Y-axis and Z-axis offsets)
drawer_drag_top = 575      -- Y-position for dragging Drawer 1
obj_1_offset = 180         -- Y offset for Object 1 on Drawer 1
obj_2_offset = 225         -- Y offset for Object 2 on Drawer 1
obj_drop_offset = 200      -- Y-position for placing objects on Drawer 2&3
bottom_drawer_drag = 400   -- Y-position for dragging Drawer 2
z_up = -100                -- Z-position for moving up (negative = upward)
drawer_offset_bottom = 118 -- Z-position for Drawer 2&3 bottom

-- Initialize: Turn off vacuum gripper and move to start position
ModbusRegWrite(0x06, 0x03E8, 1, {0x0025}, 9, 0) -- Vacuum off
WaitMs(2000)                                    -- Wait for vacuum release
PTP(START, 100, -1, 2, 0, 0, z_up, 0, 0, 0)  -- Move up in Z to START position (Z = -100)
WaitMs(1200)                                    -- Wait for movement completion

-- Drag Drawer 1 to open
PTP(D1_Drag, 50, -1, 2, 0, 0, z_up, 0, 0, 0)       -- Ensure up in Z to avoid collision
in(D1_Drag, 100, -1, 0, 2, 0, 0, 0, 0, 0, 0)        -- Move to Y = 0 (align for drag)
ModbusRegWrite(0x06, 0x03E8, 1, {0x0049}, 9, 0)        -- Vacuum on to grip Drawer 1
WaitMs(1200)                                           -- Wait for vacuum engagement
in(D1_Drag, 100, -1, 0, 2, 0, drawer_drag_top, 0, 0, 0, 0)-- Move to Y = 575 to drag Drawer 1
ModbusRegWrite(0x06, 0x03E8, 1, {0x0025}, 9, 0)        -- Vacuum off to release Drawer 1
WaitMs(2000)                                           -- Wait for vacuum release
in(D1_Drag, 100, -1, 0, 2, 0, drawer_drag_top, z_up, 0, 0, 0)-- Move up in Z to avoid collision

-- Pick Object 1 from Drawer 1
in(D1_Drag, 100, -1, 0, 2, 0, drawer_drag_top, z_up, 0, 0, 0)-- Ensure up in Z
in(D1_Drag, 100, -1, 0, 2, 0, drawer_drag_top + obj_1_offset, z_up, 0, 0, 0)-- Move to Y = 755 (above Object 1)
in(D1_Drag, 100, -1, 0, 2, 0, drawer_drag_top + obj_1_offset, 0, 0, 0)  -- Move down to Z = 0 to pick
ModbusRegWrite(0x06, 0x03E8, 1, {0x0049}, 9, 0)        -- Vacuum on to pick Object 1
WaitMs(1200)                                           -- Wait for vacuum engagement
in(D1_Drag, 100, -1, 0, 2, 0, drawer_drag_top + obj_1_offset, z_up, 0, 0, 0)-- Move up in Z with Object 1

-- Place Object 1 on Drawer 2
in(D1_Drag, 100, -1, 0, 2, 0, drawer_drag_top + obj_1_offset, z_up, 0, 0, 0)-- Ensure up in Z
in(D1_Drag, 100, -1, 0, 2, 0, obj_drop_offset, z_up, 0, 0, 0)-- Move to Y = 200 (above Drawer 2)
in(D1_Drag, 100, -1, 0, 2, 0, obj_drop_offset, drawer_offset_bottom, 0, 0, 0)-- Move down to Z = 118 to place
ModbusRegWrite(0x06, 0x03E8, 1, {0x0025}, 9, 0)        -- Vacuum off to drop Object 1
WaitMs(1200)                                           -- Wait for vacuum release
in(D1_Drag, 100, -1, 0, 2, 0, obj_drop_offset, z_up, 0, 0, 0)-- Move up in Z to avoid collision

-- Drag Drawer 2 to open
in(D1_Drag, 100, -1, 0, 2, 0, obj_drop_offset, z_up, 0, 0, 0)-- Ensure up in Z
in(D1_Drag, 100, -1, 0, 2, 0, 0, z_up, 0, 0, 0)             -- Move to Y = 0 (above Drawer 2)
in(D1_Drag, 100, -1, 0, 2, 0, 0, drawer_offset_bottom, 0, 0, 0)-- Move down to Z = 118 to grip
ModbusRegWrite(0x06, 0x03E8, 1, {0x0049}, 9, 0)                -- Vacuum on to grip Drawer 2
WaitMs(1200)                                                  -- Wait for vacuum engagement
in(D1_Drag, 100, -1, 0, 2, 0, bottom_drawer_drag, drawer_offset_bottom, 0, 0, 0)-- Move to Y = 400 to drag Drawer 2
ModbusRegWrite(0x06, 0x03E8, 1, {0x0025}, 9, 0)                -- Vacuum off to release Drawer 2
WaitMs(2000)                                                  -- Wait for vacuum release
in(D1_Drag, 100, -1, 0, 2, 0, bottom_drawer_drag, z_up, 0, 0, 0)-- Move up in Z to avoid collision

-- Pick Object 2 from Drawer 1
in(D1_Drag, 100, -1, 0, 2, 0, bottom_drawer_drag, z_up, 0, 0, 0)-- Ensure up in Z
in(D1_Drag, 100, -1, 0, 2, 0, drawer_drag_top + obj_2_offset, z_up, 0, 0, 0)-- Move to Y = 800 (above Object 2)
in(D1_Drag, 100, -1, 0, 2, 0, drawer_drag_top + obj_2_offset, 0, 0, 0, 0)   -- Move down to Z = 0 to pick
ModbusRegWrite(0x06, 0x03E8, 1, {0x0049}, 9, 0)                -- Vacuum on to pick Object 2
WaitMs(1200)                                                  -- Wait for vacuum engagement
in(D1_Drag, 100, -1, 0, 2, 0, drawer_drag_top + obj_2_offset, z_up, 0, 0, 0)-- Move up in Z with Object 2

-- Place Object 2 on Drawer 3
in(D1_Drag, 100, -1, 0, 2, 0, drawer_drag_top + obj_2_offset, z_up, 0, 0, 0)-- Ensure up in Z
in(D1_Drag, 100, -1, 0, 2, 0, obj_drop_offset, z_up, 0, 0, 0)-- Move to Y = 200 (above Drawer 3)
in(D1_Drag, 100, -1, 0, 2, 0, obj_drop_offset, drawer_offset_bottom * 2, 0, 0, 0)-- Move down to Z = 236 to place
ModbusRegWrite(0x06, 0x03E8, 1, {0x0025}, 9, 0)                -- Vacuum off to drop Object 2
WaitMs(1200)                                                  -- Wait for vacuum release
in(D1_Drag, 100, -1, 0, 2, 0, obj_drop_offset, z_up, 0, 0, 0)-- Move up in Z to avoid collision
WaitMs(6000)                                                  -- Wait (possibly for external process)

-- Return Object 2 to Drawer 1
in(D1_Drag, 100, -1, 0, 2, 0, obj_drop_offset, z_up, 0, 0, 0)-- Ensure up in Z
in(D1_Drag, 100, -1, 0, 2, 0, obj_drop_offset, drawer_offset_bottom * 2, 0, 0, 0)-- Move down to Z = 236 to pick
ModbusRegWrite(0x06, 0x03E8, 1, {0x0049}, 9, 0)                -- Vacuum on to pick Object 2
WaitMs(1200)                                                  -- Wait for vacuum engagement
in(D1_Drag, 100, -1, 0, 2, 0, obj_drop_offset, z_up, 0, 0, 0)-- Move up in Z with Object 2
in(D1_Drag, 100, -1, 0, 2, 0, drawer_drag_top + obj_2_offset, z_up, 0, 0, 0)-- Move to Y = 800 (above Drawer 1)
in(D1_Drag, 100, -1, 0, 2, 0, drawer_drag_top + obj_2_offset, 0, 0, 0, 0)   -- Move down to Z = 0 to place
ModbusRegWrite(0x06, 0x03E8, 1, {0x0025}, 9, 0)                -- Vacuum off to drop Object 2
WaitMs(1200)                                                  -- Wait for vacuum release
in(D1_Drag, 100, -1, 0, 2, 0, drawer_drag_top + obj_2_offset, z_up, 0, 0, 0)-- Move up in Z to avoid collision

-- Drag Drawer 2 back to close
in(D1_Drag, 100, -1, 0, 2, 0, drawer_drag_top + obj_2_offset, z_up, 0, 0, 0)-- Ensure up in Z
in(D1_Drag, 100, -1, 0, 2, 0, bottom_drawer_drag, z_up, 0, 0, 0)-- Move to Y = 400 (above Drawer 2)
in(D1_Drag, 100, -1, 0, 2, 0, bottom_drawer_drag, drawer_offset_bottom, 0, 0, 0)-- Move down to Z = 118 to grip
ModbusRegWrite(0x06, 0x03E8, 1, {0x0049}, 9, 0)                -- Vacuum on to grip Drawer 2
WaitMs(1200)                                                  -- Wait for vacuum engagement
in(D1_Drag, 100, -1, 0, 2, 0, 0, drawer_offset_bottom, 0, 0, 0)-- Move to Y = 0 to close Drawer 2
ModbusRegWrite(0x06, 0x03E8, 1, {0x0025}, 9, 0)                -- Vacuum off to release Drawer 2
WaitMs(2000)                                                  -- Wait for vacuum release
in(D1_Drag, 100, -1, 0, 2, 0, 0, z_up, 0, 0, 0)             -- Move up in Z to avoid collision

-- Return Object 1 to Drawer 1
in(D1_Drag, 100, -1, 0, 2, 0, 0, z_up, 0, 0, 0)             -- Ensure up in Z
in(D1_Drag, 100, -1, 0, 2, 0, obj_drop_offset, z_up, 0, 0, 0)-- Move to Y = 200 (above Drawer 2)
in(D1_Drag, 100, -1, 0, 2, 0, obj_drop_offset, drawer_offset_bottom, 0, 0, 0)-- Move down to Z = 118 to pick
ModbusRegWrite(0x06, 0x03E8, 1, {0x0049}, 9, 0)                -- Vacuum on to pick Object 1
WaitMs(1200)                                                  -- Wait for vacuum engagement
in(D1_Drag, 100, -1, 0, 2, 0, obj_drop_offset, z_up, 0, 0, 0)-- Move up in Z with Object 1
in(D1_Drag, 100, -1, 0, 2, 0, drawer_drag_top + obj_1_offset, z_up, 0, 0, 0)-- Move to Y = 755 (above Drawer 1)
in(D1_Drag, 100, -1, 0, 2, 0, drawer_drag_top + obj_1_offset, 0, 0, 0, 0)   -- Move down to Z = 0 to place
ModbusRegWrite(0x06, 0x03E8, 1, {0x0025}, 9, 0)                -- Vacuum off to drop Object 1
WaitMs(1200)                                                  -- Wait for vacuum release
in(D1_Drag, 100, -1, 0, 2, 0, drawer_drag_top + obj_1_offset, z_up, 0, 0, 0)-- Move up in Z to avoid collision

-- Drag Drawer 1 back to close
in(D1_Drag, 100, -1, 0, 2, 0, drawer_drag_top + obj_1_offset, z_up, 0, 0, 0)-- Ensure up in Z
in(D1_Drag, 100, -1, 0, 2, 0, drawer_drag_top, z_up, 0, 0, 0)-- Move to Y = 575 (above Drawer 1)
in(D1_Drag, 100, -1, 0, 2, 0, drawer_drag_top, 0, 0, 0, 0)   -- Move down to Z = 0 to grip
ModbusRegWrite(0x06, 0x03E8, 1, {0x0049}, 9, 0)                -- Vacuum on to grip Drawer 1
WaitMs(1200)                                                  -- Wait for vacuum engagement
in(D1_Drag, 100, -1, 0, 2, 0, 0, 0, 0, 0, 0)                -- Move to Y = 0 to close Drawer 1
ModbusRegWrite(0x06, 0x03E8, 1, {0x0025}, 9, 0)                -- Vacuum off to release Drawer 1
WaitMs(2000)                                                  -- Wait for vacuum release
in(D1_Drag, 100, -1, 0, 2, 0, 0, z_up, 0, 0, 0)             -- Move up in Z to avoid collision