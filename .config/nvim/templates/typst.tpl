// #show heading.where(level: 1): set text(size: 11pt)
// #show heading.where(level: 2): set text(size: 10pt)

#set math.mat(delim: "[")
#set par(justify: true)

#show emph: set text(weight: "bold", fill: purple) 
#show link: set text(blue) 

#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 2pt),
  radius: 2pt,
)
// Display block code in a larger block with more padding.
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
)

#align(center,text(size:17pt)[${1:title}])
#align(center, text(12pt)[${2:sub-title}])

