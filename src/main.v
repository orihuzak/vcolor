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
	c180 := c.hsl().rotate(180).rgb()
	triad := c.triadic()
	anal := c.analogous()
	tet := c.tetradic()
	square := c.square()

	out := [
		c.info() + ' Origin',
		ic.info() + ' Invert',
		cc.info() + ' Complementary',
		c180.info() + ' Rotate180',
		triad[0].info() + ' Triad[0]',
		triad[1].info() + ' Triad[1]',
		anal[0].info() + ' Analogous[0]',
		anal[1].info() + ' Analogous[1]',
		tet[0].info() + ' Tetradic[0]',
		tet[2].info() + ' Tetradic[2]',
		square[0].info() + ' Square[0]',
		square[2].info() + ' Square[2]',
	]

	println(out.join_lines())
}
