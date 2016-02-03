class Product
	attr_reader :title, :price
	attr_accessor :stock
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

	def self.in_stock
		in_stock_products = []
		in_stock_products = @@products.select {|product| product.in_stock? }
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

	def in_stock?
		@stock > 0
	end

	def restock(amount)
		unless in_stock?
			@stock = amount
		end
	end

	def list_customers_by_product
		transactions = Transaction.find_transactions_by_object(self)
		unless transactions.nil?
			puts "--------------------------------------------------------------------"
			puts "Customers who bought #{@title}   |  Price  |  Date"
			puts "--------------------------------------------------------------------"
			transactions.each do |transaction|
				puts "#{transaction.customer.name} | #{transaction.product.price} | #{transaction.date}"
			end
			puts ""
		end
	end

	private

		def add_product
			unless duplicate?
				@@products << self
			end
		end
end