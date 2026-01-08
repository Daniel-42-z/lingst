#let lingo-stack-puzzle(high-color, high-text, mid-color, mid-text, low-color, low-text, answer-length, block-size: 3cm, thickness: 2pt) = {
	set text(fill: white, font: "Inter")
	let (high-show-ans, mid-show-ans, low-show-ans) = (false, true, false)
	if mid-text == none {
		if high-text == none {
			(mid-show-ans, low-show-ans) = (false, true)
		} else if low-text == none {
			(high-show-ans, mid-show-ans) = (true, false)
		}
	}
	let (high-color-actual, mid-color-actual, low-color-actual) = (high-color, mid-color, low-color).map(color => { if color == white {gray.lighten(50%)} else {color} })
	grid(
		columns: block-size,
		rows: (block-size, block-size, block-size),
		align: center + horizon,
		gutter: thickness,
		fill: gray.darken(75%),
		grid.cell(
			stroke: (top: thickness + high-color-actual, bottom: thickness + high-color-actual, left: thickness + high-color-actual, right: thickness + high-color-actual),
			[
				#high-text\
				#if high-show-ans {
					"-" * answer-length
				}
			]
		),
		grid.cell(
			stroke: (top: thickness + mid-color-actual, bottom: thickness + mid-color-actual, left: thickness + mid-color-actual, right: thickness + mid-color-actual),
			[
				#mid-text
				
				#if mid-show-ans {
					answer-length.map(x => {x * "-"}).join(" ")
				}
			]
		),
		grid.cell(
			stroke: (top: thickness + low-color-actual, bottom: thickness + low-color-actual, left: thickness + low-color-actual, right: thickness + low-color-actual),
			[
				#low-text\
				#if low-show-ans {
					"-" * answer-length
				}
			]
		),
	)
}
