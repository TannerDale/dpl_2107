require './lib/book'
require './lib/author'

RSpec.describe Author do
  context 'initialize' do
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})

    it 'exists' do
      expect(charlotte_bronte).to be_a(Author)
    end

    it 'has attributes' do
      expect(charlotte_bronte.name).to eq("Charlotte Bronte")
      expect(charlotte_bronte.books).to be_empty
    end
  end

  context 'book writing' do
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    villette = charlotte_bronte.write("Villette", "1853")

    it 'writes books as Book objects' do
      expect(jane_eyre).to be_a(Book)
    end

    it 'stores written books' do
      expect(charlotte_bronte.books).to eq([jane_eyre, villette])
    end
  end
end
