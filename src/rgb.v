module vcolor

import term
import math.stats
import encoding.hex as enchex

const (
	bar = '          '
)

// compute the invert color of a given color
// 255 - r, 255 - g, 255 - b
pub struct RGB {
	r u8
	g u8
	b u8
}

pub fn RGB.from_hex(hex string) !RGB {
	h := if hex[0] == `#` {
		enchex.decode(hex[1..])!
	} else {
		enchex.decode(hex)!
	}
	return RGB{
		r: h[0]
		g: h[1]
		b: h[2]
	}
}

pub fn (c &RGB) info() string {
	return '${term.bg_rgb(c.r, c.g, c.b, vcolor.bar)} ${c.css()} ${c.hex()}'
}

pub fn (c &RGB) hex() string {
	return '#${c.r.hex()}${c.g.hex()}${c.b.hex()}'
}

pub fn (c &RGB) css() string {
	return 'rgb(${c.r}, ${c.g}, ${c.b})'
}

// 反転色
// 255 - each rgb
pub fn (c &RGB) invert() RGB {
	return RGB{
		r: 255 - c.r
		g: 255 - c.g
		b: 255 - c.b
	}
}

// 補色
// (max + min) - each rgb
pub fn (c &RGB) complementary() RGB {
	sum := stats.max([c.r, c.g, c.b]) + stats.min([c.r, c.g, c.b])
	return RGB{
		r: sum - c.r
		g: sum - c.g
		b: sum - c.b
	}
}

pub fn (c &RGB) triadic() []RGB {
	return [c.hsl().rotate(120).rgb(), c.hsl().rotate(-120).rgb()]
}

pub fn (c &RGB) analogous() []RGB {
	return [c.hsl().rotate(30).rgb(), c.hsl().rotate(-30).rgb()]
}

pub fn (c &RGB) tetradic() []RGB {
	return [c.hsl().rotate(60).rgb(), c.hsl().rotate(180).rgb(),
		c.hsl().rotate(240).rgb()]
}

pub fn (c &RGB) square() []RGB {
	return [c.hsl().rotate(90).rgb(), c.hsl().rotate(180).rgb(),
		c.hsl().rotate(270).rgb()]
}

pub fn (c &RGB) hsl() HSL {
	r := f32(c.r) / 255
	g := f32(c.g) / 255
	b := f32(c.b) / 255
	min := stats.min([r, g, b])
	max := stats.max([r, g, b])
	delta := max - min
	mut h := f32(0)
	match max {
		min {
			h = 0
		}
		r {
			h = (g - b) / delta
		}
		g {
			h = 2 + (b - r) / delta
		}
		b {
			h = 4 + (r - g) / delta
		}
		else {}
	}

	h = stats.min([h * 60, 360])
	if h < 0 {
		h += 360
	}

	l := (min + max) / 2

	mut s := f32(0)
	if max == min {
		s = 0
	} else if l <= 0.5 {
		s = delta / (max + min)
	} else {
		s = delta / (2 - max - min)
	}

	return HSL{i16(h), s * 100, l * 100}
}
