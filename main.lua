dead_clr = { 0.2, 0.2, 0.2 } 
alive_clr = { 0.75, 0.75, 0.75 } 

-- # of cells, horizontally + vertically, in grid
grid_cell_wt = 24
grid_cell_ht = 24

-- grid rendering properties
cell_ln = 16
cell_gap = 4

grid = nil

function initialize_grid()
	grid = {}          -- create the matrix
	for i=1,grid_cell_wt do
		grid[i] = {}     -- create a new row
		for j=1,grid_cell_ht do
			grid[i][j] = 0
		end
	end
end

function draw_grid()
	for i,row in pairs(grid) do
		for j,v in pairs(row) do
			local color = (v == 0 and dead_clr) or alive_clr
			love.graphics.setColor(color)
			local cell_x = i * cell_ln + (i - 1) * cell_gap
			local cell_y = j * cell_ln + (j - 1) * cell_gap
			love.graphics.rectangle("fill", cell_x, cell_y, cell_ln, cell_ln)
		end
	end
end
	
function love.load()
	initialize_grid()
end

function love.draw()
	draw_grid()
end