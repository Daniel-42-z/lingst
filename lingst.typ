#let lingo-panel(color, text, show-ans, ans-length, thickness) = {
	grid.cell(
		fill: gray.darken(75%),
		stroke: thickness + if color == white { gray.lighten(50%) } else { color },
		inset: 10pt,
		align: center + horizon,
		[
			#show: upper
			#text

			#if show-ans {
				v(1fr)
				ans-length.map(x => if x <= 15 { x * "-" } else { "(" + str(x) + ")" }).join(" ")
			}
		]
	)
}

#let lingo-stack-puzzle(high-color, high-text, mid-color, mid-text, low-color, low-text, answer-length, block-size: 3cm, thickness: 2pt) = {
	set text(fill: white)
	let (high-show-ans, mid-show-ans, low-show-ans) = (false, true, false)
	if mid-text == none {
		if high-text == none {
			(mid-show-ans, low-show-ans) = (false, true)
		} else if low-text == none {
			(high-show-ans, mid-show-ans) = (true, false)
		}
	}

	grid(
		columns: block-size,
		rows: (block-size,) * 3,
		gutter: thickness,
		..((high-color, high-text, high-show-ans), (mid-color, mid-text, mid-show-ans), (low-color, low-text, low-show-ans)).map(it => lingo-panel(..it, answer-length, thickness))
	)
}
