#let lingo-stack-puzzle(high-color, high-text, mid-color, mid-text, low-color, low-text, answer-length, block-size: 3cm, thickness: 2pt) = {
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
		rows: (block-size, block-size, block-size),
		align: center + horizon,
		gutter: thickness,
		grid.cell(
			stroke: (top: thickness + high-color, bottom: thickness + high-color, left: thickness + high-color, right: thickness + high-color),
			[
				#high-text\
				#if high-show-ans {
					"_ " * answer-length
				}
			]
		),
		grid.cell(
			stroke: (top: thickness + mid-color, bottom: thickness + mid-color, left: thickness + mid-color, right: thickness + mid-color),
			[
				#mid-text\
				#if mid-show-ans {
					"_ " * answer-length
				}
			]
		),
		grid.cell(
			stroke: (top: thickness + low-color, bottom: thickness + low-color, left: thickness + low-color, right: thickness + low-color),
			[
				#low-text\
				#if low-show-ans {
					"_ " * answer-length
				}
			]
		),
	)
}
