module main

import vcolor as vc

fn main() {
	c := vc.RGB{
		r: 126
		g: 71
		b: 228
	}
	ic := c.invert()
	cc := c.complementary()
	r180 := vc.HSL.new(261, 74.4, 58.6)!.rotate(180).rgb()

	out := [
		c.info() + ' Origin',
		ic.info() + ' Invert',
		cc.info() + ' Complementary',
		r180.info() + ' Rotate180',
	]

	println(out.join_lines())
	println(c.hsl().rgb())
}
