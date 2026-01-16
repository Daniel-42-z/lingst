#let kiwi = rgb("8ee53f")
#let magenta = rgb("ff00ff")
#let mint = rgb("40ffbf")
#let height(x) = { if x == 0 or x == 1 or x == 2 { x } else if x == "high" { 0 } else if x == "mid" { 1 } else { 2 } }

#let lingo-panel(x, y, color, text, show-ans, ans-length, thickness) = {
	grid.cell(
		x: x,
		y: y,
		fill: gray.darken(75%),
		stroke: thickness + if color == white { gray.lighten(50%) } else { color },
		inset: 10pt,
		align: center + horizon,
		[
			#show: upper
			#text

			#if show-ans {
				ans-length.map(x => if x <= 15 { x * "-" } else { "(" + str(x) + ")" }).join(" ")
			}
		]
	)
}

#let lingo-stack-puzzle(high-color, high-text, mid-color, mid-text, low-color, low-text, answer-length, block-size: 3cm, thickness: 5pt) = {
	set text(fill: white)
	let (high-show-ans, mid-show-ans, low-show-ans) = (false, true, false)
	if mid-text == none {
		if high-text == none {
			(mid-show-ans, low-show-ans) = (false, true)
		} else if low-text == none {
			(high-show-ans, mid-show-ans) = (true, false)
		}
	}

	box(
		grid(
		    columns: block-size,
		    rows: (block-size,) * 3,
		    gutter: thickness,
		    ..((0, 0, high-color, high-text, high-show-ans), (0, 1, mid-color, mid-text, mid-show-ans), (0, 2, low-color, low-text, low-show-ans)).map(it => lingo-panel(..it, answer-length, thickness))
		    )
	)
}

#let lingo-pipe-puzzle(height-color-list, puzzle-text, ans-length, block-size: 3cm, thickness: 5pt) = {
	set text(fill: white)
	let layout = (height-color-list.at(0),)
	for i in range(1, height-color-list.len()) {
		if height(height-color-list.at(i).at(0)) != height(height-color-list.at(i - 1).at(0)) {
			layout.push(0)
		}
		layout.push(height-color-list.at(i))
	}
	box(
		grid(
			columns: (block-size,) * (layout.len()),
			rows: (block-size,) * 3,
			gutter: thickness,
			..range(layout.len()).map(i => {
				if i == 0 {
					lingo-panel(
						0, height(layout.at(0).at(0)),
						layout.at(0).at(1),
						puzzle-text,
						true,
						ans-length,
						thickness
					)
				} else if layout.at(i) == 0 {
					grid.cell(
						x: i,
						y: 0,
						rowspan: 3,
						fill: white,
						stroke: thickness + black,
						[]
					)
				} else {
					let color = layout.at(i).at(1)
					grid.cell(
						x: i,
						y: height(layout.at(i).at(0)),
						fill: color,
						stroke: thickness + if color == white { black } else { color },
						[]
					)
				}
			}),
		)
	)
}
