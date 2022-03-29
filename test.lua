a = "abcde*fghijkl  mnopqrstuvwxyz"
f = "fghi jklmnopqrstuvwxyzabcde"
m = "mnopqrstuvw_xyzabc-defghijkl"

rb.lcd_puts(1, 1, a)
rb.lcd_puts(3, 2, f)
rb.lcd_puts(1, 3, m)
rb.lcd_puts(1, 5, string.sub(tostring(100/90), 1, -3) .. string.sub(tostring(100/90), -3, #tostring(100/90)))
rb.lcd_update()
rb.sleep(rb.HZ * 5)
os.exit()
