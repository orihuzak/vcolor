module vcolor

fn test_new() {
	HSL.new(361, 100, 50) or { assert '${err}' == 'Hue must be between 0 and 360. got 361' }
	HSL.new(360, 101, 50) or {
		assert '${err}' == 'Saturation must be between 0 and 100. got 101.0'
	}
	HSL.new(360, 100, 101) or {
		assert '${err}' == 'Lightness must be between 0 and 100. got 101.0'
	}
}

fn test_rgb() {
	a := HSL.new(0, 100, 50)!
	c := HSL.new(261, 74.4, 58.6)!
	assert a.rgb() == RGB{255, 0, 0}
	assert c.rgb() == RGB{126, 71, 228}
}

fn test_rotate() {
	a := HSL.new(0, 100, 50)!
	b := HSL.new(180, 100, 50)!
	c := HSL.new(261, 74.4, 58.6)!
	assert a.rotate(180) == b
	assert a.rotate(180) == a.rgb().complementary().hsl()
	// assert c.rotate(180) == c.rgb().complementary().hsl()
}
