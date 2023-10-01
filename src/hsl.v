module vcolor

import math

[noinit]
pub struct HSL {
	hue        u16
	saturation f32
	lightness  f32
}

pub fn HSL.new(hue u16, saturation f32, lightness f32) !HSL {
	if hue < 0 || hue > 360 {
		return error('Hue must be between 0 and 360. got ${hue}')
	}
	if saturation < 0 || saturation > 100 {
		return error('Saturation must be between 0 and 100. got ${saturation}')
	}
	if lightness < 0 || lightness > 100 {
		return error('Lightness must be between 0 and 100. got ${lightness}')
	}
	if lightness > 100 || lightness < 0 {
	}
	return HSL{hue, saturation, lightness}
}

// rgb converts RGB to HSL
pub fn (c &HSL) rgb() RGB {
	h := f32(c.hue) / 360
	s := c.saturation / 100
	l := c.lightness / 100

	if s == 0 {
		col := u8(math.round(l * 255))
		return RGB{col, col, col}
	}

	t1 := if l < 0.5 {
		l * (1.0 + s)
	} else {
		l + s - l * s
	}

	t2 := 2 * l - t1

	mut rgb := []u8{len: 3}
	for i := 0; i < 3; i++ {
		mut t3 := match i {
			0 { h + 1.0 / 3 }
			1 { h }
			else { h - 1.0 / 3 }
		}

		if t3 < 0 {
			t3++
		}

		if t3 > 1 {
			t3--
		}

		col := if 6 * t3 < 1 {
			t2 + (t1 - t2) * 6 * t3
		} else if 2 * t3 < 1 {
			t1
		} else if 3 * t3 < 2 {
			t2 + (t1 - t2) * (2.0 / 3 - t3) * 6
		} else {
			t2
		}

		rgb[i] = u8(math.round(col * 255))
	}

	return RGB{rgb[0], rgb[1], rgb[2]}
}

pub fn (c &HSL) rotate(degrees u16) HSL {
	hue := (c.hue + degrees) % 360
	return HSL{
		hue: if hue < 0 { 360 + hue } else { hue }
		saturation: c.saturation
		lightness: c.lightness
	}
}
