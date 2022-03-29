math = require("math")
h = rb.LCD_HEIGHT - 1
_, _, th = rb.font_getstringsize("W", rb.FONT_UI)
rb.splash(rb.HZ * 5, tostring(h/th))
for i=1,(h/th) do
  rb.lcd_puts(1,i,tostring(i))
end
rb.lcd_update()
rb.sleep(rb.HZ * 5)

for i=1,50 do
  rb.lcd_puts(i, math.fmod(i, 16),tostring(i))
end
rb.lcd_update()
rb.sleep(rb.HZ * 5)
os.exit()
