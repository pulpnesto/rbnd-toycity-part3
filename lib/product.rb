class Product
	attr_reader :title, :price, :stock
	@@products = []

	def initialize(options = {})
		@title = options[:title]
		@price = options[:price]
		@stock = options[:stock]
		add_product
	end

	def self.all
		@@products
	end

	def self.find_by_title(title_to_search)
		@@products.each do |product|
			if product.title == title_to_search
				return product
			end
		end
	end

	def duplicate?
		check = []
		check = @@products.select{|product|	product.title == self.title}
		if check.empty?
			false
		else
			raise DuplicateProductError, "#{title} already exists."
		end
	end

	private

		def add_product
			unless duplicate?
				@@products << self
			end
		end
end