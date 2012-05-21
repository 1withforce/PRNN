#Pure Ruby Neural Net
require "matrix"
#Sample trainingset:
#xor = [[0,0],[0],[[0,1],[1]],[1,0],[1]],[[1,1],[0]]
#sample training weights:
sThetas = [[[-10, 30], [20, -20], [20, -20]], [[-30],[20],[20]]] # a list of matrices! Ahh! The terror...
sInput = [1, 0]	

#  =======================================================================================
#                 			V 0.3
#	Currently only working towards supporting 3-layered nets
#	Current version only supports forward propagation (must be provided with weights)	
#  =======================================================================================


def sigmoid(x)
	1 / (1 + Math::E**(-x))
end


#There's a lot of converting to and from array/matrix since the creator of ruby's "matrix" library was
#apparently very opposed to mutable data structures; converting to an array and back again is the only way to
#add, remove, or access values from a matrix


def extract_row(matrix, row) #must be an array, not actual matrix
	output = []
	matrix.each do |collum|
		output << collum[row]
	end
	return output
end

def forward_prop(thetas, input)
	#if @layers != thetas.length + 1
		#raise "Error: layers inconsistant"
	#end
	steps = thetas.length
	current_step = 1
	a = Matrix[([1] + input)] # adding bias
	a_ref = [] #record of outputs needed for backpropagation
	until current_step > steps do
		weights = Matrix.rows(thetas[(current_step-1)])
		temp = (a * weights).to_a
		if current_step == steps #output doesn't need to initialise a new bias
			a = []
		else			
			a = [1] #bias
		end

		temp[0].each do |a2|
			a << sigmoid(a2)
		end
		current_step += 1
		a_ref << a
		a = Matrix[a]
	end
	return a_ref
end

def calc_error(expected, obtained) #calculates the error for each item in the matching lists and returns a list of the same length
	if expected.length != obtained.length
		raise "Error: item lengths are not equal"
	end
	i = 0#easiest to use iterator in this case
	errors = []
	until i == expected.length do
		errors << obtained[i] - expected[i]
		i +=1
	end
end
		
def back_prop(thetas, a, expected) #"a" is the matrix of outputs
	delta3 = calc_error(expected, a[1])
#======Currently working on \/====================================================
	der_z2 = #derivative of z2
	delta2 = ((Matrix.rows(extract_row(thetas, 1))).transpose * Matrix[delta3]).to_a[0].elem_mult(der_z2)

end

def elem_mult(matching_array) #matching array must be of same length as self
	output = []
	c = 0	
	self.each do |item|
		output << item*matching_array[c]
		c+=1
	end
	return output
end

def train(training_set, dimensions)# training set must be in format: [[[input, input...],[output, output...]],[[input, input...],[output, output...]]...]
	thetas = init_weights(dimensions)
	until trained == true do
		training_set.each do |data|
			inputs = data[0]
			expected = data[1]
			a = forward_prop(thetas, inputs)
			obtained = fprop[0]
			error = (expected - obtained).abs
			thetas = back_prop(thetas, a)
		end
	end
end

#Test
#print forward_prop(sThetas, sInput)[1]
def user_test(known_thetas)
	
	puts "This is an example of a network trained to compute XOR", "Enter first term (1 or 0)"	
	input1 = gets.chomp.to_i
	puts "Enter second term (1 or 0)"
	input2 = gets.chomp.to_i
	puts "==============================="
	puts forward_prop(known_thetas, [input1, input2])[1][0].round
end
user_test(sThetas)
