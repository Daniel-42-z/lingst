#let kiwi = rgb("8ee53f")
#let magenta = rgb("ff00ff")
#let mint = rgb("40ffbf")

#let height(x) = {
	if type(x) == int { return x }
	let h = (high: 0, mid: 1, middle: 1)
	h.at(x, default: 2)
}

#let format-ans(ans-length) = {
	ans-length.map(x => {
		if x <= 15 { x * "-" } else { "(" + str(x) + ")" }
	}).join(" ")
}

#let lingo-panel(x, y, color, puzzle-text, show-ans, ans-length, thickness) = {
	let stroke-color = if color == white { gray.lighten(50%) } else { color }
	let body = [
		#show: upper
		#puzzle-text
		#if show-ans { format-ans(ans-length) }
	]

	grid.cell(
		x: x, y: y,
		fill: gray.darken(75%),
		stroke: thickness + stroke-color,
		inset: 10pt, align: center + horizon,
		body
	)
}

#let lingo-stack-puzzle(
	high-color, high-text, 
	mid-color, mid-text, 
	low-color, low-text, 
	answer-length, 
	block-size: 3cm, 
	thickness: 5pt
) = {
	set text(fill: white)
	let (h-show, m-show, l-show) = (false, true, false)

	if mid-text == none and high-text == none {
		(m-show, l-show) = (false, true)
	} else if mid-text == none and low-text == none {
		(h-show, m-show) = (true, false)
	}

	let panels = (
		(0, 0, high-color, high-text, h-show),
		(0, 1, mid-color, mid-text, m-show),
		(0, 2, low-color, low-text, l-show),
	)

	box(grid(
		columns: block-size,
		rows: (block-size,) * 3,
		gutter: thickness,
		..panels.map(it => lingo-panel(..it, answer-length, thickness))
	))
}

#let lingo-pipe-puzzle(
	height-color-list, 
	puzzle-text, 
	ans-length, 
	block-size: 3cm, 
	thickness: 5pt
) = {
	set text(fill: white)
	let layout = (height-color-list.at(0),)

	for i in range(1, height-color-list.len()) {
		let curr = height(height-color-list.at(i).at(0))
		let prev = height(height-color-list.at(i - 1).at(0))
		if curr != prev { layout.push(0) }
		layout.push(height-color-list.at(i))
	}

	let cells = range(layout.len()).map(i => {
		let item = layout.at(i)
		if i == 0 {
			let h = height(item.at(0))
			return lingo-panel(0, h, item.at(1), puzzle-text, true, ans-length, thickness)
		}
		if item == 0 {
			return grid.cell(x: i, y: 0, rowspan: 3, fill: white, stroke: thickness + black, [])
		}
		let (h, color) = (height(item.at(0)), item.at(1))
		let stroke = thickness + if color == white { black } else { color }
		grid.cell(x: i, y: h, fill: color, stroke: stroke, [])
	})

	box(grid(
		columns: (block-size,) * layout.len(),
		rows: (block-size,) * 3,
		gutter: thickness,
		..cells
	))
}
