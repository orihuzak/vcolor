module vcolor

const (
	c = RGB{
		r: 126
		g: 71
		b: 228
	}
)

fn test_hsl() {
	hsl := vcolor.c.hsl()
	assert '${hsl.hue}, ${hsl.saturation:.1}, ${hsl.lightness:.1}' == '261, 74.4, 58.6'
}

fn test_from_hex() {
	assert RGB.from_hex('#7e47e4')! == vcolor.c
	assert RGB.from_hex('7e47e4')! == vcolor.c
	RGB.from_hex('zzzzzz') or { assert true }
	RGB.from_hex('あいうえお') or { assert true }
}

fn test_invert() {
	assert vcolor.c.invert() == RGB{129, 184, 27}
}

fn test_complementary() {
	assert vcolor.c.complementary() == RGB{173, 228, 71}
}

fn test_hex() {
	assert vcolor.c.hex() == '#7e47e4'
}

fn test_triadic() {
	assert c.triadic() == [RGB{228, 126, 71}, RGB{71, 228, 126}]
}
