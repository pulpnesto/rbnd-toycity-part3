class Product
	attr_reader :title, :price, :stock
	@@products = []

	def initialize(options = {})
		@title = options[:title]
		@price = options[:price]
		@stock = options[:stock]
		add_product
	end

	def add_product
		@@products << self
	end

	def self.all
		@@products
	end

end